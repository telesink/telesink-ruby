# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/telesink"

class TelesinkTest < Minitest::Test
  def setup
    ENV.delete("TELESINK_ENDPOINT")
    ENV.delete("TELESINK_DISABLED")
  end

  def test_track_returns_false_without_endpoint
    assert_equal false, Telesink.track(event: "test", text: "hello")
  end

  def test_track_returns_false_when_disabled
    ENV["TELESINK_ENDPOINT"] = "https://example.com/events"
    ENV["TELESINK_DISABLED"] = "true"
    assert_equal false, Telesink.track(event: "test", text: "hello")
  end

  def test_track_sends_event
    ENV["TELESINK_ENDPOINT"] = "https://example.com/events"

    response = Minitest::Mock.new
    response.expect(:is_a?, true, [Net::HTTPSuccess])

    http = Minitest::Mock.new
    http.expect(:use_ssl=, nil, [true])
    http.expect(:open_timeout=, nil, [3])
    http.expect(:read_timeout=, nil, [3])
    http.expect(:request, response, [Net::HTTP::Post])

    Net::HTTP.stub(:new, http) do
      assert_equal true, Telesink.track(event: "test", text: "hello")
    end
  end
end
