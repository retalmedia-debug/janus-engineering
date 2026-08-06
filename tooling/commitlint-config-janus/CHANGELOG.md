# @janus/commitlint-config Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

All JANUS services must consume this package from GitHub Packages. See `standards/engineering/git-strategy.md` in `janus-engineering`.

---

## [Unreleased]

---

## [1.0.0] — 2026-08-06

### Added
- Extends @commitlint/config-conventional with JANUS-specific configuration
- Header max length: 100 characters
- 13 JANUS commit types: feat, fix, docs, style, refactor, perf, test, chore, ci, revert, security, migration, deps
- Scope and subject enforced lowercase
- Subject must not end with a period

[Unreleased]: https://github.com/janus/janus-engineering/compare/tooling/v1.0.0...HEAD
[1.0.0]: https://github.com/janus/janus-engineering/releases/tag/tooling/v1.0.0
