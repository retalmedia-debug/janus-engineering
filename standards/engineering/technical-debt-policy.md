# Technical Debt Policy

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Technical debt is not a failure. It is the result of making reasonable time-bound decisions under uncertainty. The problem is not that debt exists — it is that debt that is not tracked, prioritized, and repaid grows silently until it controls the team rather than the other way around.

This standard defines how JANUS services classify, track, prioritize, and repay technical debt.

---

## Definition

Technical debt is any code, configuration, schema, documentation, or architectural decision that:
- Is known to be suboptimal
- Will require additional effort in the future if not addressed
- Has been accepted consciously as a time-bounded trade-off

**Not all shortcuts are debt.** A pragmatic implementation that reflects the current requirements is not debt. Debt is specifically a gap between the current implementation and the implementation that would be correct given full knowledge and time.

---

## Debt Classification

| Class | Description | Examples |
|---|---|---|
| **Design Debt** | Architectural or structural decisions that do not match the current understanding of the domain | Wrong domain model, inappropriate coupling between modules, missing abstraction |
| **Code Debt** | Code that works but is fragile, hard to understand, or hard to modify | Overly complex logic, missing type safety, inconsistent patterns |
| **Test Debt** | Missing or insufficient test coverage | Untested critical paths, flaky tests left unresolved, no integration tests for a module |
| **Documentation Debt** | Missing or outdated documentation | Undocumented API behavior, stale architecture diagrams, missing onboarding content |
| **Infrastructure Debt** | Infrastructure or configuration that is not maintainable or scalable | Manual provisioning steps, hardcoded environment values, missing monitoring |
| **Dependency Debt** | Dependencies that are outdated, unsupported, or require migration | Pinned to a vulnerable version, deprecated framework, unmaintained package |
| **Schema Debt** | Database schema decisions that create friction in the application layer | Missing indexes, denormalized data that has become inconsistent, abandoned columns |

---

## Incurring Debt

Debt is incurred when a known-suboptimal decision is made deliberately. The discipline is in tracking it, not in avoiding it.

When debt is incurred:
1. A GitHub Issue is created immediately — not "after the PR", not "next week"
2. The issue is labeled `technical-debt`
3. The issue is assigned a priority (see Prioritization below)
4. A reference to the issue number is added to the relevant code, comment, or document where the debt was incurred: `// TODO(#123): remove this workaround once X is resolved`
5. The issue is added to the Debt Register

A `TODO` without an issue reference is not tracked debt — it is abandoned debt. Abandoned debt has no resolution date and no accountability.

---

## Debt Register

The Debt Register is maintained as GitHub Issues in the service repository with the label `technical-debt`. It is the authoritative view of all known debt.

The CSA reviews the Debt Register monthly and the team reviews it at the start of each sprint planning session.

---

## Prioritization

| Priority | Criteria | Target Resolution |
|---|---|---|
| **P1** | Actively causing bugs, security risk, or blocking development velocity | Next sprint |
| **P2** | Degrading development velocity or reliability, but not blocking | Within 30 days |
| **P3** | Known suboptimal, no immediate impact | Within a quarter |

Prioritization is set by the CSA. Engineers may propose priority changes with rationale.

---

## 20% Sprint Capacity Rule

A minimum of **20% of every sprint's capacity** is reserved for technical debt repayment.

This is not a target — it is a floor. The team may allocate more than 20% to debt in any given sprint. It may not allocate less without explicit CSA approval and a documented reason.

Debt repayment work is tracked in sprint planning with the same visibility as feature work. Debt repayment is not a secondary-class activity.

---

## Debt Sprint Trigger

When the Debt Register contains **15 or more open P1 + P2 items**, a Debt Sprint is triggered.

A Debt Sprint:
- Contains no new feature development
- Is dedicated entirely to P1 and P2 debt resolution
- Continues until the P1 + P2 count falls below 8
- Is announced to all stakeholders with a clear scope statement

Debt Sprints are not a sign of failure. They are the mechanism that prevents debt from becoming unmanageable.

---

## What Is Not Debt

The following are not technical debt and should not be tracked as such:

- **Known intentional limitations** — A feature intentionally not built is a product decision, not debt
- **Future requirements not yet needed** — "We might need this someday" is not debt
- **Style preferences** — Personal code style preferences that don't affect quality, maintainability, or correctness
- **Exploration spikes** — Code written to understand a problem, not intended to ship, is not debt when deleted

Tracking non-debt items as debt inflates the Debt Register and makes true debt harder to prioritize.
