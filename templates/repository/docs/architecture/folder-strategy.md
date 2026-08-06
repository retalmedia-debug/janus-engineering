<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/folder-strategy.md -->

# Folder Strategy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Repository Root Structure

```
{{SERVICE_REPO}}/
├── docs/                   # All documentation — no application code
│   ├── governance/
│   ├── architecture/
│   ├── engineering/
│   ├── testing/
│   ├── security/
│   ├── operations/
│   ├── ai-collaboration/
│   ├── database/
│   └── api/
├── src/                    # Application source code
│   [[FILL: expand below]]
├── tests/                  # Test files
│   [[FILL: expand below]]
├── .github/                # GitHub Actions and templates
├── scripts/                # Developer utility scripts (not deployed)
└── [root config files]
```

---

## Source Code Structure (`src/`)

[[FILL: Document the source directory structure. Every top-level directory under src/ should appear here with a description. Below is an example structure — replace with the actual structure for this service.]]

```
src/
├── [[FILL: e.g., api/]]           # [[FILL: Route handlers / controllers]]
├── [[FILL: e.g., services/]]      # [[FILL: Domain logic]]
├── [[FILL: e.g., repositories/]]  # [[FILL: Data access layer]]
├── [[FILL: e.g., types/]]         # [[FILL: TypeScript types and interfaces]]
├── [[FILL: e.g., utils/]]         # [[FILL: Pure utility functions]]
└── [[FILL: e.g., config/]]        # [[FILL: Environment config and constants]]
```

---

## Test Structure (`tests/`)

```
tests/
├── unit/           # Unit tests — isolated, no I/O
├── integration/    # Integration tests — real database, no mocked I/O
└── e2e/            # End-to-end tests — full stack
```

Test files mirror the `src/` structure within their category. For example, `src/services/user.ts` has its unit test at `tests/unit/services/user.test.ts`.

---

## Naming Conventions

| File Type | Convention | Example |
|---|---|---|
| TypeScript source | kebab-case | `user-profile.ts` |
| Test files | `[name].test.ts` | `user-profile.test.ts` |
| Type definition files | kebab-case | `user-types.ts` |
| Config files | kebab-case | `database-config.ts` |
| Constants | kebab-case | `http-status.ts` |

---

## What Does Not Belong in `src/`

- Database migration files (go in `supabase/migrations/` or equivalent)
- Test fixtures (go in `tests/fixtures/`)
- Generated code (go in designated generated/ directory, gitignored if generated at build time)
- Static assets served directly (go in `public/` or equivalent)

---

## Evolving This Structure

Changes to the top-level structure of `src/` require a PR with CSA approval and an update to this document. See `docs/governance/repository-evolution-policy.md`.
