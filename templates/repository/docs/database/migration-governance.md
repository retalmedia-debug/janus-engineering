<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/database/migration-governance.md -->

# Migration Governance

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS migration standard: `standards/database/supabase-migration-governance.md` in `janus-engineering`

---

## Platform

[[FILL: Supabase / Other. If Other, note which migration tool is used and reference the ADR.]]

---

## Migration Location

All migration files live in:

```
[[FILL: supabase/migrations/]] or [[FILL: other path]]
```

---

## Naming Convention

```
YYYYMMDDHHMMSS_description-in-kebab-case.sql
```

Example: `20260806143000_add-created-by-to-events.sql`

The timestamp uses UTC. Generate it with: `date -u +"%Y%m%d%H%M%S"`

---

## Required Migration Header

Every migration file must begin with:

```sql
-- Migration: YYYYMMDDHHMMSS_description-in-kebab-case.sql
-- Author: [Name]
-- Date: YYYY-MM-DD
-- Description: [One-sentence description]
-- Reversible: [Yes — see rollback below / No — <reason why>]
-- Application backward compatible: [Yes / No — if No, coordinate with deployment]
```

---

## Immutability Rule

**Migration files are immutable once applied to any non-local environment.**

If a mistake is made in a migration:
- Create a new corrective migration
- Document the correction in the new migration's header
- Never edit the original file

---

## Review Requirements

| Migration Type | Reviewer |
|---|---|
| Adding columns (nullable) | 1 engineer |
| Adding tables | CSA |
| Core table structural changes | CSA + Senior Engineer |
| RLS policy changes | CSA |
| Dropping columns or tables | CSA + Principal Architect (destructive) |
| Index changes on large tables | CSA (performance impact) |

---

## Testing Migrations

Before opening a PR:

1. Apply to a clean local database: `supabase db reset`
2. Confirm the application starts and passes tests
3. If `Reversible: Yes`, test the rollback

---

## Deployment

Migrations are applied automatically during deployment via [[FILL: Supabase CLI in CI / `supabase db push` / other mechanism]].

The deployment CI job fails if migration application fails. No manual intervention is applied to production migrations without CSA and Principal Architect approval.

---

## Emergency Migration Procedure

If a migration must be applied to production outside the normal CI process:

1. CSA approves in writing (GitHub comment on the issue)
2. Principal Architect notified
3. Applied manually via [[FILL: Supabase dashboard / CLI with production credentials]]
4. CI run triggered immediately after to verify state
5. Post-mortem written within 24 hours explaining why emergency was necessary
