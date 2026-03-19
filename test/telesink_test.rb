# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/telesink"

class TelesinkTest < Minitest::Test
  def setup
    Telesink.instance_variable_set(:@config, nil)
  end

  def test_config_defaults_and_env_vars
    ENV["TELESINK_ENDPOINT"] = "https://custom.example.com/api/v1/sinks/env-token-123/events"

    config = Telesink.config
    assert_equal "https://custom.example.com/api/v1/sinks/env-token-123/events", config.endpoint
    assert config.enabled
    assert_instance_of ::Logger, config.logger
  end

  def test_configure_block_overrides_everything
    Telesink.configure do |c|
      c.endpoint = "https://test.local/api/v1/sinks/configured-token/events"
      c.enabled  = false
    end

    config = Telesink.config
    assert_equal "https://test.local/api/v1/sinks/configured-token/events", config.endpoint
    assert_equal false, config.enabled
  end
end
