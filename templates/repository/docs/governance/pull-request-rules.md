<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/pull-request-rules.md -->

# Pull Request Rules

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Review Requirements

| Target Branch | Required Approvals | Required Reviewers |
|---|---|---|
| `develop` | 1 | [[FILL: CSA or designated lead]] |
| `main` (release) | 2 | [[FILL: CSA + Principal Architect]] |
| `main` (hotfix) | 2 | [[FILL: CSA + one senior engineer]] |

---

## PR Size Limits

| Category | Limit |
|---|---|
| Lines changed | < 500 lines preferred; > 800 requires justification in PR description |
| Files changed | < 20 files preferred |
| Exceptions | Database migrations, generated files, bulk renames — note in PR body |

Large PRs must include a rationale explaining why splitting is not practical.

---

## Pre-Merge Requirements

All of the following must be true before any PR is merged:

- [ ] CI is green (all jobs pass)
- [ ] Required approvals obtained
- [ ] Definition of Done checklist completed (`docs/governance/definition-of-done.md`)
- [ ] No unresolved review comments
- [ ] Branch is up to date with target branch
- [ ] PR description is complete (not left as default template)

---

## Turnaround Expectation

| Priority | Review SLA |
|---|---|
| Hotfix / P1 bug | 4 business hours |
| Normal feature / fix | 2 business days |
| Chore / deps | 3 business days |

Reviewers who cannot meet SLA must communicate their timeline or hand off.

---

## Author Responsibilities

- Self-review the diff before requesting review
- Answer reviewer questions within 1 business day
- Do not dismiss review comments without addressing or explicitly deferring them
- Keep PR description updated if scope changes during review

---

## Reviewer Responsibilities

- Review for correctness, not style (CI handles style)
- Distinguish blocking comments from suggestions (use `nit:` prefix for non-blockers)
- Approve only when genuinely satisfied — not as social courtesy
- Do not approve PRs you cannot understand

---

## Draft PRs

Draft PRs are allowed for early feedback. Reviewers are not obligated to review drafts on SLA. Mark ready-for-review explicitly when the PR is complete.

---

## Service-Specific Rules

[[FILL: Any service-specific PR rules. If none, remove this section.]]
