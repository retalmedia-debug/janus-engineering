<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/branching-strategy.md -->

# Branching Strategy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

Ecosystem standard: `standards/engineering/git-strategy.md` in `janus-engineering`

---

## Protected Branches

| Branch | Protection | Who Can Merge |
|---|---|---|
| `main` | Requires PR, 2 approvals, passing CI, no force push | CSA + Principal Architect |
| `develop` | Requires PR, 1 approval, passing CI | CSA or designated lead |

---

## Branch Types

| Type | Pattern | Source | Target | Merge Strategy |
|---|---|---|---|---|
| Feature | `feat/short-description` | `develop` | `develop` | Squash merge |
| Bug fix | `fix/short-description` | `develop` | `develop` | Squash merge |
| Hotfix | `hotfix/short-description` | `main` | `main`, then `develop` | Squash merge |
| Release | `release/vX.Y.Z` | `develop` | `main` | Merge commit (no squash) |
| Chore | `chore/short-description` | `develop` | `develop` | Squash merge |

---

## Branch Naming Rules

- All lowercase
- Hyphens as separators (no underscores, no spaces)
- Max 50 characters after the prefix
- Reference issue number when applicable: `feat/user-auth-#42`

---

## Force Push Policy

| Branch | Force Push | Exceptions |
|---|---|---|
| `main` | Never | None |
| `develop` | Never | None |
| Feature/fix/chore branches | Allowed (own branch only) | Must not rewrite shared history |

---

## Stale Branch Policy

Branches with no commits for 30 days are candidates for deletion. The CSA reviews and prunes stale branches as part of the monthly health review.

---

## Service-Specific Considerations

[[FILL: Any service-specific branching rules. Examples: environment branches (staging, preview), branches for external contributors, etc. If none, remove this section.]]
