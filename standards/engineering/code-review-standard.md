# Code Review Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS services
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/engineering/git-strategy.md` · `standards/engineering/technical-debt-policy.md` · `templates/repository/docs/governance/pull-request-rules.md`

---

## Purpose

Code review is the primary quality gate for all JANUS services. This standard defines the process, responsibilities, and non-negotiable behaviors for all code reviews across the ecosystem. A consistent review culture prevents the accumulation of unreviewed risk and ensures knowledge remains distributed.

---

## Review Requirements by Target Branch

| Target | Minimum Approvals | Required Reviewers | Notes |
|---|---|---|---|
| `develop` | 1 | Service CSA or designated lead | CSA may delegate to a senior engineer |
| `main` (release) | 2 | CSA + Principal Architect | No exceptions |
| `main` (hotfix) | 2 | CSA + one senior engineer | Clock starts at PR open |

---

## Author Responsibilities

Before requesting review, the author must:

1. **Self-review the full diff** — The author reads every line as if they are the reviewer. PRs submitted without self-review are returned immediately.
2. **Verify CI passes** — No review requests on red CI. Not "almost green" — green.
3. **Complete the PR description** — Title, type of change, what was done and why. Not the default template text.
4. **Complete the Definition of Done checklist** — Self-attested before review is requested.
5. **Keep the PR focused** — One purpose per PR. Mixed-concern PRs are split before review.
6. **Respond to review comments within 1 business day** — Silence on a reviewer's question blocks the PR.

---

## Reviewer Responsibilities

### What Reviewers Must Check

| Category | Check |
|---|---|
| Correctness | Does the code do what the PR description says it does? |
| Architecture | Does it respect layer boundaries (no repository importing from API layer, etc.)? |
| Security | Does it introduce new attack surface, credential exposure, or untrusted input paths? |
| Tests | Are the tests meaningful? Do they test behavior, not implementation? |
| Error handling | Are errors handled explicitly — never silently swallowed? |
| Standards compliance | Does the code follow the naming, TypeScript, and logging standards? |

### What Reviewers Must Not Do

- Approve code they do not understand
- Approve as a social courtesy to unblock a colleague
- Request changes for personal style preferences that are not in the standards (use `nit:` prefix for these)
- Leave review comments and then go silent — follow through

---

## Comment Protocol

| Prefix | Meaning | Blocks Merge? |
|---|---|---|
| _(no prefix)_ | Blocking — must be addressed | Yes |
| `nit:` | Non-blocking style preference | No |
| `q:` | Question — blocking until answered | Yes |
| `suggest:` | Suggestion worth considering | No |
| `praise:` | Positive feedback — no action needed | No |

Authors address every comment before merging. "Addressed" means: fixed, declined with explanation, or deferred with a tracked issue.

---

## PR Size Policy

| Lines Changed | Policy |
|---|---|
| < 200 | Normal — no justification needed |
| 200–500 | Preferred maximum |
| 500–800 | Acceptable with a note in the PR description |
| > 800 | Must justify in PR description why splitting is not feasible. Reviewers may request a split before beginning review. |

Exceptions: auto-generated files, bulk renames, lock file changes, migration files — annotate in PR body.

---

## Review Turnaround SLA

| PR Priority | Review SLA |
|---|---|
| Hotfix / P0 incident | 4 business hours |
| P1 bug fix | 8 business hours |
| Normal feature / fix | 2 business days |
| Chore / dep update | 3 business days |

A reviewer who cannot meet the SLA must communicate and either hand off or give a timeline. Silence past SLA is escalated to the CSA.

---

## Architectural Review

Any PR that touches the following requires explicit CSA review, regardless of the PR author's seniority:

- Database migration files
- Authentication or authorization logic
- Public API endpoints (new or modified)
- `tsconfig.json`, `eslint.config.js`, or any root configuration file
- CI/CD workflow files
- Files in `docs/architecture/`

---

## Prohibited Merge Behaviors

- Merging with failing CI — **never**
- Self-approving a PR (you cannot approve your own PR) — **never**
- Using "approve" to unblock when the reviewer hasn't read the code — **never**
- Force-merging over required approvals — **only Principal Architect, only for P0 production incidents, must be documented**

---

## Rationale

Consistent, rigorous code review is the most reliable mechanism for catching defects, spreading domain knowledge, and enforcing standards without process overhead. The alternative — ad hoc review culture — produces inconsistent outcomes and concentrates knowledge in single individuals, violating the bus factor ≥ 2 requirement.
