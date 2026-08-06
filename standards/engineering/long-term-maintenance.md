# Long-Term Maintenance

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Systems do not maintain themselves. Without deliberate, scheduled maintenance activities, codebases accumulate drift between documentation and reality, dependencies drift toward vulnerability, performance baselines erode silently, and knowledge concentrates in the minds of the engineers who built the system — until those engineers leave.

This standard defines the minimum maintenance cadence for all JANUS services.

---

## Maintenance Cadence

| Practice | Frequency | Owner | Output |
|---|---|---|---|
| Dependency security audit | Monthly | Engineer assigned in sprint | Updated dependencies or tracked CVEs |
| Dependency routine update | Quarterly | Engineer assigned in sprint | Batch minor/patch updates in a single PR |
| Dead code audit | Semi-annually | CSA | Deleted dead code or tracked issues |
| Documentation accuracy review | Quarterly | CSA | Updated documents or tracked issues |
| Technical debt register review | Monthly | CSA + full team | Reprioritized debt items |
| Performance baseline review | Quarterly (post-launch) | Engineer | Updated baselines or tracked regressions |
| ADR relevance review | Annually | CSA | Deprecated or superseded ADRs |
| Schema maintenance review | Quarterly | CSA | Removed unused columns, rebuilt bloated indexes |

---

## Dependency Health Standards

A dependency is considered **at-risk** when any of the following are true:
- Last commit to the upstream repository was more than 12 months ago
- The package has open critical or high-severity CVEs with no patch available
- The package's license has changed to a prohibited license
- The package's maintainer has transferred ownership to an unknown entity
- A major new version has been released and the current version is in maintenance-only mode

At-risk dependencies are flagged in the quarterly dependency review and assigned a P1 or P2 debt item depending on severity.

---

## Dead Code Elimination

Dead code is any code that is no longer executed in any environment, by any path, in any condition.

Dead code:
- Provides no value (it does not execute)
- Creates maintenance cost (it must be read and understood by engineers encountering it)
- Creates confusion (engineers wonder if it is planned for future use)

**Dead code must be deleted.** Commenting out code is not deletion — it is visible dead code with the illusion of preservation. If code should be preserved for reference, it exists in git history.

**What is NOT dead code:**
- Feature-flagged code in an inactive state (it executes conditionally)
- Test utilities that are exercised by tests
- Exported symbols in packages that have external consumers

**Dead code identification:**
- TypeScript's `noUnusedLocals` and `noUnusedParameters` catch some dead code at compile time
- `ts-unused-exports` or equivalent identifies unused exports
- Code coverage reports identify untested code (which may indicate dead code)

---

## API Contract Maintenance

APIs that are `Deprecated` have a migration guide published. The migration guide is maintained until the API is `Retired`.

APIs that are `Retired` have their implementation removed from the codebase — not commented out, not feature-flagged off, removed. Retired APIs that remain in the codebase create confusion and maintenance burden.

The service's `docs/api/error-catalog.md` is reviewed whenever an API changes.

---

## Knowledge Preservation

**Bus factor** — The minimum number of engineers who must leave before a service becomes undeliverable — must be ≥ 2 at all times.

When a service's bus factor drops to 1:
1. A knowledge transfer sprint is initiated within the next planning cycle
2. The CSA actively pairs engineers on the at-risk components
3. The at-risk areas are documented before any other development work proceeds

**ADR maintenance** — ADRs describe decisions at a point in time. As context changes, ADRs become historical record, not operational guidance. The annual ADR review:
- Marks ADRs that no longer reflect the system as `Superseded` with a reference to the current approach
- Does not rewrite accepted ADRs — supersedes them with new ones

**Runbook maintenance** — Runbooks that describe procedures that no longer exist are more dangerous than no runbook. They create false confidence. Runbooks are reviewed and updated any time the procedure they describe changes.

---

## Performance Baselines

After production launch, performance baselines are established for:
- P50, P95, and P99 response time per endpoint
- Database query execution time for the top 10 most-frequent queries
- Memory and CPU utilization under typical load

A regression is defined as a >20% degradation in any tracked metric from baseline. A regression:
- Is logged as a P1 debt item immediately upon detection
- Blocks the next production release if it affects a customer-facing path
- Requires a root cause investigation before the release gate is lifted

Baselines are stored in `docs/operations/performance-baselines/` and updated after each major release.

---

## Schema Maintenance

Database schemas accumulate maintenance needs over time:

- **Unused columns** — Columns no longer read or written by application code are candidates for removal via migration. Removal requires confirmation that no external process or reporting tool reads the column.
- **Index hygiene** — `pg_stat_user_indexes` identifies indexes with zero or near-zero usage. Unused indexes increase write overhead with no query benefit.
- **Bloat management** — Tables with high update/delete rates accumulate dead tuples. AUTOVACUUM handles most cases; the quarterly review confirms it is configured appropriately.
- **Data retention** — Time-series tables are reviewed quarterly to confirm the retention policy is being applied and data is not accumulating beyond the retention window.

---

## Deprecation Lifecycle

No feature, API version, or module is deprecated without going through the full lifecycle:

```
Active → Deprecated → Removed
```

**Deprecated** means: the feature is still available, but users/consumers are notified it will be removed. A removal date is announced. Migration guidance exists.

**Removed** means: the feature is gone from the codebase, not just disabled.

The step from Deprecated to Removed must not be skipped. A deprecated feature that is silently removed without the Removed step completed is an incident waiting to happen.
