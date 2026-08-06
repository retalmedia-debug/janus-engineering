# Linting Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Decision

All JANUS services use **ESLint** (v9+ flat config) as the linting standard.

The canonical JANUS ESLint configuration is published as `@janus/eslint-config`.

---

## Required Configuration

**`eslint.config.mjs`:**
```javascript
import janusConfig from '@janus/eslint-config'

export default [
  ...janusConfig,
  {
    // Service-specific rules only — override nothing in janusConfig without ADR
    rules: {}
  }
]
```

Services do not disable rules from `@janus/eslint-config` without:
1. A documented reason in an ADR or inline comment
2. CSA approval

---

## The `@janus/eslint-config` Package

The JANUS base ESLint configuration includes:

```javascript
// tooling/eslint-config-janus/index.js
import js from '@eslint/js'
import tsPlugin from '@typescript-eslint/eslint-plugin'
import tsParser from '@typescript-eslint/parser'
import importPlugin from 'eslint-plugin-import'
import securityPlugin from 'eslint-plugin-security'

export default [
  js.configs.recommended,
  {
    files: ['**/*.{ts,tsx}'],
    languageOptions: {
      parser: tsParser,
      parserOptions: {
        projectService: true,
      },
    },
    plugins: {
      '@typescript-eslint': tsPlugin,
      'import': importPlugin,
      'security': securityPlugin,
    },
    rules: {
      // TypeScript
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/no-non-null-assertion': 'warn',
      '@typescript-eslint/explicit-function-return-type': 'error',
      '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      '@typescript-eslint/consistent-type-imports': 'error',
      '@typescript-eslint/no-floating-promises': 'error',
      '@typescript-eslint/await-thenable': 'error',
      '@typescript-eslint/no-misused-promises': 'error',

      // Imports
      'import/order': ['error', {
        'groups': ['builtin', 'external', 'internal', 'parent', 'sibling', 'index'],
        'newlines-between': 'always',
        'alphabetize': { order: 'asc' }
      }],
      'import/no-cycle': 'error',
      'import/no-self-import': 'error',

      // Security
      'security/detect-object-injection': 'warn',
      'security/detect-non-literal-regexp': 'warn',
      'security/detect-unsafe-regex': 'error',

      // General
      'no-console': 'error',
      'no-debugger': 'error',
      'eqeqeq': ['error', 'always'],
      'no-var': 'error',
      'prefer-const': 'error',
    }
  }
]
```

---

## Lint Execution

**Pre-commit:** `lint-staged` runs ESLint on staged files. Lint failures block the commit.

**CI gate:** ESLint runs as a mandatory CI gate. A lint error blocks PR merge. No bypassing.

**IDE integration:** Engineers configure their IDE to run ESLint on save. This is expected practice, not optional preference.

---

## `no-console` Enforcement

`console.log` is prohibited in production code. All logging goes through the service's structured logger (defined in `docs/operations/logging-standards.md` in each service).

Exception: scripts in `scripts/` may use `console.log` for CLI output.

---

## Overriding Rules

Service-specific rule overrides are permitted only in files that genuinely require them (test files, scripts, generated code). Global overrides to `@janus/eslint-config` rules require:

1. A documented reason (inline comment for file-level overrides, ADR for global overrides)
2. CSA approval for global overrides
3. The override is as narrow as possible — disable for the specific line, not the file; for the file, not the project

`eslint-disable-next-line` comments must include the rule name. `eslint-disable` without a rule name is not permitted.
