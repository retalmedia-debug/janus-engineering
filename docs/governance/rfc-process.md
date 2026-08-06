# RFC Process

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

A Request for Comment (RFC) is the mechanism by which changes to JANUS Engineering Standards, templates, and ecosystem ADRs are proposed, discussed, and decided. The RFC process ensures that changes that affect all JANUS services are made deliberately, with input from all affected parties, and with a documented rationale.

---

## When an RFC Is Required

An RFC is required for:
- Adding a new standard to `standards/`
- Changing the content of an existing standard (any change beyond typo fixes)
- Deprecating or removing a standard
- Adding or significantly changing a template in `templates/`
- Proposing a new ecosystem ADR
- Superseding an existing ecosystem ADR
- Changing the RFC process itself

An RFC is NOT required for:
- Fixing a typo or grammatical error in a standard (PATCH — no RFC, just a PR)
- Updating code examples in a standard to reflect a new library version
- Adding a new service to the service registry
- Updating compliance records

---

## RFC Lifecycle

```
Step 1 — Proposal
  Author opens a GitHub Issue using the rfc-standard-change.md template.
  The Issue must include:
  - What is being proposed (new standard, change to existing, deprecation)
  - Why the change is needed (problem being solved, improvement being made)
  - Which services are affected
  - Estimated migration effort for each affected service
  - Proposed grace period (30 / 60 / 90 days based on change severity)

  ↓

Step 2 — Comment Period (minimum 14 calendar days)
  All JANUS service CSAs are notified via GitHub mention
  Engineers across JANUS services may comment on the Issue
  The author responds to questions and refines the proposal based on feedback
  Objections must be specific: "This change conflicts with X because Y"
  The comment period may be extended by the JAC if significant unresolved objections exist

  ↓

Step 3 — JAC Disposition (within 5 business days of comment period close)
  Options:
  - Accept — proceed to implementation
  - Accept with modifications — author updates the proposal; no additional comment period unless changes are substantial
  - Defer — revisit at a specified future date with specified additional information
  - Reject — with documented rationale; issue is closed; the rejection is preserved

  ↓

Step 4 — Implementation PR
  If Accepted: author (or assigned implementer) opens a PR against janus-engineering
  PR implements the standard change, template change, or ADR
  PR is reviewed by at least one JAC member
  PR title follows conventional commit format: feat(standards): add containerization standard
  PR merges after JAC approval

  ↓

Step 5 — Suite Version Bump
  The change is assessed for semantic version impact:
  - Typo fix → PATCH (rare at this stage — most patches bypass RFC)
  - New standard or additive template change → MINOR
  - Breaking change to mandatory standard → MAJOR
  The VERSION file and CHANGELOG.md are updated in the implementation PR

  ↓

Step 6 — Service Notification
  The notify-services workflow creates a GitHub Issue in each registered service with:
  - Link to the change
  - Summary of what changed
  - Grace period deadline
  - Migration guidance

  ↓

Step 7 — Grace Period
  Services have the grace period to update their compliance declaration and apply the change
  The old standard remains documented during the grace period
  After the grace period, the compliance check enforces the new standard
```

---

## Grace Periods by Change Severity

| Change Type | Minimum Grace Period |
|---|---|
| PATCH — clarification, no behavioral change | 0 days — effective immediately |
| MINOR — new standard or template added | 60 days |
| MAJOR — breaking change to existing mandatory standard | 90 days |

Grace periods begin on the date the implementation PR merges, not on the date the RFC was opened.

---

## Objection Handling

An objection is a specific, technical concern about the proposed change. An objection must state:
- What specifically is problematic
- Why it is problematic for a specific service or use case
- What alternative would address the underlying need without the problem

An objection that is only "we don't want to change" is not a qualifying objection. The comment period exists for technical input, not for blocking change.

The JAC resolves objections by:
- Accepting the objection and modifying the proposal
- Rejecting the objection with documented rationale
- Deferring until the objection can be resolved with additional information

---

## Emergency RFC

For security-related changes to standards (e.g., a vulnerability is discovered that requires an immediate change to the security baseline), an emergency RFC may proceed with a shortened comment period of 48 hours with mandatory notification to all service CSAs. Emergency RFCs require JAC approval via direct communication (not just a GitHub comment) before they proceed to implementation.

Emergency RFCs are rare. Defining what constitutes an emergency is the JAC's responsibility.
