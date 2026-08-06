# Architectural Order

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Software is built in layers. Each layer depends on the stability of the layers beneath it. When engineers build layers out of order — implementing before specifying, specifying before modeling, modeling before understanding the architecture — the work is wrong by construction and must be redone.

The Architectural Order is the non-negotiable sequencing model for all JANUS service development. It defines which phase must be complete before the next begins. It is not a waterfall model — phases may overlap at their edges, and implementation proceeds incrementally within its phase. But no phase may begin until its predecessor phase has produced stable, reviewed artifacts.

---

## The Order

```
1. Vision
   ↓
2. Governance
   ↓
3. Architecture
   ↓
4. Documentation
   ↓
5. Specification
   ↓
6. Database
   ↓
7. API
   ↓
8. Implementation
   ↓
9. Testing
   ↓
10. Deployment
    ↓
11. Automation
    ↓
12. Optimization
```

---

## Phase Definitions

### Phase 1 — Vision

**What it produces:** A clear, written statement of what the service does, who it serves, what problem it solves, and why it must exist as an independent JANUS service rather than as a feature of an existing one.

**Gate:** The JANUS Architecture Council has reviewed the vision and approved the service's domain boundary.

### Phase 2 — Governance

**What it produces:** All governance documents for the service — branching strategy, commit convention, PR rules, Definition of Done, quality gates, release strategy, versioning strategy. The service's engineering operating system.

**Gate:** The service CSA has ratified the governance documents. The compliance check passes. All `[[FILL:]]` and `[[DECISION REQUIRED:]]` markers in governance documents are resolved.

### Phase 3 — Architecture

**What it produces:** Technology ADRs for all major decisions (database, frontend, backend, worker), the engineering principles document (universal + domain-specific), the folder strategy, the repository standards document, the system context document, and the domain model.

**Gate:** All technology ADRs are in `Accepted` status. Domain model is reviewed by JAC. System context document identifies all external actors, dependencies, and outputs.

### Phase 4 — Documentation

**What it produces:** A documentation plan — what will be documented, by whom, in what format. Also: any standards extensions or exceptions the service needs relative to the JANUS standards suite.

**Gate:** Documentation strategy is agreed. All exceptions are documented in service ADRs.

### Phase 5 — Specification

**What it produces:** Detailed specifications for each planned feature — acceptance criteria, domain rules, edge cases, and error conditions — before any database schema or API is designed.

**Gate:** Acceptance criteria exist for all features planned for the first milestone. The product owner (or equivalent) has reviewed and agreed.

### Phase 6 — Database

**What it produces:** The database schema — documented in `docs/database/schema/` and expressed as reviewed migration files. RLS policies for every table. A data retention policy for any time-series table.

**Gate:** Schema is reviewed by the CSA. Every table has RLS enabled and tested. Migrations apply cleanly in a local environment.

### Phase 7 — API

**What it produces:** The complete OpenAPI specification for all endpoints planned for the first milestone. The error catalog. The API governance document instantiated with service-specific decisions.

**Gate:** OpenAPI specification is reviewed by the CSA. The specification is consistent with the database schema. Consuming services have seen the contract.

### Phase 8 — Implementation

**What it produces:** Working service code that matches the specification, database schema, and API contract.

**Gate:** All code passes the quality gates. All planned features have passing unit and integration tests. The implementation matches the OpenAPI specification.

### Phase 9 — Testing

**What it produces:** The complete test suite — unit tests covering ≥ 80% of code, integration tests covering all database interactions, E2E tests covering all critical paths, and contract tests (if applicable).

**Gate:** Coverage meets the thresholds defined in the service's `docs/testing/testing-strategy.md`. No flaky tests. All tests pass in CI.

### Phase 10 — Deployment

**What it produces:** A working deployment pipeline for all environments. Infrastructure-as-code for all environment configuration. A rollback procedure.

**Gate:** Deployment to staging succeeds. Rollback procedure is tested. All environment-specific configuration is documented and applied.

### Phase 11 — Automation

**What it produces:** Automated workflows for recurring operational tasks — scheduled jobs, data pipelines, alerts, maintenance routines.

**Gate:** All automated workflows are monitored. Failure notifications are configured. On-call runbooks exist for each workflow.

### Phase 12 — Optimization

**What it produces:** Performance improvements, query optimizations, caching strategies, and technical debt resolution based on measured production behavior.

**Gate:** Performance baselines are established. Changes are validated against baselines. No optimization is applied without a measured problem.

---

## Why This Order

### Vision precedes Governance because:
Governance documents without a defined scope are filled with generic text that serves no one. The vision defines what is being governed.

### Governance precedes Architecture because:
Architecture decisions require knowing the constraints — team, timeline, risk tolerance, compliance requirements. Governance documents those constraints.

### Architecture precedes Documentation because:
Documentation is knowledge transfer. You cannot transfer knowledge about an architecture you have not yet decided.

### Specification precedes Database because:
The database schema is a consequence of the domain model, which is a consequence of understanding the problem in specification-level detail. Schemas built before specification encode assumptions that specifications reveal to be wrong.

### Database precedes API because:
The API contract is shaped by the data it serves. An API designed without a schema makes assumptions about the data model that the schema reveals to be incorrect.

### API precedes Implementation because:
Implementation is the most expensive phase. Discovering that the API contract is wrong during implementation means discarding the most expensive work. An API reviewed by consumers before implementation is an API that won't need to be redesigned.

### Testing precedes Deployment because:
A system deployed to a shared environment without a test suite creates confidence in behaviors that have not been verified. That confidence is false and dangerous.

### Optimization comes last because:
Optimization without measurement is speculation. Measurement without a baseline is guesswork. The baseline comes from production observation, which comes after deployment.

---

## Non-Negotiable

The Architectural Order is non-negotiable because the dependencies between phases are real, not bureaucratic. Skipping Phase 6 (Database) to reach Phase 8 (Implementation) does not save time — it produces an implementation that must be rewritten when the schema is designed correctly.

The architectural order does not mean that phases cannot be revisited. It means they cannot be skipped. A specification that reveals a flaw in the domain model sends the team back to Phase 3. That is correct behavior, not process failure. The alternative — continuing to Phase 8 with a flawed domain model — is what process failure looks like.
