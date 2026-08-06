# ADR-E008: Supabase as the Ecosystem Database Platform

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect (Mr. Don)
**Consulted:** JANUS Architecture Council (founding session)
**Supersedes:** _(none)_
**Superseded by:** _(none — filled in if this ADR is later superseded)_

---

## Context

Every JANUS service that persists data needs a database platform. The choice of platform determines:

- The underlying database engine (PostgreSQL, MySQL, MongoDB, etc.)
- How migrations are managed
- How real-time subscriptions work
- How Row Level Security (data-layer authorization) is enforced
- The operational complexity of running and scaling the database layer

ATLAS (the first JANUS service) selected Supabase during its architecture phase. This ADR formalizes that selection as the **ecosystem default** — the platform all future JANUS services use unless a service-specific ADR provides an overriding justification.

---

## Options Considered

### Option A: No ecosystem-level decision — each service chooses independently

Each service selects its own database platform without ecosystem guidance.

**Pros:**
- Maximum flexibility for service-specific requirements
- Teams can pick the best tool for their domain

**Cons:**
- Engineers need to learn multiple platforms across the ecosystem
- No shared migration governance, tooling, or RLS patterns
- Duplicate operational knowledge that is expensive to maintain across small teams
- No shared `@janus` npm tooling can target a single database platform

### Option B: Raw PostgreSQL on a managed provider

Each service runs PostgreSQL directly on a managed provider (AWS RDS, Google Cloud SQL, etc.).

**Pros:**
- Maximum control over database configuration
- No dependency on a third-party BaaS

**Cons:**
- Requires separate auth provider, connection pooling, real-time capability, and migration tooling
- Significantly higher operational burden at small team size
- No built-in Row Level Security management tooling

### Option C: Supabase as the ecosystem default

Supabase is adopted as the ecosystem default database platform for all services.

**Pros:**
- PostgreSQL as the underlying engine — all SQL expertise transfers
- Built-in auth, real-time, and storage that services can adopt incrementally
- Row Level Security enforced at the database layer (aligns with JANUS security standard)
- Supabase CLI for local development mirrors production behavior
- Strong migration tooling via `supabase migrations`
- PostGIS extension available for geospatial services (ATLAS requirement)
- Single platform for the team to develop expertise in
- `@janus/supabase-types` package (future) can be a shared tooling asset

**Cons:**
- Dependency on Supabase as a company and platform
- Services with requirements incompatible with PostgreSQL (e.g., graph databases, document databases) cannot use this default
- Service vendor lock-in risk (mitigated: Supabase is built on standard PostgreSQL)

---

## Decision

**Option C: Supabase as the ecosystem default database platform.**

Supabase is the **default** — not the mandatory — database platform. Services with domain-specific requirements (graph data, time-series, document-oriented) may use an alternative platform subject to an approved service-level ADR and JAC review.

The default covers:
- Primary relational data storage
- Row Level Security for data-layer authorization
- Database migrations (governed by `standards/database/supabase-migration-governance.md`)
- Local development environment (via Supabase CLI)

---

## Consequences

**Positive:**
- All JANUS engineers develop expertise in a single platform
- Migration governance standard (`standards/database/supabase-migration-governance.md`) applies to all default-platform services
- RLS patterns developed for ATLAS are reusable across services
- Single operational runbook for database administration

**Negative / Trade-offs:**
- Services that outgrow Supabase's connection pooling or storage limits must plan a migration
- Supabase pricing scales with usage — cost modeling required before each service enters production
- Real-time features in Supabase have message size and throughput limits

**Risks:**
- Supabase platform risk: Supabase is a funded startup, not an infrastructure-scale company. Mitigation: Supabase is built on standard PostgreSQL — data portability is not at risk even if the platform changes.
- Services with PostGIS-heavy workloads may encounter Supabase limitations as geospatial query complexity grows. Mitigation: ATLAS ADR will evaluate this as it scales.

**Services exempt from this default:**
A service may use a different database platform if all of the following are true:
1. A service-level ADR documents the requirement that cannot be met by PostgreSQL
2. The JAC reviews and approves the alternative platform at Gate 3 (architecture establishment)
3. The alternative platform has a migration governance standard (either adopted from JANUS or defined in a new `standards/database/` document)
