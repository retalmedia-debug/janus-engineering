<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/operations/configuration-management.md -->

# Configuration Management

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Configuration Principles

1. All configuration comes from environment variables — no hardcoded values
2. The application validates required configuration at startup and fails fast if any required variable is missing
3. `.env.example` is the single source of truth for what variables exist
4. Secrets are never logged, even partially

---

## Environment Variable Prefix

All environment variables owned by this service use the prefix: `{{SERVICE_ENV_PREFIX}}_`

Third-party tool variables (e.g., `SUPABASE_URL`, `RESEND_API_KEY`) use their native names.

---

## Variable Registry

[[FILL: Document every environment variable the service reads. Group by category.]]

### Application

| Variable | Required | Default | Description |
|---|---|---|---|
| `NODE_ENV` | Yes | — | `development` / `test` / `production` |
| `PORT` | No | `3000` | Server listen port |
| `{{SERVICE_ENV_PREFIX}}_LOG_LEVEL` | No | `info` | Log level: `error`, `warn`, `info`, `debug` |
| `[[FILL]]` | | | |

### Database

| Variable | Required | Default | Description |
|---|---|---|---|
| `[[FILL: SUPABASE_URL]]` | Yes | — | [[FILL]] |
| `[[FILL: SUPABASE_ANON_KEY]]` | Yes | — | [[FILL]] |
| `[[FILL: SUPABASE_SERVICE_ROLE_KEY]]` | Yes | — | [[FILL: Never expose client-side]] |

### Feature Flags

| Variable | Required | Default | Description | Created | Retire By |
|---|---|---|---|---|---|
| `[[FILL: {{SERVICE_ENV_PREFIX}}_FEATURE_EXAMPLE_ENABLED]]` | No | `false` | [[FILL]] | [[FILL: YYYY-MM-DD]] | [[FILL: YYYY-MM-DD]] |

---

## Configuration Loading

Configuration is loaded in `[[FILL: src/config/index.ts]]`. The module:

1. Reads from `process.env`
2. Validates required variables using [[FILL: Zod / manual checks]]
3. Throws a descriptive error at startup if validation fails
4. Exports a frozen config object — no re-reading of `process.env` elsewhere

Direct `process.env` access outside the config module is prohibited.

---

## Secret Rotation

When rotating a secret:

1. Add the new secret value alongside the old in the secret manager
2. Deploy the service (it reads both during the overlap window)
3. Remove the old secret after deployment is confirmed stable
4. Update the rotation date in this document
