# Service Deprecation Playbook

**Classification:** [JES] JANUS Governance Document
**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `services/registry.yaml` · `docs/governance/ecosystem-service-roadmap.md` · `docs/governance/cross-service-integration-governance.md` · `docs/governance/jac-operating-procedures.md`

---

## Purpose

Retiring a JANUS service is an irreversible, ecosystem-wide operation. It removes a node from the integration graph, affects all consuming services, and changes the canonical implementation sequence. This playbook ensures service retirement is deliberate, governed, and safe.

---

## Deprecation vs. Retirement

| State | Meaning | Service Still Running? |
|---|---|---|
| **Active** | Normal operational state | Yes |
| **Deprecated** | Announced for retirement; consumers must migrate | Yes |
| **Retired** | Shutdown complete; repository archived | No |

The path is always Active → Deprecated → Retired. A service may not skip the Deprecated phase unless:
- It has zero consumers
- It has never reached production (in that case: simply mark as `not-started` or remove from registry)

---

## Phase 1: Deprecation Proposal

### Who May Propose

The deprecation of a service may be proposed by:
- The service's CSA
- The JANUS Principal Architect
- The JAC by vote

### Proposal Contents

A deprecation proposal is filed as an RFC using the standard RFC template with the additional sections below:

**Additional sections for deprecation RFCs:**
1. **Reason for deprecation** — Why is this service being retired? (Domain absorbed by another service, technology obsolescence, business decision)
2. **Consumer impact** — Every service that integrates with this service is listed, with its CSA identified
3. **Data disposition** — What happens to the service's data? (Migrated to another service / Archived / Deleted — requires explicit decision for each entity)
4. **API sunset plan** — How long will the API remain available for consumer migration?
5. **Alternative** — What do consumers use instead? If nothing, this must be stated explicitly

The RFC requires the super-majority threshold (2/3 of all JAC voting members) per `docs/governance/jac-operating-procedures.md`.

---

## Phase 2: Deprecation Notice

Upon JAC approval of the deprecation RFC:

1. **Registry update:** Service status changed to `deprecated` in `services/registry.yaml`
2. **API deprecation header:** All API responses include `Deprecation: true` and `Sunset: [date]` headers
3. **Consumer notification:** Each consuming service's CSA receives written notification via GitHub Issue in their repository
4. **Minimum notice period:**
   - Service with 0 consumers: 30 days
   - Service with 1–3 consumers: 90 days
   - Service with 4+ consumers: 180 days

---

## Phase 3: Consumer Migration

Each consuming service must:

1. Open a migration issue in their repository within 14 days of deprecation notice
2. Complete migration before the sunset date
3. Notify the deprecating service's CSA when migration is complete
4. Remove all references to the deprecated service in their documentation

The deprecating service's CSA tracks migration completion for all consumers.

---

## Phase 4: Sunset (API Shutdown)

On the sunset date, the API is shut down. Before shutdown:

- [ ] Confirm all consumers have completed migration (written confirmation from each CSA)
- [ ] Confirm no active traffic to the API endpoints (check access logs for 7 days prior)
- [ ] Final data export/archival completed
- [ ] CSA of all consuming services informed of the exact shutdown date (minimum 7 days notice)

If any consumer is not migrated by the sunset date:
- The sunset is extended 30 days
- The consumer's CSA is escalated to the Principal Architect
- A P1 issue is opened in the consumer's repository

Sunset dates are not extended more than once without a new JAC vote.

---

## Phase 5: Retirement

After the API is shut down:

1. **Infrastructure decommissioned** — All resources (compute, database, secrets) are deallocated or deleted
2. **Repository archived** — Repository set to read-only/archived on GitHub; not deleted
3. **Registry update:** Status changed to `retired` in `services/registry.yaml`
4. **Ecosystem map updated:** Integration points removed from `docs/ecosystem-map.md`
5. **Canonical sequence update:** If the retired service held a position in the implementation sequence, an ADR records the sequence amendment
6. **Compliance records archived:** `services/compliance/[service].yaml` marked as retired

---

## Data Disposition

Data owned by a retiring service must be explicitly addressed before retirement:

| Data Decision | When to Use | Process |
|---|---|---|
| **Migrate to another service** | Data has ongoing value and a clear new owner | Migration ADR required; new service's CSA accepts ownership |
| **Archive** | Data has compliance/legal retention requirements but no active use | Archived to cold storage; access procedure documented |
| **Delete** | Data has no ongoing value and no retention requirement | Requires CSA + Principal Architect approval; cannot be undone |

No data may be deleted without explicit written approval. Deleted data is logged in the retirement record with the approving authority.

---

## Prohibited Actions

- Deleting the service repository (archive only — history is permanent)
- Retiring without a consumer migration plan
- Bypassing the JAC super-majority vote
- Shortening the notice period without JAC approval
- Deleting data without written authorization
