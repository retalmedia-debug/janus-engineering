---
name: Integration Request
about: Request a new integration with another JANUS service or external system
title: "integration: {{SERVICE_NAME}} → [Producer Service]"
labels: ["integration-request", "needs-jac-review"]
assignees: ""
---

<!-- Integration governance: docs/governance/cross-service-integration-governance.md in janus-engineering -->
<!-- File in janus-engineering (not this service) using: .github/ISSUE_TEMPLATE/integration-request.md -->

## Services Involved

**Consumer (this service — {{SERVICE_NAME}}):** `{{SERVICE_REPO}}`
**Producer (the service or system being integrated with):**

## Integration Mechanism

- [ ] Synchronous REST API call from {{SERVICE_NAME}} to producer
- [ ] Asynchronous Event — {{SERVICE_NAME}} subscribes to producer events
- [ ] External system (not a JANUS service)

## What Is Needed

<!-- What data, operation, or capability does {{SERVICE_NAME}} need from the producer? Be specific. -->

## Why It Cannot Be Handled Within {{SERVICE_NAME}}'s Domain

<!-- Explain why this data or operation cannot exist within this service's bounded domain. -->

## Dependency Direction

**{{SERVICE_NAME}} implementation position:** [[FILL: 1-10]]
**Producer implementation position:** [[FILL: 1-10]]

- [ ] {{SERVICE_NAME}} has a higher sequence number than the producer (forward — allowed without ADR)
- [ ] {{SERVICE_NAME}} has a lower sequence number than the producer (backward — requires JAC ADR)

## Proposed Contract

<!-- Describe the integration: endpoint + method for REST, or event type for async events. -->

## Failure Handling

**What does {{SERVICE_NAME}} do if the producer is unavailable?**

---

*This issue should be filed in the `janus-engineering` repository, not here. Open it there using `.github/ISSUE_TEMPLATE/integration-request.md`. The JAC must approve before implementation begins.*
