---
name: New Service Registration
about: Propose and register a new JANUS service (Phase 0 — Domain Brief)
title: 'New Service: [SERVICE_NAME]'
labels: service-registration, new-service
assignees: ''
---

## Service Name

**Codename:** <!-- UPPERCASE (e.g., VENUS) -->
**Repository:** <!-- lowercase-hyphenated-v1 (e.g., venus-v1) -->
**Log identifier:** <!-- lowercase (e.g., venus) -->

## Domain Brief

### What does this service do?

<!-- 1-2 paragraphs describing the service's function -->

### What domain does it own?

<!-- What data does it hold? What entities does it manage? -->

### Why can this not be a feature of an existing JANUS service?

<!-- Justify the domain boundary and the need for an independent deployment lifecycle -->

### Which existing JANUS services will it integrate with?

<!-- List the integration points and the nature of each integration -->

## Requesting Team

- **CSA (proposed):** 
- **Service owner / business unit:** 

## Ecosystem ADR Required?

- [ ] Yes — new technology, new integration mechanism, new deployment topology
- [ ] No — this service follows existing ecosystem patterns

*If yes, the ADR must be accepted before Gate 1.2 (repository scaffold).*

---

*This issue represents Phase 0, Gate 0.1 of the new service lifecycle.*
*See `docs/guides/new-service-lifecycle.md` for the full process.*
