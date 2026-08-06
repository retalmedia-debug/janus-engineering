# Supabase Migration Governance

**Suite Version:** 1.0.0
**Binding Level:** Mandatory-if-applicable
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

Applies to: all JANUS services that use Supabase as their database platform.

---

## Purpose

Database migrations are the most consequential and least reversible type of change in a service's lifecycle. A migration that corrupts data or locks a table in production creates incidents that no application code rollback can fix. This standard defines the rules that make Supabase migrations safe across all JANUS services that use this platform.

---

## The Immutability Principle

**Migration files are immutable once merged to `develop`.**

A migration file that has been executed on any shared environment (development, staging, production) is never modified. If a migration contains an error, a new migration is written to correct it.

Modifying an existing migration:
- Will not be applied to environments where it has already run (Supabase tracks applied migrations by filename)
- Creates a checksum mismatch that Supabase's migration tracking detects as corruption
- Creates an inconsistency between local and deployed environments that is difficult to diagnose

This principle is non-negotiable. There are no exceptions.

---

## Migration File Standards

### Naming Convention

```
YYYYMMDDHHMMSS_description-in-kebab-case.sql
```

The timestamp is generated at authoring time, not commit time. Use `supabase migration new <description>` — the Supabase CLI generates the timestamp automatically.

Examples:
```
20260806143000_create-geofences-table.sql
20260806160000_add-spatial-index-to-geofences.sql
20260810090000_add-alert-severity-column.sql
```

### Required Header Comment

Every migration file begins with:

```sql
-- Migration: 20260806143000_create-geofences-table.sql
-- Author: [Name / Role]
-- Date: 2026-08-06
-- Description: Creates the geofences table with PostGIS geometry column and RLS policies.
-- Estimated duration: < 1 second (new table, no existing data)
-- Reversible: Yes — DROP TABLE geofences;
```

### Required Content Structure

1. **Header comment** (as above)
2. **Schema change** — the DDL
3. **RLS configuration** — for any new table: `ALTER TABLE <name> ENABLE ROW LEVEL SECURITY;` plus all initial policies
4. **Down migration** — as a SQL comment block with the exact SQL to reverse this migration, or an explanation of why it is irreversible

---

## Reversibility Assessment

| Change Type | Reversible? | Notes |
|---|---|---|
| `CREATE TABLE` | Yes | `DROP TABLE` |
| `DROP TABLE` | With data loss | Requires prior data archival; not permitted without explicit data retention decision |
| `ADD COLUMN` (nullable) | Yes | `DROP COLUMN` |
| `ADD COLUMN` (NOT NULL with default) | Yes | `DROP COLUMN` |
| `ADD COLUMN` (NOT NULL, no default) | Risky | Reversal may violate constraint |
| `DROP COLUMN` | With data loss | Requires confirmation column is unused by all code and external processes |
| `RENAME TABLE` or `RENAME COLUMN` | Yes | Reverse rename; requires application code coordination |
| `CREATE INDEX` | Yes | `DROP INDEX` |
| `CREATE INDEX CONCURRENTLY` | Yes | `DROP INDEX CONCURRENTLY` |
| `ADD FOREIGN KEY` | Yes | `DROP CONSTRAINT` |
| `DROP FOREIGN KEY` | Yes | Recreate constraint |
| `ALTER COLUMN TYPE` | Data-dependent | May require data conversion; test carefully |
| `CREATE TYPE (ENUM)` | Partial | Adding values is usually fine; removing requires care in pg15+ |
| Backfill `UPDATE` | Data-dependent | Original data must be preserved to reverse |
| `ALTER TABLE ENABLE ROW LEVEL SECURITY` | Yes | `DISABLE ROW LEVEL SECURITY` (not recommended) |
| `CREATE POLICY` | Yes | `DROP POLICY` |

---

## Safety Rules

### Never Lock Large Tables

DDL operations that cause table rewrites acquire locks that block reads and writes for the duration. On tables with significant data, this causes production outages.

Operations that risk long locks on large tables:
- `ALTER COLUMN TYPE` that requires data conversion
- `ADD COLUMN NOT NULL` without a default (pg11 and older behavior; pg12+ handles defaults without table rewrite)
- `ADD CONSTRAINT ... CHECK` without `NOT VALID`

Mitigations:
- Add nullable columns first, backfill in a separate migration, then add the NOT NULL constraint in a third migration
- Use `NOT VALID` for new constraints, then `VALIDATE CONSTRAINT` in a separate step
- Use `CREATE INDEX CONCURRENTLY` instead of `CREATE INDEX` on tables with more than 10,000 rows

### Test Before Submitting a PR

Every migration is applied to a local Supabase instance before the PR is opened:

```bash
supabase db reset    # Apply all migrations from scratch — confirms migration set is coherent
# or
supabase migration up # Apply pending migrations to current local state
```

The CI pipeline applies migrations against a test database as part of the quality gate. CI failure on migration application blocks merge.

### One Concern Per Migration File

Each migration file addresses one logical concern. A migration that creates a table, adds an index, and sets up RLS in the same file is acceptable when those are logically inseparable (e.g., table + RLS is a single atomic concern). A migration that creates two unrelated tables is two migrations that were combined by accident.

### Application Code Backward Compatibility

The database and application code are deployed independently. A migration may run before the new application code is deployed, and the old application code must continue to work against the post-migration schema during the transition window.

Migration design must account for this:
- Adding a column does not break old code (old code ignores it)
- Renaming a column breaks old code that reads the old name — handle with a three-step migration: add new column → copy data → update code → drop old column (separate migrations)
- Dropping a column breaks old code that reads it — ensure application code stops reading the column before the drop migration runs

---

## Migration Review Process

All migrations require review before merging:

1. The PR author includes in the PR description:
   - Migration purpose and what it changes
   - Reversibility assessment
   - Estimated migration duration on production-scale data
   - Risk assessment for running during active traffic
2. A Senior Engineer reviews for correctness, safety, and standards compliance
3. The CSA reviews migrations that:
   - Touch core domain tables
   - Add or modify RLS policies
   - Drop any column or table
   - Change any column type
4. CI applies the migration to a test database and confirms it runs cleanly

---

## Seed Data

Seed data in `supabase/seed/` is for local development only. It is never applied to staging or production.

Seed data standards:
- Use UUIDs that are recognizably test data: `00000000-0000-0000-0000-000000000001`
- Do not reference real people, real locations of operational sensitivity, or real data
- Cover the common development scenarios for the service domain

---

## Emergency Migration Procedure

When a migration must run in production outside the normal release process:

1. Treat it as a hotfix — all hotfix rules apply
2. CSA must approve before execution
3. The migration is tested against a snapshot of the production database
4. A rollback procedure is ready and tested before the migration runs
5. Execution window is the lowest-traffic period available
6. Post-mortem within 48 hours of execution

---

## Migration Tracking

Supabase maintains a `supabase_migrations` schema that records which migrations have been applied. This table is the authoritative record of schema state in any environment. It is never manually modified.
