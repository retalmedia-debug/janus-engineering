# @janus/prettier-config

JANUS ecosystem Prettier configuration. This configuration is frozen — no service may override it.

Standard: `standards/engineering/formatter-standard.md` in `janus-engineering`

## Installation

```bash
pnpm add -D @janus/prettier-config prettier
```

## Usage

In `package.json`:

```json
{
  "prettier": "@janus/prettier-config"
}
```

Do not create a `.prettierrc` or `prettier.config.js` file. The `package.json` reference is the only permitted form.

## Configuration

```json
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "endOfLine": "lf"
}
```

Plus overrides: JSON files use `printWidth: 80`, Markdown uses `printWidth: 120` with `proseWrap: always`.

## Why Frozen

The JANUS formatter standard is frozen to eliminate formatting debates. All JANUS services produce identically formatted code, which means:
- Cross-service code review has no cognitive formatting overhead
- `git blame` is not polluted by formatting-only commits
- AI tools produce code in a predictable style

## Changelog

### 1.0.0 — 2026-08-06

Initial release.
