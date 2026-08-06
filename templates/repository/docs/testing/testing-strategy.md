<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/testing/testing-strategy.md -->

# Testing Strategy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS testing standard: `standards/testing/testing-philosophy.md` in `janus-engineering`

---

## Test Pyramid for {{SERVICE_NAME}}

| Level | Target % | Focus |
|---|---|---|
| Unit | 60% | Pure functions, domain logic, transformations — no I/O |
| Integration | 30% | Real database, real service calls (no mocks at boundaries) |
| E2E | 10% | Critical user journeys through the full stack |

---

## Test Runner and Tooling

| Tool | Purpose |
|---|---|
| [[FILL: e.g., Vitest]] | Unit and integration test runner |
| [[FILL: e.g., Playwright / Supertest]] | E2E / API integration tests |
| [[FILL: e.g., @supabase/test-helpers]] | Database test setup |

---

## Coverage Thresholds

| Scope | Minimum Coverage |
|---|---|
| Overall (lines) | 80% |
| Auth / access control | 90% |
| [[FILL: Core domain logic area]] | [[FILL: %]] |
| [[FILL: Data validation]] | [[FILL: %]] |

Coverage below threshold blocks merge. Configure in [[FILL: vitest.config.ts / jest.config.ts]].

---

## Unit Tests

**Location:** `tests/unit/`
**Mirror structure:** `src/services/user.ts` → `tests/unit/services/user.test.ts`

Rules:
- No database calls, no network calls, no file I/O
- No `setTimeout` or real timers (use fake timers)
- Arrange-Act-Assert structure
- One behavior assertion per test (multiple `expect` calls are fine if they verify the same behavior)

---

## Integration Tests

**Location:** `tests/integration/`

Rules:
- Use a real local database (never a mock ORM)
- Each test suite seeds its own data and cleans up after
- Tests must be runnable in any order — no shared mutable state between suites
- [[FILL: Database setup steps for this service — e.g., "Run `supabase start` before integration tests"]]

---

## E2E Tests

**Location:** `tests/e2e/`

Rules:
- Test critical paths only — not every permutation
- No production data
- Must be runnable in CI against a dedicated test environment
- [[FILL: E2E infrastructure details — e.g., "Uses a dedicated Supabase project seeded by the CI workflow"]]

---

## Test Data

- Test data is isolated per test or suite — never shared global state
- No production data in tests — ever
- Fixtures for complex objects live in `tests/fixtures/`
- Random UUIDs are generated per-test for entity IDs

---

## Flaky Test Policy

Per JANUS standards:
- A flaky test is a P1 bug — open an issue immediately
- Flaky tests must not be indefinitely skipped with `.skip`
- A skipped test must have a corresponding open issue linked in the `skip` comment
- Deadline for fixing: within the current sprint, escalate if not resolved

---

## What Is Not Tested Here

[[FILL: Be explicit about what types of tests are out of scope for this service. Example: "Performance load tests are not part of this service's test suite. See docs/operations/observability-strategy.md for performance baseline monitoring."]]
