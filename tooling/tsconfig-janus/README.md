# @janus/tsconfig

JANUS ecosystem TypeScript base configurations.

Standard: `standards/engineering/typescript-baseline.md` in `janus-engineering`

## Installation

```bash
pnpm add -D @janus/tsconfig typescript
```

## Available Configs

### `@janus/tsconfig/base.json`

The JANUS base TypeScript config. Use for all services.

```json
{
  "extends": "@janus/tsconfig/base.json",
  "compilerOptions": {
    "outDir": "dist",
    "rootDir": "src"
  },
  "include": ["src"]
}
```

### `@janus/tsconfig/strict.json`

Extends `base.json` with additional strictness: `noUnusedLocals`, `noUnusedParameters`, `noFallthroughCasesInSwitch`, `useUnknownInCatchVariables`.

Use for new services. Use `base.json` temporarily when migrating an existing codebase.

```json
{
  "extends": "@janus/tsconfig/strict.json",
  "compilerOptions": {
    "outDir": "dist",
    "rootDir": "src"
  },
  "include": ["src"]
}
```

## What Is Enabled

All configs include:
- `strict: true` — non-negotiable
- `noUncheckedIndexedAccess: true`
- `noImplicitOverride: true`
- `exactOptionalPropertyTypes: true`
- `skipLibCheck: false` — dependency types must be correct
- `verbatimModuleSyntax: true`

## What Cannot Be Disabled

`strict: true` is non-negotiable. Services may not set `strict: false` or disable individual strict flags without an approved service-level ADR.

## Changelog

### 1.0.0 — 2026-08-06

Initial release. `base.json` and `strict.json` targeting ES2022/ESNext.
