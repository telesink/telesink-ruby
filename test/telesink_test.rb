# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/telesink"

class TelesinkTest < Minitest::Test
  def setup
    Telesink.instance_variable_set(:@endpoint, nil)
    Telesink.instance_variable_set(:@enabled, nil)
    Telesink.instance_variable_set(:@logger, nil)
  end

  def test_init_sets_endpoint
    Telesink.init(endpoint: "https://example.com/events")
    assert_equal "https://example.com/events", Telesink.instance_variable_get(:@endpoint)
  end

  def test_init_defaults
    Telesink.init(endpoint: "https://example.com/events")
    assert Telesink.instance_variable_get(:@enabled)
    assert_instance_of ::Logger, Telesink.instance_variable_get(:@logger)
  end

  def test_track_returns_false_when_disabled
    Telesink.init(endpoint: "https://example.com/events", enabled: false)
    assert_equal false, Telesink.track(event: "test", text: "hello")
  end

  def test_track_returns_false_without_endpoint
    Telesink.init(endpoint: nil)
    assert_equal false, Telesink.track(event: "test", text: "hello")
  end
end
