---
name: Technical Debt
about: Track a known suboptimal decision that needs to be repaid
title: 'debt: [Short description]'
labels: technical-debt
assignees: ''
---

## Debt Class

- [ ] Design Debt — structural/architectural issue
- [ ] Code Debt — fragile or hard-to-modify code
- [ ] Test Debt — missing or insufficient test coverage
- [ ] Documentation Debt — missing or outdated documentation
- [ ] Infrastructure Debt — unmaintainable configuration
- [ ] Dependency Debt — outdated or unsupported dependency
- [ ] Schema Debt — suboptimal database schema

## Description

<!-- What is the suboptimal decision or implementation? -->

## Where Is It?

<!-- File paths, function names, database tables, etc. -->

## Why Was It Accepted?

<!-- What trade-off was made at the time? -->

## Impact

<!-- What problems does this debt cause today? -->

## Priority

- [ ] P1 — Blocking development velocity or causing bugs
- [ ] P2 — Degrading velocity, no immediate blocking impact
- [ ] P3 — Known suboptimal, no current impact

## Proposed Resolution

<!-- How should this be fixed? Roughly how much effort? -->

## Acceptance Criteria

<!-- How will we know this debt is repaid? -->

---

*Technical debt is governed by the [Technical Debt Policy](../../docs/governance/technical-debt-policy.md).*
*20% of every sprint's capacity is reserved for debt repayment.*
