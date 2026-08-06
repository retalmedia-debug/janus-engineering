# JANUS Ecosystem — Service Implementation Roadmap

**Classification:** [JES] JANUS Governance Document
**Suite Version:** 1.0.0
**Status:** Active — Mandatory
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06
**Change Authority:** ADR approved by the JANUS Architecture Council (JAC)

---

## Governing Principle

This document establishes the **canonical implementation sequence** for all JANUS services. The order reflects engineering dependencies, infrastructure maturity requirements, and platform readiness — not business priority or alphabetical ordering.

**This sequence is non-negotiable.** No service may begin implementation before all preceding services in the sequence have reached the `implementation` status gate, unless a formal ADR waiver is approved by the JAC.

**No AI agent, tool, or automated process may reorder this sequence.** Any proposed reordering must be submitted as an RFC and resolved as an ADR before it takes effect.

---

## The Canonical JANUS Implementation Sequence

| Position | Service | Repository | Rationale |
|---|---|---|---|
| **1** | **ATLAS** | `atlas-v1` | Foundation service. Establishes the engineering platform itself. Every subsequent service is scaffolded using standards validated by ATLAS. |
| **2** | **GCS** | `gcs-v1` | Ground Control System. Platform-layer service. Required before higher-level intelligence services can operate. Provides foundational control plane capabilities that downstream services depend on. |
| **3** | **VENUS** | `venus-v1` | Second intelligence domain. Validates that the ecosystem pattern works for a second service with different domain characteristics. Completes the initial platform proof-of-concept. |
| **4** | **APOLLO** | `apollo-v1` | [[DECISION REQUIRED: Apollo domain brief required at Phase 0]] Third intelligence domain. Requires GCS and VENUS operational to justify Apollo's integration requirements. |
| **5** | **HERMES** | `hermes-v1` | [[DECISION REQUIRED: Hermes domain brief required at Phase 0]] Messaging or communication-layer service. Position 5 reflects dependency on ATLAS, GCS, VENUS, and APOLLO — likely consumes or orchestrates their data. |
| **6** | **CRONOS** | `cronos-v1` | Temporal management service. Scheduling, time-series operations, or lifecycle management. Position 6 indicates it orchestrates events produced by the first five services. |
| **7** | **CRAT** | `crat-v1` | [[DECISION REQUIRED: CRAT domain brief required at Phase 0]] Independent intelligence domain. Position 7 indicates dependency on the full lower stack being operational before CRAT's domain can be meaningfully established. |
| **8** | **HERA** | `hera-v1` | [[DECISION REQUIRED: Hera domain brief required at Phase 0]] Oversight or management service. Position 8 reflects that it governs or monitors services 1–7. |
| **9** | **AURUS** | `aurus-v1` | [[DECISION REQUIRED: Aurus domain brief required at Phase 0]] Value or enrichment service. Position 9 reflects it augments or enriches data from the established platform. |
| **10** | **NARCOS** | `narcos-v1` | [[DECISION REQUIRED: Narcos domain brief required at Phase 0]] Final intelligence domain in the sequence. Position 10 reflects the highest integration dependency — it is built on a complete platform. |

---

## Why This Order Exists

### Dependency Logic

The implementation sequence is a topological ordering of the JANUS platform's capability dependencies:

```
ATLAS (1) ─────────────────────────────────────────────────────► All services
  └─► GCS (2) ──────────────────────────────────────────────────► Services 3-10
        └─► VENUS (3) ──────────────────────────────────────────► Services 4-10
              └─► APOLLO (4) ──────────────────────────────────► Services 5-10
                    └─► HERMES (5) ──────────────────────────► Services 6-10
                          └─► CRONOS (6) ──────────────────► Services 7-10
                                └─► CRAT (7) ────────────► Services 8-10
                                      └─► HERA (8) ────► Services 9-10
                                            └─► AURUS (9) ──► Service 10
                                                  └─► NARCOS (10)
```

Each service in the sequence:
1. Is validated against all JANUS Engineering Standards before the next service may begin
2. Produces compliance artifacts used by subsequent services as precedent
3. Adds integration points that later services may depend on

### ATLAS as Foundation

ATLAS (Position 1) is the **pilot service**. Its primary purpose is not only to deliver its domain (Geo Intelligence) but to:
- Validate the JANUS Engineering Standards in practice
- Produce the first real instance of every template
- Discover gaps in `janus-engineering` that must be closed before the second service begins
- Establish the first compliance record against the full standards suite

No standard is considered production-grade until ATLAS has consumed it.

### GCS as Platform Layer

GCS (Position 2) occupies the second position because it provides platform-layer capabilities that the intelligence domain services (VENUS, APOLLO, etc.) depend on. GCS must be operational and stable before intelligence services that depend on its capabilities begin implementation.

### Intelligence Domain Services (3–10)

Services at positions 3–10 each represent an independent intelligence or operational domain. Their sequencing reflects increasing integration complexity:

- **Lower numbers** (3–5): Simpler domain isolation; fewer cross-service dependencies
- **Middle numbers** (6–7): Temporal and specialized domain services that orchestrate or extend earlier services
- **Higher numbers** (8–10): Oversight, enrichment, and final domain services that depend on the full platform being mature

---

## Standards Inheritance

Every service in the sequence inherits the complete JANUS Engineering Standards suite in force at the time it enters Phase 0 (service justification).

| Standards Category | Applies From |
|---|---|
| Architecture standards | Position 1 (all services) |
| Engineering standards | Position 1 (all services) |
| Security baseline | Position 1 (all services) |
| API design standard | Position 1 (services with external APIs) |
| Database governance | Position 1 (services with databases) |
| Cross-service integration governance | Position 2 (GCS is first integration point) |
| Containerization standard | Position 1 (all services deploying containers) |

No service may declare compliance with a previous suite version if a newer version has been released and its grace period has expired. See `docs/governance/suite-versioning-strategy.md`.

---

## Gate Between Services

Before a service at position N+1 may enter Phase 1 (repository creation), the service at position N must have:

1. Passed the JANUS compliance check (`validate-compliance.sh`)
2. Completed Phases 0–3 (governance establishment and architecture establishment)
3. Had its compliance record filed in `services/compliance/[service].yaml`
4. Identified at least one lesson learned that has been incorporated into `janus-engineering` (standards gap or template improvement)

The JAC reviews gate compliance before authorizing the next service to begin.

---

## Amending This Document

This document may only be amended through:

1. An RFC filed via `.github/ISSUE_TEMPLATE/rfc-standard-change.md`
2. Minimum 14-day JAC comment period
3. Formal ADR filed in `adr/ecosystem/` documenting the reordering decision
4. JAC disposition requiring Principal Architect approval

An approved ADR is the only mechanism that may change the canonical sequence. No other authority — including the Principal Architect acting unilaterally — may reorder this sequence without the ADR process.

---

## Related Documents

- `services/registry.yaml` — Authoritative registry with all service metadata
- `docs/guides/new-service-lifecycle.md` — 6-phase lifecycle every service must follow
- `docs/governance/service-compliance-policy.md` — Compliance requirements per service
- `docs/governance/rfc-process.md` — RFC process for amending this document
- `adr/README.md` — ADR index (ecosystem ADR required for sequence changes)
