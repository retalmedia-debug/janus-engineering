<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/quality-gates.md -->

# Quality Gates

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Pre-Commit Gate (local)

Runs via lint-staged on `git commit`:

| Check | Tool | Failure Action |
|---|---|---|
| Format | Prettier | Auto-fix and re-stage |
| Lint | ESLint | Fail commit |
| Type check | `tsc --noEmit` | Fail commit |
| Commit message | commitlint | Fail commit |

---

## Pre-Merge Gate (CI)

All checks run on every PR. **All must pass before merge.**

| Job | Check | Fail Condition |
|---|---|---|
| compliance | JANUS compliance check | Any required file missing or any prohibited pattern found |
| lint | ESLint + Prettier + tsc | Any error |
| test | Unit + integration tests | Any test fails or coverage below threshold |
| security | `pnpm audit` | Critical or High CVE found |

---

## Coverage Thresholds

| Scope | Minimum |
|---|---|
| Overall | 80% |
| Auth / security logic | 90% |
| [[FILL: core domain logic]] | [[FILL: %]] |

Coverage below threshold blocks merge. Coverage is not a quality measure in isolation — tests must be meaningful.

---

## Pre-Release Gate

Before any release tag is created:

- [ ] All pre-merge gates pass on `main`
- [ ] Release branch merged with merge commit (not squash)
- [ ] CHANGELOG updated
- [ ] Version bumped in `package.json`
- [ ] CSA sign-off obtained
- [ ] No P0 or P1 open bugs related to the release scope

---

## Gate Override Policy

No gate may be bypassed except:

- Hotfix with documented justification in the PR
- CSA approves the bypass explicitly in writing (PR comment)
- Bypass is logged in the CHANGELOG as a known issue

`--no-verify` for git hooks is prohibited without CSA approval.
