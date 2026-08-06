<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/engineering/coding-standards.md -->

# Coding Standards

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## JANUS Engineering Standards Reference

The following JANUS standards apply to all code in {{SERVICE_NAME}}. They are authoritative. This document adds service-specific context only — it does not override the standards.

| Standard | Applies To |
|---|---|
| `standards/engineering/typescript-baseline.md` | All TypeScript code |
| `standards/engineering/linting-standard.md` | All source files |
| `standards/engineering/formatter-standard.md` | All source files |
| `standards/engineering/package-manager-standard.md` | Dependency management |
| `standards/engineering/dependency-governance.md` | All dependencies |
| `standards/engineering/refactoring-policy.md` | All refactoring work |
| `standards/engineering/technical-debt-policy.md` | All debt decisions |

---

## TypeScript Configuration

This service extends `@janus/tsconfig`:

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

`strict: true` is non-negotiable. See the JANUS TypeScript standard for the full ruleset.

---

## Service-Specific Conventions

[[FILL: Document any conventions specific to this service. Examples:
- File naming conventions (e.g., "all API handlers end in .handler.ts")
- Layer separation rules (e.g., "repositories may not import from the API layer")
- Error handling patterns specific to this service's tech stack
- Specific patterns the team has adopted (e.g., Result types instead of throw/catch)

If the JANUS standards already cover a topic, reference them instead of duplicating.]]

### [[FILL: Convention Category]]

[[FILL: Description and examples]]

---

## What Requires a Code Review Comment

The following patterns in code review must be addressed before merge (not just nits):

- `any` type without a comment explaining why inference fails
- `as` type assertion on user input or external data
- Missing error handling on `async` function calls
- Direct `process.env` access outside the config module
- [[FILL: Add service-specific mandatory review items]]
