# Telesink SDK for Ruby

Official Ruby client for [telesink.com](https://telesink.com) - real-time event tracking.

## Requirements

- Ruby 3.0+

## Getting started

### Install

Add this line to your application's `Gemfile`:

```ruby
gem "telesink"
```

Then run:

```sh
bundle install
```

### Configuration

#### Recommended: Environment Variables (zero-code setup)

```sh
export TELESINK_TOKEN=your_sink_token_here
# Optional:
# export TELESINK_BASE_URL=https://custom.telesink.com
```

The SDK automatically reads these.

#### Explicit configuration

```rb
require "telesink"

Telesink.configure do |config|
  config.token = <sink-token>              # required
  config.base_url = "https://telesink.com" # default
  config.enabled = true                    # default
  config.logger = Logger.new(STDERR)
end
```

### Usage

```rb
Telesink.track(
  event: "user.signed.up",
  text: "New user registered",
  emoji: "🎉",
  properties: { plan: "pro", source: "landing_page" },
  occurred_at: Time.now, # optional, auto-converted to UTC ISO8601
  idempotency_key: "my-custom-key" # optional, auto-generated UUID if omitted
)
```

#### Returns

- `true` - request was sent
- `false` - disabled or missing token

Failures are never raised. They are logged via your configured logger and fail silently.

### Testing

```
bundle exec rake test
```

### License

MIT (see [LICENSE.md](/LICENSE.md)).
