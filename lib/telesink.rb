# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "securerandom"
require "logger"

require_relative "telesink/version"

module Telesink
  LOG = ::Logger.new(STDERR)

  class << self
    def track(event:, text:, emoji: nil, properties: {}, occurred_at: nil, idempotency_key: nil)
      return false unless enabled? && endpoint

      payload = {
        event: event,
        text: text,
        emoji: emoji,
        properties: properties,
        occurred_at: (occurred_at || Time.now).utc.iso8601,
        idempotency_key: idempotency_key || SecureRandom.uuid,
        sdk: { name: "telesink.ruby", version: VERSION }
      }.compact

      uri = URI(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = http.read_timeout = 3
      http.write_timeout = 3 if http.respond_to?(:write_timeout)

      req = Net::HTTP::Post.new(uri)
      req["Content-Type"] = "application/json"
      req["User-Agent"] = "telesink.ruby/#{VERSION}"
      req["Idempotency-Key"] = payload[:idempotency_key]
      req.body = payload.to_json

      http.request(req).is_a?(Net::HTTPSuccess)
    rescue => e
      logger.error("[Telesink] #{e.class}: #{e.message}")
      false
    end

    private

    def endpoint = ENV["TELESINK_ENDPOINT"]
    def enabled? = ENV["TELESINK_DISABLED"].to_s.empty?
    def logger = LOG
  end
end
