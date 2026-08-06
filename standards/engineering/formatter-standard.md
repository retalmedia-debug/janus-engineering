# Formatter Standard

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Decision

All JANUS services use **Prettier** as the code formatter.

The canonical JANUS Prettier configuration is published as `@janus/prettier-config`.

Formatter options are **frozen**. They are not subject to team preference or negotiation. The value of a formatter is consistency — and consistency requires that configuration not drift per-engineer or per-service. When formatting is consistent across all JANUS services, engineers move between repositories without context-switching on code style.

---

## Configuration

**`.prettierrc.json`:**
```json
"@janus/prettier-config"
```

No service overrides `@janus/prettier-config`. If a specific file type requires different formatting, this is resolved by updating `@janus/prettier-config` through the standard RFC process, not by local overrides.

---

## The `@janus/prettier-config` Package

```json
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "always",
  "endOfLine": "lf",
  "overrides": [
    {
      "files": "*.json",
      "options": { "printWidth": 80 }
    },
    {
      "files": "*.md",
      "options": { "printWidth": 120, "proseWrap": "always" }
    },
    {
      "files": "*.sql",
      "options": { "printWidth": 120 }
    }
  ]
}
```

---

## Format Execution

**Pre-commit:** `lint-staged` runs Prettier on staged files. Formatting differences are applied automatically before the commit is recorded.

**CI gate:** Prettier's `--check` flag runs as a mandatory CI gate. A formatting difference blocks PR merge.

**IDE integration:** Engineers configure their IDE to format on save using Prettier. This eliminates the pre-commit surprise of "everything reformatted."

---

## Prettier vs ESLint

Prettier handles formatting. ESLint handles code quality. They do not overlap when configured correctly.

- ESLint rules that conflict with Prettier (e.g., `max-len`) are disabled in `@janus/eslint-config` — Prettier owns line length decisions
- `eslint-config-prettier` is included in `@janus/eslint-config` to disable any remaining conflicts
- Do not configure ESLint to enforce formatting rules

---

## `.prettierignore`

Each service maintains a `.prettierignore` for generated files that should not be formatted:

```
node_modules/
dist/
build/
.next/
pnpm-lock.yaml
*.generated.ts
supabase/functions/_shared/generated/
```

Do not add source files to `.prettierignore`. If a source file looks wrong after Prettier runs, the code structure should change, not the formatter configuration.
