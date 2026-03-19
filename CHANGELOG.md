# Telesink Changelog

## master

- Replaced `Telesink.configure` block with `Telesink.init` for simpler setup.
- Removed `Config` class. Options are now set directly on the module.
- Added the `TELESINK_DISABLED` environment variable.

## 1.1.0 - 2026-04-19

- Merged `TELESINK_BASE_URL` and `TELESINK_TOKEN` into `TELESINK_ENDPOINT`.
  Technically, this is a breaking change, but since the backend isn't live yet,
  nobody cares.

## 1.0.3 - 2026-04-18

- Changed `TELESINK_BASE_URL` to point at `app.telesink.com`.

## 1.0.2 - 2026-04-18

- Fixed a bug that prevented Telesink from working due to a missing version require.

## 1.0.1 - 2026-04-18

- Automatically populate `occurred_at` with `Time.now` when it’s not provided, so users don’t have to worry about it.

## 1.0.0 - 2026-04-18

- Initial release.
