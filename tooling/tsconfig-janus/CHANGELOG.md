# @janus/tsconfig Changelog

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

All JANUS services must consume this package from GitHub Packages. See `standards/engineering/typescript-baseline.md` in `janus-engineering`.

---

## [Unreleased]

---

## [1.0.0] — 2026-08-06

### Added
- `base.json`: JANUS TypeScript base configuration. Target: ES2022. Module: ESNext. strict: true (non-negotiable). noUncheckedIndexedAccess: true. noImplicitOverride: true. exactOptionalPropertyTypes: true. verbatimModuleSyntax: true.
- `strict.json`: Extends base.json with additional strictness: noUnusedLocals, noUnusedParameters, noFallthroughCasesInSwitch, useUnknownInCatchVariables.

[Unreleased]: https://github.com/janus/janus-engineering/compare/tooling/v1.0.0...HEAD
[1.0.0]: https://github.com/janus/janus-engineering/releases/tag/tooling/v1.0.0
