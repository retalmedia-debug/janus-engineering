# Testing Philosophy

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Tests are not a bureaucratic requirement. Tests are the mechanism by which a team proves, to themselves and to each other, that the software does what they claim. A codebase without tests is a codebase where every change is an experiment with unknown outcomes run in production.

This standard defines the philosophy that governs all testing in JANUS services. Coverage thresholds, tooling selection, and test organization are defined per service in their `docs/testing/testing-strategy.md`.

---

## Three Principles

### Principle 1 — Tests Must Be Deterministic

A test that sometimes passes and sometimes fails is not a test. It is a coin flip with overhead. Flaky tests erode confidence in the entire test suite — when tests fail inconsistently, engineers stop trusting the suite and start merging on the assumption that the failure is noise.

A failing test is either a real problem or a flaky test. If it is a real problem, fix the code. If it is flaky, it is a P1 bug. Flaky tests are not suppressed or quarantined indefinitely — they are fixed.

A test is deterministic when:
- It produces the same result regardless of test execution order
- It produces the same result regardless of other tests running concurrently
- It does not depend on time, random numbers, or external service availability
- It does not share mutable state with other tests

### Principle 2 — Tests Must Be Fast

Slow tests are not run. Tests that are not run do not catch bugs. A test suite that takes 45 minutes to run will be skipped locally, run only in CI, and will not be consulted when an engineer needs to verify a quick change.

Speed targets (enforced per service in their testing strategy):
- Unit tests: each test completes in <100ms; full unit suite in <5 minutes
- Integration tests: full suite in <15 minutes
- E2E tests: full suite in <20 minutes

When a test is slow, the cause is usually: a real external call that should be isolated, a missing test database index, or a test that is doing too much. Fix the cause.

### Principle 3 — Tests Must Produce Honest Failure

A test that passes when the thing it tests is broken is worse than no test. It creates false confidence.

Tests must:
- Assert the actual behavior, not just that no error was thrown
- Assert the specific result, not just that a result exists
- Assert the boundary conditions, not just the happy path
- Fail with a message that tells the engineer what broke and what the expected behavior was

A test that does not fail when the code is wrong is not a test.

---

## Test Pyramid

All JANUS services implement a test pyramid with these ratios:

```
        /\
       /E2E\         10% — critical paths, full system
      /------\
     /  Integ  \     30% — real database, real integrations
    /------------\
   /    Unit      \  60% — pure logic, no IO
  /________________\
```

**Why these ratios:**
- Unit tests are cheap, fast, and pinpoint-precise. They should be most of the suite.
- Integration tests catch the class of bugs that unit tests cannot: incorrect queries, schema-code mismatches, authorization policy errors. They cost more but are irreplaceable.
- E2E tests verify that the entire system works from the user's perspective. They are slow and expensive to maintain. They cover critical paths only.

The pyramid is a ratio guide, not a strict count. A service with complex business logic may have more unit tests. A service that is primarily a data routing layer may have more integration tests. The pyramid shape — many small fast tests at the base, few large slow tests at the top — is non-negotiable.

---

## Test Types

### Unit Tests

Test a single function, module, or class in isolation. No database. No network. No filesystem.

- Co-located with the code they test: `user.service.ts` → `user.service.test.ts`
- Dependencies are replaced with fakes or stubs
- Each test covers one behavior: one input condition, one outcome

The database is never mocked in JANUS services. Mock databases diverge from real database behavior (type coercions, constraint enforcement, lock behavior). If a test requires a database, it is an integration test.

### Integration Tests

Test the interaction between application code and real infrastructure (database, queue, external API sandbox).

- Use a real local database instance (not an in-memory substitute)
- Run in a controlled environment with known seed data
- Each test is isolated: it starts from a clean, known state and leaves no side effects for subsequent tests
- Integration tests for database interactions verify: correct data is returned, constraints are enforced, RLS policies behave correctly

### End-to-End Tests

Test the full system from the user's perspective — HTTP request in, observable state change or response out.

- Cover critical user paths only
- Are owned by the team, not by a separate QA function
- Run against a deployed staging environment or a full local stack
- Fail fast: if a critical path is broken, the suite does not continue

### Contract Tests

When a JANUS service is a consumer of another JANUS service's API, consumer-driven contract tests define the expected API behavior. The provider verifies that its implementation satisfies the consumer's contract.

Contract tests prevent the class of bugs where a provider makes a change that is valid from its perspective but breaks a consumer.

---

## Test Naming

Test names describe behavior, not implementation:

```typescript
// Wrong
it('getUserById', ...)
it('should work', ...)
it('test 1', ...)

// Correct
it('returns the user when the id exists', ...)
it('returns 404 when the user does not exist', ...)
it('returns 403 when the requesting user does not own the resource', ...)
```

A test name that reads as a behavioral statement is a test name that becomes useful documentation.

---

## Test Data

- No shared mutable test data between tests
- Seed data is realistic in shape but not real in content (no real names, addresses, credentials)
- Test UUIDs use recognizable patterns: `00000000-0000-0000-0000-000000000001`
- Each test creates its own data and cleans up after itself (or uses transactional isolation)
- Production data is never used in tests

---

## Coverage

Coverage thresholds are defined per service in their `docs/testing/testing-strategy.md`. The JANUS ecosystem minimums:

| Scope | Minimum Coverage |
|---|---|
| Overall service | 80% |
| Authentication and authorization code | 90% |
| Core business logic | 90% |

Coverage is a floor, not a ceiling. Coverage below the threshold blocks CI. Coverage above the threshold does not mean the tests are good — a test with 100% coverage that makes no meaningful assertions is not a good test.

---

## Flaky Test Policy

A flaky test is a P1 bug.

- A flaky test is not skipped with `xit` or `.skip` indefinitely
- A flaky test is not merged with a "we'll fix it later" comment
- A flaky test is either fixed before the PR merges or removed and tracked as a P1 bug with a resolution deadline
- Quarantining flaky tests (permanently disabling them) is not an acceptable resolution

The test suite is only useful if it is trusted. Flaky tests erode that trust faster than any other force.
