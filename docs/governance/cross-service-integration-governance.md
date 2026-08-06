# Cross-Service Integration Governance

**Classification:** [JES] JANUS Governance Document
**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/api/api-design-standard.md` · `standards/api/event-schema-standard.md` · `docs/ecosystem-map.md` · `docs/governance/ecosystem-service-roadmap.md`

---

## Purpose

Integration between JANUS services is the highest-risk activity in the ecosystem. It creates coupling that outlasts the original developer, version constraints that affect multiple teams, and failure modes that span trust boundaries. This document governs how integrations between JANUS services are proposed, approved, designed, implemented, and maintained.

---

## Core Principles

1. **No shared databases.** Each service owns its data. Other services integrate through published API contracts — never through direct database access.

2. **Contracts before implementation.** The integration contract (OpenAPI spec or event schema) must be agreed upon and documented before any implementation begins on either side.

3. **Producer owns the contract.** The service producing an API or event owns its schema. Consumers have no right to demand changes; changes go through the RFC process.

4. **Consumers pin versions.** A consuming service pins the version of the API or event schema it depends on. Consuming from `latest` or `main` is prohibited.

5. **Integration follows sequence.** A service may only integrate with services that precede it in the canonical implementation sequence. Integration "backward" in the sequence (a lower-numbered service depending on a higher-numbered service) requires a JAC ADR.

---

## Integration Approval Process

Before any integration between two JANUS services may be implemented:

### Gate 1: Integration Justification

The integrating team files an issue using the Integration Request template (see `.github/ISSUE_TEMPLATE/`). The issue must document:

- Which services are integrating (consumer → producer)
- What data or capability is needed
- Why it cannot be provided within the consumer's own domain
- Proposed mechanism: synchronous REST API or asynchronous event

### Gate 2: JAC Review

The JAC reviews the integration request. JAC disposition:

- **Approved** — Integration is consistent with ecosystem design
- **Redirect** — The capability should live in a different service
- **Denied** — The integration introduces unacceptable coupling

### Gate 3: Contract Design

Once approved, the producer designs the integration contract:

- **REST API:** An OpenAPI 3.1.0 specification is written and reviewed before implementation
- **Event:** An event schema following `standards/api/event-schema-standard.md` is documented before implementation

The contract must be reviewed by both the consumer and a principal-level reviewer. Contract review precedes all implementation.

### Gate 4: Contract Acceptance

Both services' CSAs sign off on the contract before implementation begins. The accepted contract is committed to the producer service's repository (`docs/api/openapi.yaml` or `docs/api/event-catalog.md`).

### Gate 5: Implementation and Testing

Implementation proceeds. Integration tests must use the actual API/event contract — no mocking the contract.

### Gate 6: Ecosystem Map Update

After the integration is live in production, `docs/ecosystem-map.md` in `janus-engineering` is updated to reflect the integration point.

---

## Integration Patterns

### Synchronous REST

Use when:
- The consumer needs an immediate response to proceed
- The operation is idempotent or appropriately guarded
- Failure must be handled inline

Requirements:
- 30-second timeout maximum
- 3-retry with exponential backoff (1s, 2s, 4s) for transient failures
- Circuit breaker for sustained dependency failures
- `X-Request-ID` header forwarded from inbound request to all outbound calls

### Asynchronous Event

Use when:
- The consumer does not need an immediate response
- The operation can tolerate delays
- Multiple consumers might be interested in the same event

Requirements:
- CloudEvents v1.0 envelope per `standards/api/event-schema-standard.md`
- Consumer must be idempotent (same event may arrive more than once)
- Dead letter handling for events that cannot be processed after N retries
- `correlationid` field forwarded from triggering request

---

## Versioning and Breaking Changes

When a producer needs to make a breaking change to an integration contract:

1. **Notify all consumers in writing** — via GitHub issue tagged to each consuming service's repository
2. **File an RFC** — breaking integration changes require the standard RFC process with 14-day comment period
3. **Provide migration window** — minimum 90 days (MAJOR change grace period)
4. **Dual-publish during migration** — the old and new versions coexist during the grace period
5. **Deprecate, then remove** — the old version is marked deprecated before removal

A breaking change in an integration contract bumps the producer's MAJOR version.

---

## Integration Register

All active JANUS service integrations are registered in `docs/ecosystem-map.md`. The register entry format:

```
[Consumer Service] → [Producer Service]
  Direction: Consumer calls Producer
  Mechanism: REST API / Event
  Contract: [link to spec]
  Consumer pins: [version]
  Established: YYYY-MM-DD
  Status: Active / Deprecated
```

The ecosystem map is the single source of truth for integration topology. Any integration not registered there is unauthorized.

---

## Prohibited Integrations

The following integration patterns are prohibited in the JANUS ecosystem:

| Pattern | Why Prohibited |
|---|---|
| Direct database access across service boundaries | Creates tight schema coupling; the owning service cannot change its schema without breaking consumers |
| Shared authentication credentials | Services authenticate independently; credentials are never shared across service boundaries |
| Integration "backward" in the sequence without ADR | Creates coupling that violates the implementation sequence's dependency logic |
| Undocumented integrations | Integrations that exist in code but not in `docs/ecosystem-map.md` are architectural drift |
| Polling a service's API at high frequency | Use events for high-frequency data changes; polling degrades producer performance |
