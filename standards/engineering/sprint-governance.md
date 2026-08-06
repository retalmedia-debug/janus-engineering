# Sprint Governance Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS services with active development teams
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/engineering/technical-debt-policy.md` · `docs/governance/new-service-lifecycle.md`

---

## Purpose

This standard governs how JANUS service teams structure, plan, and close development iterations. It ensures that velocity, quality, and technical health remain measurable and comparable across the ecosystem.

---

## Sprint Structure

### Duration

Standard sprint length: **2 weeks**

Deviations require CSA approval and must be documented in `docs/governance/repository-governance.md`.

### Sprint Ceremonies

| Ceremony | Cadence | Attendees | Duration |
|---|---|---|---|
| Sprint Planning | Start of each sprint | Full team + CSA | ≤ 2 hours |
| Daily Standup | Daily (weekdays) | Full team | ≤ 15 minutes |
| Sprint Review | End of each sprint | Team + stakeholders | ≤ 1 hour |
| Sprint Retrospective | End of each sprint | Full team | ≤ 1 hour |
| Backlog Refinement | Mid-sprint | CSA + leads | ≤ 1 hour |

Ceremonies are not negotiable — they are the minimum cadence for a functioning team. Missing a sprint ceremony must be logged as a risk in the sprint retrospective.

---

## Capacity Allocation

Sprint capacity must be allocated as follows:

| Category | Minimum Allocation |
|---|---|
| Feature development | Variable |
| Technical debt repayment | **20% of capacity — non-negotiable** |
| Bug fixes (P1/P2 in current sprint) | As needed — never zero |
| Documentation completion | Included in feature allocation (DoD requires docs) |

The 20% technical debt floor is mandated by `standards/engineering/technical-debt-policy.md`. Teams may allocate more than 20% to debt; never less.

---

## Sprint Planning Requirements

Before a sprint is considered planned, the following must be true:

1. Every item in the sprint has a GitHub Issue with:
   - Clear acceptance criteria
   - Effort estimate (story points or T-shirt size — consistent within service)
   - Architectural phase assignment (which phase of the Architectural Order)
   - Assignee

2. The sprint's technical debt items are selected from the Debt Register (see `standards/engineering/technical-debt-policy.md`)

3. Total planned capacity does not exceed 80% of available team hours (buffer for unplanned work)

4. The CSA has signed off on the sprint plan before development begins

---

## Definition of Done Enforcement

The sprint Definition of Done (`docs/governance/definition-of-done.md`) is enforced at sprint review. An item is not "done" until every applicable criterion is met. Partially complete items do not count toward sprint velocity.

No item may be marked done in the sprint if:
- Its PR is not merged
- Its tests are not passing
- Its documentation is not complete
- Its CI check does not pass

---

## Debt Sprint

When the technical debt register reaches **15 open P1 + P2 items**, the next sprint is declared a **Debt Sprint**. A Debt Sprint has:

- No new feature work
- 100% capacity allocated to debt repayment
- Goal: reduce the register below 10 P1 + P2 items

The CSA declares the Debt Sprint. The Principal Architect is notified. A Debt Sprint is a signal of technical health risk and triggers a retrospective specifically focused on why debt accumulated.

---

## Sprint Review Requirements

At sprint review, the CSA must report:

1. Items completed vs. planned (velocity)
2. Technical debt items resolved
3. Current P1 + P2 debt count (from Debt Register)
4. Any items carried over (and why)
5. Blockers or risks for the next sprint

Sprint review outputs are recorded in the sprint issue or a sprint retrospective document.

---

## Retrospective Action Items

Every retrospective must produce at least one actionable improvement with:
- An assigned owner
- A due date
- A GitHub Issue tracking the action

Retrospective action items that are not tracked in GitHub are considered not real.

---

## Metrics

Each service tracks and reports to the JAC quarterly:

| Metric | Description |
|---|---|
| Sprint velocity | Story points or issues completed per sprint (consistent unit) |
| Debt register P1+P2 count | Measured at sprint end |
| Debt sprint frequency | How often Debt Sprints are triggered |
| Carry-over rate | % of items not completed in their planned sprint |

---

## Services Pre-Implementation

Services in Phases 0–5 (before implementation authorization) follow the Architectural Order, not sprint governance. Sprint governance activates when a service receives Implementation Authorization at Gate 5.3 of the new service lifecycle.
