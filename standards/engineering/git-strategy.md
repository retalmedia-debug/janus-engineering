# Git Strategy

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Version control is not a backup system. It is the historical record of every decision made in a service's codebase — what was built, when, why, and by whom. A well-maintained git history is the engineering team's primary communication tool with their future selves.

This standard defines how all JANUS services use git.

---

## History Philosophy

**Honesty:** Commits tell the truth about what changed and why. Work-in-progress commits do not appear in shared branch history.

**Atomicity:** Each commit addresses one logical concern. A commit that fixes a bug, adds a feature, and refactors an unrelated module is three commits combined by accident.

**Legibility:** Commit messages are written for the engineer investigating a regression at 3 AM, not for the author who remembers the context.

**Immutability:** Once a commit is on a shared branch (`main`, `develop`, `release/*`), it is part of the permanent record. Its history is not rewritten.

---

## Branching Model

All JANUS services use a Modified GitFlow model instantiated in their service-level governance documents.

The canonical structure:
- `main` — production state. Tagged on every release.
- `develop` — integration branch. All feature work merges here.
- `feature/<TICKET>-<desc>` — branched from `develop`, merged to `develop`
- `fix/<TICKET>-<desc>` — branched from `develop`, merged to `develop`
- `chore/<TICKET>-<desc>` — branched from `develop`, merged to `develop`
- `docs/<TICKET>-<desc>` — branched from `develop`, merged to `develop`
- `release/<version>` — branched from `develop`, merged to `main` + `develop`
- `hotfix/<TICKET>-<desc>` — branched from `main`, merged to `main` + `develop`

The specific branch protection rules, reviewer counts, and merge strategies are instantiated per service in their governance documents. This standard defines the model; services define their application of the model.

---

## Commit Convention

All JANUS services use Conventional Commits 1.0.0.

Format: `<type>(<scope>): <description>`

Header maximum length: 100 characters.

**Types:**

| Type | When to use |
|---|---|
| `feat` | A new feature visible to users or consumers |
| `fix` | A bug fix |
| `docs` | Documentation changes only |
| `style` | Formatting changes with no behavior change |
| `refactor` | Code restructuring with no behavior change |
| `perf` | Performance improvements |
| `test` | Adding or fixing tests |
| `build` | Build system or tooling changes |
| `ci` | CI/CD configuration changes |
| `chore` | Maintenance tasks not fitting other types |
| `revert` | Reverting a previous commit |
| `security` | Security-related changes |
| `migration` | Database migration files |

**Breaking changes:**
- Append `!` after the type: `feat!: remove deprecated endpoint`
- Add `BREAKING CHANGE:` footer with migration instructions

**Scopes:** Each service defines its own scopes in its commit convention document. Scopes reflect the service's technical layers, not feature names.

**Body:** Optional. Use to explain *why*, not *what*. The diff shows what; the body explains the intent, the constraint, or the trade-off.

**Footer:** Used for breaking changes, issue references (`Fixes #123`), and co-authors.

---

## Atomic Commit Rules

A commit is atomic when:
- It can be reverted without side effects on other features
- The codebase compiles and tests pass after it is applied in isolation (or it is a WIP only on a personal branch)
- Its subject line completely describes the change

WIP commits are permitted only on personal/feature branches and must be squashed or amended before a PR is opened.

---

## Rebase Rules

| Scenario | Permitted? |
|---|---|
| Rebasing a personal feature branch onto `develop` | Yes — preferred over merge commits for personal branches |
| Rebasing a shared feature branch (multiple authors) | No — use merge, coordinate with co-authors |
| Rebasing `develop`, `main`, or `release/*` | Never |
| Interactive rebase on a personal branch before opening PR | Yes — expected practice for cleaning commit history |
| Interactive rebase on a branch with an open PR | No — force-pushing to an open PR branch without team communication disrupts review |

---

## Force Push Rules

`git push --force-with-lease` is preferred over `git push --force`.

| Scenario | Permitted? |
|---|---|
| Force-pushing a personal branch that no one else has checked out | Yes |
| Force-pushing to `main` | Never — under any circumstances |
| Force-pushing to `develop` | Never |
| Force-pushing to a `release/*` branch | Never |
| Force-pushing to a shared `feature/*` branch | Only with explicit coordination with all contributors |

---

## Merge Strategies

| Merge scenario | Strategy |
|---|---|
| `feature/*` → `develop` | Squash merge. The feature's atomic commits are preserved in the branch history; the merge to develop is one well-named commit. |
| `fix/*` → `develop` | Squash merge |
| `release/*` → `main` | Merge commit (no squash). Preserves release history. |
| `release/*` → `develop` | Merge commit |
| `hotfix/*` → `main` | Merge commit |
| `hotfix/*` → `develop` | Merge commit |

---

## Tagging Rules

- Tags are applied only to `main`
- All tags are annotated: `git tag -a v1.2.0 -m "Release v1.2.0"`
- Tag format: `v<MAJOR>.<MINOR>.<PATCH>` (SemVer with `v` prefix)
- Tags are never deleted or moved after creation
- Each tag's annotation includes the release summary or a reference to the CHANGELOG entry

---

## `.gitignore` Policy

Every JANUS service repository must include a `.gitignore` that excludes:
- `.env`, `.env.local`, `.env.development`, `.env.staging`, `.env.production` — all environment files
- `node_modules/`, `.npm/`, `.pnpm/` — package manager artifacts
- `dist/`, `build/`, `.next/`, `.nuxt/` — build outputs
- `.DS_Store`, `Thumbs.db` — OS artifacts
- IDE and editor configuration directories (`.vscode/`, `.idea/`)
- Runtime artifacts (`.cache/`, `*.log`, `*.tmp`)

The canonical template `.gitignore` is in `templates/repository/.gitignore`.

---

## Large File Policy

Files larger than 5 MB must not be committed to any JANUS repository without an explicit decision documented in an ADR. Alternatives:

- Store assets in S3-compatible storage and reference by URL
- Use Git LFS if binary tracking is genuinely required (requires explicit team agreement)
- Restructure to avoid the need for large files in the repository

Binary files that do not compress well (images, compiled artifacts, database dumps) are never committed regardless of size unless explicitly decided by ADR.

---

## Secrets Policy

Secrets, credentials, API keys, JWTs, certificates, or any form of authentication material must never appear in a git commit — not in `.gitignore`d files (they may become unignored), not in comments, not in test fixtures.

If a secret is committed by accident:
1. Rotate the secret immediately — assume it is compromised
2. Remove it from the commit history using `git filter-repo` or `BFG Repo-Cleaner`
3. Force-push the rewritten history (one of the few permitted uses of force-push to shared branches, authorized by CSA)
4. Audit all consumers that used the compromised secret
5. Conduct a post-mortem within 48 hours

The history rewrite does not mitigate the exposure — the secret was visible to anyone with access to the repository during the window it was present. Rotation is the only mitigation.
