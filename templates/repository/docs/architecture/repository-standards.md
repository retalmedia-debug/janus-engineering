<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/repository-standards.md -->

# Repository Standards

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Required Root Files

| File | Purpose | Mutable by Service? |
|---|---|---|
| `README.md` | Service entry point | Yes |
| `CLAUDE.md` | Claude Code instructions | Yes (fill required) |
| `AGENTS.md` | AI agent instructions | Yes |
| `CHANGELOG.md` | Release history | Yes |
| `.gitignore` | Ignore patterns | Append only |
| `.editorconfig` | Editor config | No — frozen |
| `.janus-compliance.yaml` | Compliance declaration | Yes — update on each suite upgrade |
| `package.json` | Node.js manifest | Yes |
| `pnpm-lock.yaml` | Lockfile | pnpm managed only |
| `.env.example` | Environment variable template | Yes — keep updated |
| `tsconfig.json` | TypeScript config | Extend `@janus/tsconfig` only |
| `eslint.config.js` | ESLint config | Extend `@janus/eslint-config` only |

---

## Environment Variable Convention

| Convention | Rule |
|---|---|
| Prefix | All env vars for this service use `{{SERVICE_ENV_PREFIX}}_` prefix |
| Format | `SCREAMING_SNAKE_CASE` |
| Registration | Every env var must appear in `.env.example` with a description and the `[[FILL: description]]` marker for required values |
| Secrets | Never committed; injected via CI secrets or secret manager |
| Feature flags | `{{SERVICE_ENV_PREFIX}}_FEATURE_{{NAME}}_ENABLED=false` |

---

## `.env.example` Rules

- Every variable the application reads must appear here
- Include a comment for each variable explaining its purpose
- Mark required variables: `# REQUIRED`
- Mark optional variables: `# OPTIONAL — defaults to X`
- Include creation date and planned retire date for feature flags
- Never include real values — use descriptive placeholders

---

## Configuration Loading

[[FILL: Describe how the service loads configuration. Example: "Configuration is loaded via a centralized `src/config/index.ts` module that reads from `process.env` and throws on startup if required variables are missing."]]

---

## Node.js Version

The service targets **Node.js 20 LTS**. The version is pinned in:
- `.nvmrc`: `20`
- CI workflow `node-version` field

Upgrading the Node.js major version requires an ADR.

---

## Package Manager

`pnpm` is mandatory. See `standards/engineering/package-manager-standard.md` in `janus-engineering`. The `pnpm-lock.yaml` lockfile is committed and must remain current.
