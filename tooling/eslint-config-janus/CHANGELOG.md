# @janus/eslint-config Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

All JANUS services must consume this package from GitHub Packages. See `standards/engineering/linting-standard.md` in `janus-engineering`.

---

## [Unreleased]

---

## [1.0.0] — 2026-08-06

### Added
- ESLint v9 flat config for JANUS ecosystem services
- TypeScript rules via `@typescript-eslint` (no-explicit-any: error, no-floating-promises: error, strict-boolean-expressions: error)
- Import ordering via `eslint-plugin-import`
- Security rules via `eslint-plugin-security`
- Prettier compatibility via `eslint-config-prettier`
- `no-console: error` enforcement (structured logger required in source files)

[Unreleased]: https://github.com/janus/janus-engineering/compare/tooling/v1.0.0...HEAD
[1.0.0]: https://github.com/janus/janus-engineering/releases/tag/tooling/v1.0.0
