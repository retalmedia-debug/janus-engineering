# @janus/commitlint-config

JANUS ecosystem commitlint configuration. Enforces Conventional Commits with JANUS-specific types and scopes.

Standard: `standards/engineering/git-strategy.md` in `janus-engineering`

## Installation

```bash
pnpm add -D @janus/commitlint-config @commitlint/cli
```

## Usage

Create `commitlint.config.js`:

```js
export default {
  extends: ['@janus/commitlint-config']
}
```

Or in `package.json`:

```json
{
  "commitlint": {
    "extends": ["@janus/commitlint-config"]
  }
}
```

## Configuration

Extends `@commitlint/config-conventional` with JANUS additions:

- Header max length: 100 characters
- Type enum (13 types): `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `revert`, `security`, `migration`, `deps`
- Scope and subject must be lowercase
- Subject must not end with a period

## CI Integration

Add to your CI workflow:

```yaml
- name: Lint commit messages
  run: pnpm commitlint --from HEAD~1 --to HEAD
```

## Pre-commit Hook

Via `.husky/commit-msg`:

```bash
pnpm commitlint --edit "$1"
```

## Changelog

### 1.0.0 — 2026-08-06

Initial release. 13 JANUS commit types including `security` and `migration`.
