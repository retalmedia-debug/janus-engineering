<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/definition-of-done.md -->

# Definition of Done — {{SERVICE_NAME}}

**Version:** 1.0.0
**Status:** Draft
**Owner:** Chief Software Architect
**Last Reviewed:** {{DATE}}

---

## Universal Criteria

These criteria apply to all work in `{{SERVICE_REPO}}` regardless of type:

- [ ] Code compiles with zero TypeScript errors (`strict: true`)
- [ ] All existing tests pass
- [ ] Linting passes (`@janus/eslint-config` — zero errors)
- [ ] Formatting passes (Prettier — zero differences)
- [ ] No new `any` types introduced without inline justification comment
- [ ] No secrets, credentials, or PII in code or test fixtures
- [ ] PR description accurately describes what changed and why
- [ ] Commit messages follow Conventional Commits format
- [ ] PR size is within limits (≤ 400 LOC soft limit; ≤ 800 LOC hard limit)
- [ ] No `--no-verify` was used at any point in the PR lifecycle

---

## Feature DoD

All universal criteria, plus:

- [ ] Acceptance criteria from the specification are met
- [ ] Unit tests cover the new code (≥ 80% coverage maintained)
- [ ] Integration tests cover any new database interactions
- [ ] Any new API endpoint has an OpenAPI specification entry
- [ ] Any new database table has RLS enabled and tested
- [ ] Any new database migration follows the migration governance standard
- [ ] Documentation updated in the same PR (API docs, schema docs, relevant governance)
- [ ] Error codes are registered in the error catalog if new ones were added
- [ ] Feature flag retired if the flag that guarded this feature is now at 100%

[[FILL: Add service-specific feature DoD items relevant to your tech stack]]

---

## Bug Fix DoD

All universal criteria, plus:

- [ ] The bug is reproduced by a test that existed or has been added
- [ ] The fix is targeted — no unrelated changes in the same PR
- [ ] Root cause is documented in the PR description
- [ ] If the bug reveals a missing test: that test is added

---

## Database Migration DoD

All universal criteria, plus:

- [ ] Migration header comment is complete (author, date, description, estimated duration, reversibility)
- [ ] Migration applies cleanly via `supabase db reset` locally
- [ ] Down migration is documented (SQL comment or explanation of irreversibility)
- [ ] RLS policies are included for any new table
- [ ] Migration has been reviewed by CSA
- [ ] Schema documentation in `docs/database/schema/` is updated in the same PR

---

## Release DoD

- [ ] All PRs for this release are merged to `develop`
- [ ] All tests pass on the release branch
- [ ] E2E tests pass against staging
- [ ] CHANGELOG.md is updated with the release content
- [ ] Version is bumped per the versioning strategy
- [ ] CSA has approved the release
- [ ] Rollback procedure is ready and documented
- [ ] All known consumers of changed APIs have been notified

---

## Documentation DoD

- [ ] Document header is complete (Version, Status, Owner, Last Reviewed)
- [ ] No `[[FILL:]]` or `[[DECISION REQUIRED:]]` markers remain
- [ ] Internal links are valid (no broken references)
- [ ] Document is added to `docs/INDEX.md` if new
- [ ] Document Status updated to `Active` if previously `Draft`
