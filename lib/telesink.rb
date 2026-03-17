# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "securerandom"
require "logger"

module Telesink
  class Config
    attr_accessor :token, :base_url, :enabled, :logger

    def initialize
      @base_url = ENV.fetch("TELESINK_BASE_URL", "https://telesink.com")
      @token = ENV["TELESINK_TOKEN"]
      @enabled = true
      @logger = ::Logger.new(STDERR)
    end
  end

  class << self
    attr_writer :config

    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

    def track(
      event:,
      text:,
      emoji: nil,
      properties: {},
      occurred_at: nil,
      idempotency_key: nil
    )
      return false unless config.enabled
      return false if config.token.to_s.strip.empty?

      payload = {
        event: event,
        text: text,
        emoji: emoji,
        properties: properties,
        occurred_at: occurred_at&.utc&.iso8601,
        idempotency_key: (idempotency_key.to_s.empty? ? SecureRandom.uuid : idempotency_key),
        sdk: {
          name:    "telesink.ruby",
          version: VERSION
        }
      }.compact

      safely_send_event(payload, payload[:idempotency_key])
      true
    end

    private

    def safely_send_event(payload, idempotency_key)
      send_event(payload, idempotency_key)
    rescue Net::OpenTimeout,
           Net::ReadTimeout,
           Net::WriteTimeout,
           SocketError,
           SystemCallError,
           IOError,
           Errno::ECONNREFUSED,
           Errno::ECONNRESET => e
      config.logger.error("[Telesink] Network error sending '#{payload[:event]}': #{e.class} - #{e.message}")
    rescue => e
      config.logger.error("[Telesink] Unexpected error sending '#{payload[:event]}': #{e.class} - #{e.message}")
    end

    def send_event(payload, idempotency_key)
      uri = URI("#{config.base_url}/api/v1/sinks/#{config.token}/events")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.open_timeout = 3
      http.read_timeout = 3
      http.write_timeout = 3 if http.respond_to?(:write_timeout)

      request = Net::HTTP::Post.new(uri)
      request["Content-Type"] = "application/json"
      request["User-Agent"] = "telesink.ruby/#{VERSION}"
      request["Idempotency-Key"] = idempotency_key

      request.body = payload.to_json

      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        config.logger.warn("[Telesink] API returned #{response.code} for event '#{payload[:event]}'")
      end

      response
    end
  end
end
