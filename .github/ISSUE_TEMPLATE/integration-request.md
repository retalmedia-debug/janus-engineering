---
name: Cross-Service Integration Request
about: Propose a new integration between two JANUS services
title: "integration: [Consumer Service] → [Producer Service]"
labels: ["integration-request", "needs-jac-review"]
assignees: ""
---

<!-- Integration governance: docs/governance/cross-service-integration-governance.md -->

## Services Involved

**Consumer (the service that calls or subscribes):** 
**Producer (the service that publishes or serves):**

## Integration Mechanism

- [ ] Synchronous REST API
- [ ] Asynchronous Event (CloudEvents)
- [ ] Webhook

## What Is Needed

<!-- What data, operation, or capability does the consumer need from the producer? Be specific. -->

## Why It Cannot Be Handled Within the Consumer's Domain

<!-- Explain why this data or operation cannot exist within the consuming service's bounded domain. -->

## Proposed Contract

<!-- Describe the integration contract:
- For REST: endpoint, method, request/response shape
- For Events: event type name, data payload shape, trigger condition
-->

## Dependency Direction Validation

**Consumer implementation position:** [1-10]
**Producer implementation position:** [1-10]

- [ ] Consumer is at a higher position number than producer (forward dependency — allowed)
- [ ] Consumer is at a lower position number than producer (backward dependency — requires ADR)

## Failure Handling

**What happens if the producer is unavailable?**

<!-- Describe the consumer's failure behavior: circuit breaker, timeout, fallback, graceful degradation -->

## Consumer CSA Sign-off

- [ ] Consumer CSA has reviewed and approves this integration request: **[Name]**

---

*JAC review required before implementation may begin. See Gate 2 in `docs/governance/cross-service-integration-governance.md`.*
