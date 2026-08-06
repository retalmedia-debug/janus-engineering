# JANUS Ecosystem Map

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## Ecosystem Overview

The JANUS ecosystem is a multi-system intelligence platform. Each system is an independent service with its own domain, data, deployment lifecycle, and team.

```
┌───────────────────────────────────────────────────────────────────┐
│                        JANUS Ecosystem                            │
│                                                                   │
│  ①ATLAS    ②GCS     ③VENUS   ④APOLLO  ⑤HERMES                  │
│  Geo Intel  Control   TBD      TBD      TBD                      │
│                                                                   │
│  ⑥CRONOS   ⑦CRAT    ⑧HERA    ⑨AURUS   ⑩NARCOS                 │
│  TBD        TBD      TBD      TBD      TBD                       │
│                                                                   │
│  ─────────────────────────────────────────────────               │
│                  janus-engineering                                │
│            (governance, not a runtime service)                    │
└───────────────────────────────────────────────────────────────────┘
```
Numbers indicate canonical implementation sequence. See `docs/governance/ecosystem-service-roadmap.md`.

---

## Service Registry

| # | Service | Repository | Domain | Status | CSA |
|---|---|---|---|---|---|
| 1 | ATLAS | `atlas-v1` | Geo Intelligence & External Intelligence | governance-establishment | Mr. Don |
| 2 | GCS | `gcs-v1` | Ground Control System (TBD — Phase 0 brief required) | not-started | TBD |
| 3 | VENUS | `venus-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 4 | APOLLO | `apollo-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 5 | HERMES | `hermes-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 6 | CRONOS | `cronos-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 7 | CRAT | `crat-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 8 | HERA | `hera-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 9 | AURUS | `aurus-v1` | TBD — Phase 0 brief required | not-started | TBD |
| 10 | NARCOS | `narcos-v1` | TBD — Phase 0 brief required | not-started | TBD |

Authoritative registry: `services/registry.yaml`

---

## Active Integration Points

No active integrations yet. ATLAS is the first service and has no runtime consumers at this stage.

*When integrations exist, document them here:*
```
[Service A] → [Service B]: Description of the integration
  Protocol: REST API / Webhook / Event
  Contract: link to API specification
  Data: what is shared
```

---

## Integration Principles

All JANUS service integrations follow these principles:

1. **Loose coupling** — Services integrate through published contracts, not shared databases or direct internal API access
2. **Contracts over implementation** — Integration points are defined as OpenAPI specifications or event schemas before implementation
3. **Versioned contracts** — All published contracts are versioned; breaking changes require new versions
4. **Consumer-owned dependencies** — A service consuming another service's API pins the version it depends on
5. **Failure isolation** — A failure in one service must not cascade to other services

Integration governance: `standards/architecture/` and each service's `docs/architecture/ecosystem-integration.md`

---

## Maintenance

This document is updated when:
- A new service is added to the ecosystem (Gate 3.5 of new service lifecycle)
- An integration between services is established or deprecated
- A service's status changes
- A service's domain description changes

Update is part of the PR that creates or modifies the service.
