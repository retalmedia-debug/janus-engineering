<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/database/database-governance.md -->

# Database Governance

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Database Platform

**Platform:** [[FILL: Supabase (PostgreSQL) / Other — if Other, explain ADR decision]]
**ADR reference:** [[FILL: Link to ADR if a platform was chosen over alternatives]]

---

## Schema Ownership

{{SERVICE_NAME}} owns its schema completely. No other JANUS service reads directly from this service's database. Integration is through the API only.

**Schema name:** [[FILL: public / custom schema name]]

---

## Migration Governance

JANUS migration standard: `standards/database/supabase-migration-governance.md` in `janus-engineering`
Service detail: `docs/database/migration-governance.md`

Summary of non-negotiable rules:
- Migrations are immutable once applied — never modify an existing migration file
- Naming: `YYYYMMDDHHMMSS_description-in-kebab-case.sql`
- One concern per file
- Application must remain backward compatible with the previous migration state

---

## Row Level Security

[[FILL: Document the RLS policy approach for this service.]]

| Table | RLS Enabled | Policy Summary |
|---|---|---|
| [[FILL]] | [[FILL: Yes / No]] | [[FILL: e.g., "Users can only read their own rows; admins can read all"]] |

RLS policies must be reviewed by the CSA before any table containing user data is deployed.

---

## Data Access Patterns

[[FILL: Document how the application accesses the database. This informs indexing decisions and query optimization.]]

| Operation | Table(s) | Access Pattern | Index Required |
|---|---|---|---|
| [[FILL: e.g., Fetch user by ID]] | [[FILL: users]] | [[FILL: PK lookup]] | [[FILL: Covered by PK]] |
| [[FILL: List events by user]] | [[FILL: events]] | [[FILL: Filter + sort]] | [[FILL: idx_events_user_id_created_at]] |

---

## Naming Conventions

| Object | Convention | Example |
|---|---|---|
| Tables | `snake_case`, plural | `user_profiles`, `audit_events` |
| Columns | `snake_case` | `created_at`, `user_id` |
| Indexes | `idx_table_column(s)` | `idx_events_user_id` |
| Functions | `snake_case`, verb | `get_user_by_email()` |
| Triggers | `trg_table_action` | `trg_users_on_update` |

---

## Service-Specific Rules

[[FILL: Document any database rules specific to this service's domain. Examples:
- Soft delete policy (if the service uses soft deletes, document the convention)
- Cascade rules
- Partition strategy (if tables grow very large)
If none, remove this section.]]
