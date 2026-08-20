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
| **1** | **ATLAS** | `atlas-v1` | General Intelligence - external intelligence acquisition, evidence preservation, structured intelligence, analysis, findings, recommendations, and geospatial intelligence. |
| **2** | **GCS** | `gcs-v1` | Strategy Intelligence — creation, development, evaluation, and evolution of institutional strategies. |
| **3** | **VENUS** | `venus-v1` | Operations Intelligence - operational workflows, execution visibility, process state, coordination, performance, and day-to-day operational management intelligence. |
| **4** | **APOLLO** | `apollo-v1` | Media Intelligence - media assets, media production, media analysis, media activities, media libraries, classification, and media-domain workflows. |
| **5** | **HERMES** | `hermes-v1` | Content Scheduling & Publishing Intelligence - content calendars, publication planning, scheduling, publishing execution, publication state, and delivery to supported channels. |
| **6** | **CRONOS** | `cronos-v1` | Managed Meta Insights Intelligence - acquisition, normalization, storage, comparison, and analysis of insights from Meta properties directly managed for clients. |
| **7** | **NARCOS** | `narcos-v1` | Sales Intelligence - leads, prospects, opportunities, sales pipelines, conversion intelligence, commercial performance, and sales forecasting. |
| **8** | **HERA** | `hera-v1` | Human Resources Intelligence - workforce records, staffing, roles, employee lifecycle intelligence, HR operations, and approved workforce analytics. |
| **9** | **AURUS** | `aurus-v1` | Financial Intelligence - financial records, revenue, costs, cash flow, profitability, financial analysis, planning, and forecasting. |
| **10** | **CRAT** | `crat-v1` | Reporting Intelligence - report composition, generation, rendering, packaging, and lifecycle management across the JANUS ecosystem. |

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
                                └─► NARCOS (7) ──────────► Services 8-10
                                      └─► HERA (8) ────► Services 9-10
                                            └─► AURUS (9) ──► Service 10
                                                  └─► CRAT (10)
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

### GCS as Strategy Intelligence

GCS (Position 2) owns Strategy Intelligence. It creates, develops, evaluates, and evolves institutional strategies by consuming approved intelligence from other JANUS systems when required. Ecosystem platform control, identity, access, registry, navigation, and orchestration belong to JANUS Platform at Position 0.

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
