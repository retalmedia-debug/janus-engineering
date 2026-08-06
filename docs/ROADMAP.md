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
**Status:** IN PROGRESS
**Priority:** P0
**Complexity:** High
**Started:** 2026-08-06

Deliverables:
- [ ] `standards/engineering/code-review-standard.md`
- [ ] `standards/engineering/sprint-governance.md`
- [ ] `standards/api/event-schema-standard.md`
- [ ] `standards/operations/alerting-standard.md`
- [ ] `standards/operations/runbook-standard.md`
- [ ] `standards/security/secret-management-standard.md`
- [ ] `standards/architecture/service-sizing-guidance.md`
- [ ] `docs/governance/cross-service-integration-governance.md`
- [ ] `docs/governance/incident-management-policy.md`
- [ ] `docs/governance/jac-operating-procedures.md`
- [ ] `docs/governance/service-deprecation-playbook.md`
- [ ] `docs/guides/how-to-scaffold-a-service.md`
- [ ] `templates/documents/rfc/RFC-TEMPLATE.md`
- [ ] `templates/documents/post-mortem/POST-MORTEM-TEMPLATE.md`
- [ ] `templates/documents/incident-report/INCIDENT-REPORT-TEMPLATE.md`

Dependencies: PKG-001, PKG-002

---

### PKG-004 — Cross-Reference and Classification Pass
**Status:** PENDING
**Priority:** P1
**Complexity:** Medium

Deliverables:
- [ ] Add [JES] classification header to all standards
- [ ] Add [JTS] classification header to all templates
- [ ] Verify all cross-document links resolve
- [ ] Verify no duplicate requirements exist across standards
- [ ] Verify `standards/INDEX.md` matches actual files
- [ ] Verify `templates/INDEX.md` matches actual files
- [ ] Update `CHANGELOG.md` with all PKG-003 additions
- [ ] Suite version bump (MINOR — new standards added)

Dependencies: PKG-003

---

### PKG-005 — Tooling Package Implementations
**Status:** PENDING
**Priority:** P1
**Complexity:** High

Currently `@janus/eslint-config`, `@janus/tsconfig`, `@janus/prettier-config`, `@janus/commitlint-config` exist as stubs with `package.json` and config files. Full publication requires:
- [ ] GitHub Actions workflow for publishing to GitHub Packages
- [ ] `README.md` for each package with installation instructions
- [ ] `CHANGELOG.md` per package
- [ ] Version automation (tag-triggered publish)
- [ ] Peer dependency validation tests

Dependencies: PKG-003

---

### PKG-006 — ATLAS v1 Compliance Update
**Status:** PENDING
**Priority:** P1
**Complexity:** Low

`atlas-v1` is the first consumer and must declare compliance with `janus-engineering@1.0.0`:
- [ ] Update `atlas-v1/CLAUDE.md` to reference `janus-engineering@1.0.0`
- [ ] Create `atlas-v1/.janus-compliance.yaml`
- [ ] Update `atlas-v1/docs/architecture/adr/ADR-0001` to reference `ADR-E001`
- [ ] Apply missing governance/architecture documents from template

Dependencies: PKG-003 (compliance check must pass)

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

| Risk | Package | Severity |
|---|---|---|
| No cross-service integration governance before first inter-service connection | PKG-003 | High |
| No ecosystem incident management before GCS enters production | PKG-003 | High |
| @janus tooling packages are stubs — services cannot install them until PKG-005 | PKG-005 | Medium |
