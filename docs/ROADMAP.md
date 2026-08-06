# JANUS Engineering — Platform Engineering Roadmap

**Owner:** JANUS Principal Architect
**Last Updated:** 2026-08-06
**Suite Version:** 1.0.0

This document tracks the engineering platform work in `janus-engineering`. It is distinct from the service implementation roadmap (`docs/governance/ecosystem-service-roadmap.md`), which governs service build order.

---

## Status Vocabulary

| Status | Meaning |
|---|---|
| `COMPLETE` | All deliverables produced and committed |
| `IN PROGRESS` | Currently being built |
| `PENDING` | Queued — prerequisites met |
| `BLOCKED` | Waiting on external input |
| `DEFERRED` | Not in current phase |

---

## Engineering Packages

### PKG-001 — janus-engineering Bootstrap
**Status:** COMPLETE
**Priority:** P0
**Complexity:** Very High
**Completed:** 2026-08-06 (commit `def2eb5`, tag `v1.0.0`)

Deliverables: 26 standards, 9 ecosystem ADRs, 3 internal ADRs, 50-file repository scaffold template, 4 @janus tooling packages, 3 compliance scripts, full governance docs, RFC process, JAC model.

Dependencies: None (founding package)

---

### PKG-002 — Ecosystem Roadmap and Registry Expansion
**Status:** COMPLETE
**Priority:** P0
**Complexity:** Medium
**Completed:** 2026-08-06

Deliverables: `docs/governance/ecosystem-service-roadmap.md`, `services/registry.yaml` (expanded to 10 services), `docs/WORKLOG.md`, `docs/ROADMAP.md`

Dependencies: PKG-001

---

### PKG-003 — Missing Governance and Standards
**Status:** COMPLETE
**Priority:** P0
**Complexity:** High
**Completed:** 2026-08-06 (commit `8f9572f`)

Deliverables:
- [x] `standards/engineering/code-review-standard.md`
- [x] `standards/engineering/sprint-governance.md`
- [x] `standards/api/event-schema-standard.md`
- [x] `standards/operations/alerting-standard.md`
- [x] `standards/operations/runbook-standard.md`
- [x] `standards/security/secret-management-standard.md`
- [x] `standards/architecture/service-sizing-guidance.md`
- [x] `docs/governance/cross-service-integration-governance.md`
- [x] `docs/governance/incident-management-policy.md`
- [x] `docs/governance/jac-operating-procedures.md`
- [x] `docs/governance/service-deprecation-playbook.md`
- [x] `docs/guides/how-to-scaffold-a-service.md`
- [x] `templates/documents/rfc/RFC-TEMPLATE.md`
- [x] `templates/documents/post-mortem/POST-MORTEM-TEMPLATE.md`
- [x] `templates/documents/incident-report/INCIDENT-REPORT-TEMPLATE.md`

Dependencies: PKG-001, PKG-002

---

### PKG-004 — Cross-Reference and Classification Pass
**Status:** COMPLETE
**Priority:** P1
**Complexity:** Medium
**Completed:** 2026-08-06 (commit `49b8546`)

Deliverables:
- [x] [JES] classification header added to all 26 original standards
- [x] `standards/operations/observability-standard.md` — unified three-pillar standard (new)
- [x] `adr/ecosystem/ADR-E008-supabase-as-database-platform.md` — formalizes platform decision
- [x] Scaffold template gaps resolved: package.json, .nvmrc, docs/INDEX.md, event-catalog.md, integration-request.md
- [x] `standards/INDEX.md` updated to 34 standards
- [x] `templates/INDEX.md` updated with new scaffold files
- [x] All 4 tooling package READMEs written
- [x] `validate-compliance.sh` extended with secret management and observability checks

Dependencies: PKG-003

---

### PKG-005 — Tooling Package Implementations
**Status:** COMPLETE
**Priority:** P1
**Complexity:** High
**Completed:** 2026-08-06 (commit `21336e2`)

- [x] `.github/workflows/publish-tooling.yml` — tag-triggered (tooling/v*) GitHub Actions publish workflow
- [x] `README.md` for each of 4 packages (completed in PKG-004)
- [x] `CHANGELOG.md` for each of 4 packages
- [x] Version automation (tag-triggered publish, version alignment validation)
- [x] `docs/guides/how-to-publish-tooling.md` — complete release guide

Note: Peer dependency validation tests deferred to PKG-008 (post-baseline). Publish workflow includes dry-run capability.

Dependencies: PKG-003

---

### PKG-006 — ATLAS v1 Compliance Update
**Status:** COMPLETE
**Priority:** P1
**Complexity:** Low
**Completed:** 2026-08-06

- [x] `atlas-v1/CLAUDE.md` — filled with janus-engineering@1.0.0 reference and full ATLAS context
- [x] `atlas-v1/.janus-compliance.yaml` — created
- [x] `atlas-v1/docs/architecture/adr/ADR-0001` — Ecosystem Cross-Reference section added (ADR-E001 + roadmap)
- [x] 9 missing template documents applied: domain-model, system-context, threat-model, onboarding, data-privacy, escalation-matrix, observability-strategy, incident-response-runbook, error-catalog
- [x] `atlas-v1/docs/INDEX.md` — updated with all new docs + Ecosystem Standards section
- [x] `atlas-v1/CHANGELOG.md` — service changelog created

Dependencies: PKG-003

---

### PKG-007 — GCS Onboarding (Second Service)
**Status:** BLOCKED
**Priority:** P2
**Complexity:** Medium
**Blocker:** GCS domain brief not yet filed (Phase 0, Gate 0.1)

Dependencies: PKG-006 (lessons from ATLAS compliance)

---

### PKG-008 — Automated Tooling and CI for janus-engineering
**Status:** DEFERRED
**Priority:** P2
**Complexity:** Medium

Deliverables:
- [ ] GitHub Actions: auto-notify services on suite version bump
- [ ] GitHub Actions: ecosystem compliance report generation
- [ ] GitHub Actions: tooling package publication pipeline
- [ ] Pre-commit hooks for janus-engineering itself

Dependencies: PKG-005

---

## Risks

| Risk | Package | Severity | Status |
|---|---|---|---|
| No cross-service integration governance before first inter-service connection | PKG-003 | High | Resolved |
| No ecosystem incident management before GCS enters production | PKG-003 | High | Resolved |
| @janus tooling packages are stubs — services cannot install them until PKG-005 | PKG-005 | Medium | Resolved — publish workflow ready; CSA must push tooling/v1.0.0 tag |
| GCS domain brief not filed — PKG-007 is blocked | PKG-007 | Medium | Open |
| Suite version not bumped to 1.1.0 despite 8 new standards post-v1.0.0 | — | Low | Open — CSA to decide when to cut 1.1.0 |
