# @janus/eslint-config

JANUS ecosystem ESLint configuration. Governs all JANUS services using ESLint v9+ flat config.

Standard: `standards/engineering/linting-standard.md` in `janus-engineering`

## Installation

```bash
pnpm add -D @janus/eslint-config eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-import eslint-plugin-security eslint-config-prettier
```

## Usage

Create `eslint.config.js` in your service root:

```js
import janusConfig from '@janus/eslint-config'

export default [
  ...janusConfig,
  {
    // Service-specific overrides only — discuss with CSA before adding
    rules: {}
  }
]
```

## What Is Included

- TypeScript rules via `@typescript-eslint` (no-explicit-any, no-floating-promises, etc.)
- Import ordering via `eslint-plugin-import`
- Security rules via `eslint-plugin-security`
- Prettier compatibility via `eslint-config-prettier`
- `no-console` enforcement (use structured logger)

## Rules You Cannot Override

Per `standards/engineering/linting-standard.md`, these rules are non-negotiable:

- `@typescript-eslint/no-explicit-any: error`
- `@typescript-eslint/no-floating-promises: error`
- `no-console: error` (in source files)

Service-specific overrides for legitimate `any` use cases must use inline `// eslint-disable-next-line` with a comment explaining why.

## Changelog

### 1.0.0 — 2026-08-06

Initial release. ESLint v9 flat config with TypeScript, import, security, and Prettier rules.
