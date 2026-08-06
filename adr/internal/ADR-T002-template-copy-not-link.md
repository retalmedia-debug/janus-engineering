# ADR-T002: Templates Copied at Creation, Not Linked

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect

---

## Context

Templates in `janus-engineering/templates/` are the starting point for governance documents in each service repository. When a new service is scaffolded, these templates are instantiated. The question is how the relationship between the template and the service's copy is maintained after creation.

---

## Options Considered

### Option A: Git Submodule / Symlink

Service repositories reference templates via git submodule or symbolic links to a central location.

**Pros:**
- Template updates automatically propagate to services
- No drift between template and service copies

**Cons:**
- Services cannot customize governance documents without modifying the template or creating exceptions
- Git submodules add significant operational complexity (clone instructions, detached HEAD state, CI configuration)
- A change to a template in `janus-engineering` affects all services simultaneously, with no grace period
- Services cannot be at different stages of compliance — all must update together or all are "behind"
- A service that is mid-sprint is disrupted by a template update it did not choose

### Option B: Copy at Creation, Service Owns the Instance

At creation time, templates are copied into the service repository. The service team fills in the placeholders and owns the resulting documents. janus-engineering does not push updates.

**Pros:**
- Service teams own their governance documents — they can be updated at a pace that suits the service
- Services can be at different compliance levels simultaneously (staggered adoption)
- No operational complexity from submodules or symlinks
- Governance documents reflect the service's actual decisions, not a template that has been partially overridden
- The compliance check identifies mandatory structural drift without requiring a live connection to janus-engineering

**Cons:**
- Template drift — a service's governance documents may fall behind a new template version
- Services must actively track template updates and apply them manually

---

## Decision

**Copy at creation. Services own their instances.**

Template drift is accepted as a consequence. The compliance check (`validate-compliance.sh`) identifies mandatory structural requirements — if a required document is missing or a required section is absent, CI catches it. Content drift (a governance document that is correct in structure but outdated in content) is caught by the quarterly documentation review.

The operational simplicity of service-owned documents and the ability for services to adopt template changes at their own pace within grace periods outweighs the risk of template drift.

---

## Consequences

**Positive:**
- Services are autonomous — they own their governance documents
- No git submodule complexity in any service repository
- Template updates can be adopted gradually as part of the suite version upgrade process
- Services in production are not disrupted by governance template updates

**Negative / Trade-offs:**
- Template drift is possible and expected
- Engineers must manually apply template updates when upgrading suite versions
- The compliance check validates structure, not content — content drift requires human review

**Implementation:**
- `scripts/scaffold-service.sh` performs the copy at service creation
- Each copied file gets a template metadata comment: `<!-- Template: janus-engineering@1.0.0/templates/repository/docs/governance/repository-governance.md -->`
- `check-standards-drift.sh` compares the service's template metadata comments against the declared suite version to identify which files use an older template
