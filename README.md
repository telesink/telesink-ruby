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

Set the environment variable:

```sh
export TELESINK_ENDPOINT=https://app.telesink.com/api/v1/sinks/your_sink_token_here/events
```

To disable tracking (e.g. in test/dev):

```sh
export TELESINK_DISABLED=true
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
  occurred_at: Time.now,     # optional, defaults to now
  idempotency_key: "my-key", # optional, defaults to random UUID
)
```

#### Returns

- `true` — event sent successfully
- `false` — disabled, missing endpoint, or network error

Errors are never raised. They are logged to STDERR and fail silently.

### Testing

```sh
bundle exec rake test
```

### License

MIT (see [LICENSE.md](/LICENSE.md)).
