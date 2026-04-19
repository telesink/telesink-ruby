# Telesink SDK for Ruby

**Know what your product is doing. Right now.**

Official Ruby client for [telesink.com](https://telesink.com) - real-time event
tracking.

**Note**: Low activity here doesn’t mean this is abandoned. It’s intentionally
simple, so there’s not much to change.

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
  event: "User signed up",
  text: "user@example.com",
  emoji: "👤",
  properties: {
    user_id: 123,
    email_address: "user@example.com",
  },
  occurred_at: Time.now,     # optional, defaults to now
  idempotency_key: "my-key", # optional, defaults to random UUID
)
```

**Optional: Sending to a different sink**

Integrations (like
[`telesink-activejob`](https://github.com/telesink/telesink-activejob)) can send
events to a separate sink:

```rb
Telesink.track(
  event: "Job succeeded",
  text: "ProcessUserData",
  emoji: "✅",
  properties: {
    duration_ms: 420
  },

  # falls back to TELESINK_ENDPOINT if not set
  endpoint: ENV["TELESINK_ACTIVEJOB_ENDPOINT"]
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
