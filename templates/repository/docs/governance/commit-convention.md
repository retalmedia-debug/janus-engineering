<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/commit-convention.md -->

# Commit Convention

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

Ecosystem standard: `standards/engineering/git-strategy.md` in `janus-engineering`
Commitlint config: `@janus/commitlint-config`

---

## Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Rules:**
- Header max 100 characters
- Subject: lowercase, no period at end, imperative mood
- Body: explain the *why*, not the *what*
- Footer: reference issues (`Closes #42`), breaking changes (`BREAKING CHANGE: ...`)

---

## Types

| Type | When to Use |
|---|---|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no logic change |
| `refactor` | Code restructure, no behavior change |
| `perf` | Performance improvement |
| `test` | Tests only |
| `chore` | Tooling, deps, build config |
| `ci` | CI/CD workflow changes |
| `revert` | Revert a previous commit |
| `security` | Security fix or hardening |
| `migration` | Database migration |
| `deps` | Dependency update |

---

## Scopes for {{SERVICE_NAME}}

[[FILL: Define the scopes for this service. Scopes are the subsystems or layers within the service. Examples below — replace with your actual scopes.]]

| Scope | Description |
|---|---|
| `api` | API layer changes |
| `db` | Database / migration changes |
| `auth` | Authentication and authorization |
| `[[FILL]]` | [[FILL: describe]] |
| `deps` | Dependency changes |
| `ci` | CI/CD changes |
| `config` | Configuration changes |

---

## Examples

```
feat(api): add pagination to list-events endpoint

fix(auth): correct token expiry validation for refresh flow

chore(deps): update @janus/eslint-config to 1.2.0

migration(db): add index on events.created_at
Closes #88
```

---

## Enforcement

Commitlint runs in CI and as a commit-msg hook via `@janus/commitlint-config`. Non-conforming commits will fail CI.
