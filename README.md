# Telesink SDK for Ruby

Official Ruby client for [telesink.com](https://telesink.com) - real-time event
tracking.

## Requirements

- Ruby 3.0+

## Getting started

### Install

Add to your `Gemfile`:

```ruby
gem "telesink"
```

Then run:

```sh
bundle install
```

### Configuration

```rb
Telesink.init(endpoint: "https://app.telesink.com/api/v1/sinks/your_sink_token_here/events")
```

Optional params with defaults:

```rb
Telesink.init(
  endpoint: "...",
  enabled: true,
  logger: Logger.new(STDERR)
)
```

### Usage

```rb
Telesink.track(
  event: "user.signed.up",
  text: "New user registered",
  emoji: "👤",
  properties: {
    plan: "pro",
    source: "landing_page",
  },
  occurred_at: Time.now,       # optional, defaults to now
  idempotency_key: "my-key",   # optional, defaults to random UUID
)
```

#### Returns

- `true` — event sent successfully
- `false` — disabled, missing endpoint, or network error

Errors are never raised. They are logged and fail silently.

### Testing

```sh
bundle exec rake test
```

### License

MIT (see [LICENSE.md](/LICENSE.md)).
