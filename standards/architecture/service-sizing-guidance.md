# Service Sizing Guidance

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS Architecture Council decisions on domain boundaries
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/architecture/engineering-principles.md` · `adr/ecosystem/ADR-E001-polyrepo-strategy.md` · `docs/governance/new-service-lifecycle.md` · `docs/governance/ecosystem-service-roadmap.md`

---

## Purpose

One of the most consequential architectural decisions in a polyrepo ecosystem is determining what constitutes a service boundary. Getting this wrong in either direction — too coarse (a monolith disguised as a service) or too fine (nanoservices that create operational overhead without autonomy benefit) — creates long-term friction. This standard establishes the criteria for correct service sizing in the JANUS ecosystem.

---

## Core Principle: Domain Isolation

A JANUS service owns a **bounded domain** — a cohesive set of concepts, data, and behaviors that change together for the same reasons. The question "does this belong in its own service?" is answered by the bounded domain test:

> If Team A's requirements change, must Team B's code change too? If yes, they may be in the same domain. If no, they may be in different domains.

---

## When to Create a New Service

A new JANUS service is justified when ALL of the following are true:

### 1. The Domain Is Bounded and Stable

The domain can be defined in one sentence. It has clear inputs, clear outputs, and a clear responsibility boundary. It is not "everything that doesn't fit elsewhere."

### 2. The Domain Has Independent Scalability Requirements

The new service would need to scale independently of existing services. If it would always scale in lockstep with an existing service, it belongs in that service.

### 3. The Domain Has Independent Deployment Requirements

The new capability needs to be deployed independently — different release cadence, different team ownership, different availability requirements, or different technology stack requirements.

### 4. The Domain Has Independent Data Ownership

The new service would own data that no other service should write to directly. If another service would need direct database access to function, the boundary is wrong.

### 5. The Ecosystem Is Ready

The service at position N-1 in the canonical implementation sequence is operational. The new service cannot begin before its prerequisite service has reached `implementation` status.

---

## When NOT to Create a New Service

Do not create a new JANUS service for:

| Reason | Why Not |
|---|---|
| Code organization | Use modules, packages, or folders within an existing service |
| Technology preference | Changing the language or framework within an existing domain is an ADR within that service |
| Team politics or ownership disputes | Resolve at the JAC level; do not use service boundaries as org chart surrogates |
| Performance optimization | Optimize within the existing service first |
| "This function is reusable" | Reusable code becomes a `@janus` npm package, not a service |
| Premature separation | If you cannot describe the domain boundary in one sentence, it's not a service yet |

---

## Sizing Anti-Patterns

### Too Coarse: The Domain Monolith

**Symptom:** A service owns multiple distinct bounded domains. Teams working on "ATLAS" are actually working on geospatial logic, alert processing, and external intelligence ingestion — these might be three separate domains masquerading as one.

**Consequence:** Changes to one domain require review, testing, and deployment of the entire service. Teams step on each other.

**Resolution:** Split via the service lifecycle process. Requires an ADR and JAC approval.

### Too Fine: The Nanoservice

**Symptom:** A service owns a single function or data entity. `user-creation-service`, `event-timestamp-validator-service`.

**Consequence:** High operational overhead, complex distributed tracing, failure modes that span many network hops.

**Resolution:** Merge into the owning domain service. Reusable logic becomes a `@janus` npm package.

### The Shared Database

**Symptom:** Two services access the same database schema directly.

**Consequence:** Tight coupling disguised as separate services. Schema changes in one service break the other. This is a monolith with extra network hops.

**Resolution:** Only one service owns the database. Other services integrate through its API.

---

## Service Boundary Decision Process

When a new capability is needed and the team debates whether it warrants a new service:

1. **Write the one-sentence domain definition** — If you can't do this, it's not ready to be a service
2. **Apply the 5 criteria above** — All 5 must be true
3. **Check the canonical sequence** — Is there a planned position for this service? If so, follow the sequence
4. **File a domain brief** — Phase 0, Gate 0.1 of the new service lifecycle
5. **JAC review** — The JAC determines whether the domain warrants a new position in the canonical sequence or belongs in an existing service

No new service may be created without JAC approval and an update to the canonical implementation sequence via ADR.

---

## Rationale

The JANUS ecosystem is explicitly polyrepo (ADR-E001). The polyrepo decision's value depends on services being correctly sized — too coarse and we lose deployment independence; too fine and we lose operational simplicity. These criteria were developed by analyzing common failure modes in microservice ecosystems and calibrating them to the JANUS team size and operational maturity.
