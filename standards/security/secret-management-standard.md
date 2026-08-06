# Secret Management Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS services
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/security/security-baseline.md` · `standards/engineering/feature-flag-lifecycle.md` · `templates/repository/docs/security/security-baseline.md`

---

## Purpose

Secrets are the most sensitive artifacts in any engineering system. A single leaked credential can compromise an entire service or the whole ecosystem. This standard establishes the definitive rules for secret creation, storage, rotation, auditing, and incident response across all JANUS services.

---

## What Is a Secret

A **secret** is any value that, if exposed to an unauthorized party, could allow unauthorized access to a system, data, or resource.

| Classified as Secret | Not a Secret |
|---|---|
| Database connection strings and passwords | Environment names (`production`, `staging`) |
| API keys and access tokens | Feature flag names |
| JWT signing secrets and private keys | Log level configuration |
| OAuth client secrets | Public API base URLs |
| Service account credentials | Public configuration (page sizes, timeouts) |
| Encryption keys | Non-sensitive default values |
| Private TLS certificates | |
| Webhook signing secrets | |

---

## The Absolute Rules

These rules have no exceptions. Any deviation is a security incident:

1. **No secrets in source code** — ever, including in comments
2. **No secrets in `.env` files committed to the repository** — `.env*` is gitignored; only `.env.example` (with placeholder values) is committed
3. **No secrets in CI/CD workflow files** — inject via CI secrets, never hardcode
4. **No secrets in log output** — never log a credential, even partially (first N characters is still a violation)
5. **No secrets in error messages** — API error responses never include credential values
6. **No secrets in documentation** — examples use placeholder values like `[YOUR_API_KEY]`
7. **No secrets in AI prompts** — Claude Code, Cursor, ChatGPT, or any AI tool must never receive a real secret value

---

## Secret Storage Requirements

| Environment | Approved Secret Storage |
|---|---|
| Local development | `.env.local` (never committed) |
| CI/CD pipeline | GitHub Actions secrets |
| Staging | Approved secret manager (see ADR for service-specific decision) |
| Production | Approved secret manager (see ADR for service-specific decision) |

Each service must document its secret storage approach in `docs/security/security-baseline.md`.

---

## Secret Naming Convention

Secrets follow the same environment variable naming convention:

```
{{SERVICE_ENV_PREFIX}}_{{COMPONENT}}_{{CREDENTIAL_TYPE}}
```

Examples:
- `ATLAS_SUPABASE_SERVICE_ROLE_KEY`
- `ATLAS_RESEND_API_KEY`
- `GCS_JWT_SIGNING_SECRET`

---

## Rotation Policy

| Secret Type | Maximum Lifetime | Rotation Trigger |
|---|---|---|
| JWT signing secret | 90 days | Calendar + breach |
| Database password | 90 days | Calendar + breach |
| API key (third-party) | Per provider recommendation, max 1 year | Calendar + breach + provider revocation |
| Service account credentials | 180 days | Calendar + personnel change + breach |
| TLS private key | Certificate validity, max 1 year | Expiry + breach |
| Webhook signing secret | 180 days | Calendar + breach |

Rotation must be performed **without downtime** using an overlap window:
1. Add new secret alongside old in secret manager
2. Deploy service (reads both, accepts either)
3. Confirm deployment stable
4. Remove old secret
5. Confirm service still operational

---

## Secret Discovery and Breach Response

### If a secret is found in code, logs, or an unintended location:

**The clock starts immediately.** Do not wait to confirm impact.

1. **Rotate the secret within 1 hour** — revoke or replace, do not "invalidate later"
2. **Notify the Service CSA and Security Lead** — simultaneously, not sequentially
3. **Audit access logs** for use of the exposed credential — what was it used for after exposure?
4. **Open a P0 security incident issue** — private, not public
5. **Remove the secret from its unintended location** — purge from git history if in a commit (requires force push to all branches — this is one of the only authorized force push scenarios)
6. **File a post-mortem** within 48 hours

### Git History Purge (for secrets committed to a repository)

If a secret is committed to git:

```bash
# Remove the secret from git history using git-filter-repo
# This requires force push to all branches — authorized only for security incidents
git filter-repo --path-glob '*.env' --invert-paths --force
# or use BFG Repo Cleaner for large repositories
```

All collaborators must re-clone after a history rewrite. GitHub support must be notified to purge caches.

---

## Auditing

Every service must maintain an auditable list of secrets in `docs/security/security-baseline.md`:

| Secret Name | Purpose | Storage | Last Rotated | Rotate By |
|---|---|---|---|---|
| [Name] | [What it grants access to] | [Where stored] | YYYY-MM-DD | YYYY-MM-DD |

This table is reviewed monthly by the CSA and quarterly by the Security Lead.

---

## Access Principle

Access to production secrets follows least privilege:

- **No developer has direct access to production secrets by default**
- Access is granted by the CSA for a specific purpose, for a specific duration
- Emergency "break glass" access is logged and reviewed after the fact
- Service accounts have only the minimum permissions needed for their function
