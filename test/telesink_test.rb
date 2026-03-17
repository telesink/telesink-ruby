# test/telesink_test.rb
# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/telesink"

class TelesinkTest < Minitest::Test
  def setup
    Telesink.instance_variable_set(:@config, nil)  # reset config
  end

  def test_config_defaults_and_env_vars
    ENV["TELESINK_TOKEN"] = "env-token-123"
    ENV["TELESINK_BASE_URL"] = "https://custom.example.com"

    config = Telesink.config
    assert_equal "https://custom.example.com", config.base_url
    assert_equal "env-token-123", config.token
    assert config.enabled
    assert_instance_of ::Logger, config.logger
  end

  def test_configure_block_overrides_everything
    Telesink.configure do |c|
      c.token    = "configured-token"
      c.base_url = "https://test.local"
      c.enabled  = false
    end

    config = Telesink.config
    assert_equal "configured-token", config.token
    assert_equal "https://test.local", config.base_url
    assert_equal false, config.enabled
  end
end
