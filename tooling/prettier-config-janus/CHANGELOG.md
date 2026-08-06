# @janus/prettier-config Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

All JANUS services must consume this package from GitHub Packages. See `standards/engineering/formatter-standard.md` in `janus-engineering`.

This configuration is frozen. Services may not override it. A MAJOR version bump signals a configuration change (rare — requires JAC approval).

---

## [Unreleased]

---

## [1.0.0] — 2026-08-06

### Added
- Initial frozen Prettier configuration: semi: false, singleQuote: true, trailingComma: all, printWidth: 100, tabWidth: 2, useTabs: false, endOfLine: lf
- JSON override: printWidth: 80
- Markdown override: printWidth: 120, proseWrap: always

[Unreleased]: https://github.com/janus/janus-engineering/compare/tooling/v1.0.0...HEAD
[1.0.0]: https://github.com/janus/janus-engineering/releases/tag/tooling/v1.0.0
