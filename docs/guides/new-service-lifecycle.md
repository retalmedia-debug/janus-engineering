# New JANUS Service Lifecycle

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## Overview

This guide defines the authoritative path from "we need a new JANUS service" to "implementation may begin." Every gate in this lifecycle is mandatory. No gate is optional. No gate may be skipped, even when timeline pressure exists.

The gates exist because their dependencies are real, not bureaucratic. See `standards/architecture/architectural-order.md` for the reasoning behind each phase's ordering.

---

## Phase 0 — Justification

### Gate 0.1 — Domain Brief

Produce a written brief (one to two pages) that answers:
- What does this service do?
- What domain does it own, and what data does it hold?
- Why can this not be a feature of an existing JANUS service?
- Why does it require an independent deployment lifecycle?
- What other JANUS services will it integrate with?

The brief is submitted as a GitHub Issue in `janus-engineering` using the `service-registration.md` template.

### Gate 0.2 — JAC Domain Review

The JAC reviews the brief for:
- Domain boundary clarity (is the scope well-defined?)
- Conflict with existing service domains (does this overlap with ATLAS, VENUS, etc.?)
- Justification for independence (is a separate service genuinely warranted?)

**Decision:** Approved / Redirect to existing service / Reject

### Gate 0.3 — Ecosystem ADR (if required)

If the new service introduces a new pattern into the ecosystem (new technology, new integration mechanism, new data sharing model, new deployment topology), an ecosystem ADR is drafted and accepted before the service is created.

The ADR is submitted via the standard RFC process.

---

## Phase 1 — Repository Creation

### Gate 1.1 — Naming Decision

The JAC approves the service name and repository name:
- System codename: uppercase (e.g., `VENUS`)
- Repository name: lowercase-hyphenated with version suffix (e.g., `venus-v1`)
- Service identifier for logs and registry: lowercase (e.g., `venus`)
- No two JANUS services may share a name or an identifier

The service is added to `services/registry.yaml` with `status: bootstrapping`.

### Gate 1.2 — Repository Scaffold

The incoming service CSA runs:

```bash
./scripts/scaffold-service.sh \
  --name VENUS \
  --repo venus-v1 \
  --domain "Financial Intelligence System" \
  --csa "Engineer Name" \
  --suite-version 1.0.0
```

This produces:
- Complete directory structure from `templates/repository/`
- All `{{PLACEHOLDER}}` values substituted
- `.janus-compliance.yaml` created
- GitHub Issues created for every `[[FILL:]]` and `[[DECISION REQUIRED:]]` marker (one issue per marker)
- The repository is ready for its initial commit

### Gate 1.3 — Initial Commit

The scaffold produces exactly one commit:

```
chore: bootstrap venus-v1 from janus-engineering@1.0.0
```

This commit is the zero-point of the service's history. It is never amended.

---

## Phase 2 — Governance Establishment

### Gate 2.1 — Governance Documents Complete

All scaffold GitHub Issues in the governance category are resolved. This means:
- Named roles are filled in (CSA, technical leads, team members)
- Approval counts are set for PR rules
- Environments are defined (Local, Development, Staging, Production)
- Service-specific commit convention scopes are defined
- Branching strategy is confirmed with any service-specific additions

### Gate 2.2 — Compliance Check Passes

```bash
./scripts/validate-compliance.sh --repo-path /path/to/venus-v1
```

Must pass with zero mandatory violations.

The compliance check is added to the service's CI pipeline before this gate closes.

### Gate 2.3 — CSA Ratification

The service CSA formally ratifies governance by merging the governance completion PR:

```
docs(governance): ratify initial governance for venus-v1
```

This is the moment the service has a governance foundation.

---

## Phase 3 — Architecture Establishment

### Gate 3.1 — Engineering Principles Extended

The service's `docs/architecture/engineering-principles.md` is completed:
- Universal principles from `janus-engineering` are referenced (not copied)
- Domain-specific principles are authored for the service's domain
- Each domain principle has an "Applied:" section

### Gate 3.2 — Technology ADRs Accepted

Before implementation, these ADRs must be in `Accepted` status:
- Database/storage technology (if applicable)
- Frontend technology (if applicable)
- Backend/API runtime (if applicable)
- Worker/async processing technology (if applicable)
- Testing framework

No implementation begins before these ADRs are accepted.

### Gate 3.3 — Folder Strategy Complete

The service's `docs/architecture/folder-strategy.md` is completed:
- Every planned top-level directory exists in the repository (even if empty with a `.gitkeep`)
- The purpose of each directory is documented
- The structure reflects the technology decisions made in Gate 3.2

### Gate 3.4 — Domain Model Draft

`docs/architecture/domain-model.md` captures:
- The service's core entities and their relationships
- Invariants and constraints for each entity
- How entities relate to entities in other JANUS services

Reviewed by JAC for ecosystem coherence.

### Gate 3.5 — System Context Document

`docs/architecture/system-context.md` documents:
- Every external actor (user types, external systems)
- Every dependency (JANUS services consumed, external APIs, databases)
- Every output (events emitted, APIs exposed, reports generated)

`docs/ecosystem-map.md` in `janus-engineering` is updated.

---

## Phase 4 — Security and Privacy Baseline

### Gate 4.1 — Threat Model

`docs/security/threat-model.md` is completed:
- Adversaries and their goals
- Attack surface
- Data at risk and its sensitivity
- Security controls mapped to threats

### Gate 4.2 — Data Classification

All entities in the domain model are classified:
- PII / sensitive / sensitive-internal / non-sensitive
- Retention policies defined for all PII and sensitive data
- Data privacy document completed

### Gate 4.3 — Security Baseline Instantiated

`docs/security/security-baseline.md` is completed with service-specific platform decisions (which auth provider, which secrets manager, which encryption standard).

---

## Phase 5 — Specification (Database and API)

### Gate 5.1 — Multi-Tenancy Decision

An ADR is accepted that explicitly states:
- Is this service single-tenant or multi-tenant?
- If multi-tenant: how is tenant isolation enforced (RLS, schema isolation, instance isolation)?

This gate cannot be deferred. Multi-tenancy affects data model, API design, and security simultaneously.

### Gate 5.2 — Database Schema Draft (if applicable)

Schema is documented before any migration is written:
- Entity-relationship diagram or equivalent notation
- Column-level documentation
- Reviewed and approved by the CSA

### Gate 5.3 — API Contract Draft (if applicable)

OpenAPI specification for all planned endpoints:
- Reviewed for consistency with `standards/api/api-design-standard.md`
- Shared with any known consuming services before implementation begins

---

## Phase 6 — Implementation Authorization

### Gate 6.1 — Implementation Readiness Review

The service CSA conducts a final review confirming all gates above are complete:

- [ ] All governance documents ratified
- [ ] All required technology ADRs accepted
- [ ] Domain model reviewed by JAC
- [ ] System context documented
- [ ] Threat model complete
- [ ] Data classification complete
- [ ] Multi-tenancy decision documented
- [ ] Database schema draft exists (if applicable)
- [ ] API contract draft exists (if applicable)
- [ ] Compliance check passes
- [ ] `CLAUDE.md` is complete
- [ ] Onboarding document is complete

### Gate 6.2 — Service Registry Update

`services/registry.yaml` in `janus-engineering` is updated:
```yaml
status: bootstrapping → status: implementation
```

The JANUS Principal Architect acknowledges the update.

---

## Implementation May Now Begin.

The service follows the Architectural Order from Phase 8 (Implementation) onward.
