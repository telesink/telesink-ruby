# Telesink Changelog

## master

## 1.3.0 - 2026-04-19

- Added optional `endpoint:` keyword argument to `Telesink.track`.
  This allows separate integrations to send events to a different sink while
  keeping the core SDK unchanged and backward-compatible.

## 1.2.0 - 2026-03-19

- Removed `Telesink.configure`.
- Removed `Config` class. Options are now set directly on the module.
- Added the `TELESINK_DISABLED` environment variable.

## 1.1.0 - 2026-03-19

- Merged `TELESINK_BASE_URL` and `TELESINK_TOKEN` into `TELESINK_ENDPOINT`.
  Technically, this is a breaking change, but since the backend isn't live yet,
  nobody cares.

## 1.0.3 - 2026-03-18

- Changed `TELESINK_BASE_URL` to point at `app.telesink.com`.

## 1.0.2 - 2026-03-18

- Fixed a bug that prevented Telesink from working due to a missing version require.

## 1.0.1 - 2026-03-18

- Automatically populate `occurred_at` with `Time.now` when it’s not provided,
  so users don’t have to worry about it.

## 1.0.0 - 2026-03-18

- Initial release.
