<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/release-strategy.md -->

# Release Strategy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Release Types

| Type | Version Bump | When |
|---|---|---|
| Major | `X.0.0` | Breaking API change or major behavioral change |
| Minor | `x.Y.0` | New backward-compatible feature |
| Patch | `x.y.Z` | Bug fix, dependency update, documentation |
| Hotfix | `x.y.Z` | Critical production fix, bypasses develop |

---

## Release Process

### Standard Release

1. Create `release/vX.Y.Z` from `develop`
2. Bump version in `package.json`
3. Update `CHANGELOG.md` — move `[Unreleased]` to `[X.Y.Z] - YYYY-MM-DD`
4. Open PR targeting `main` — 2 required approvals
5. Merge with **merge commit** (not squash)
6. Tag: `git tag -a vX.Y.Z -m "Release vX.Y.Z"`
7. Push tag: `git push origin vX.Y.Z`
8. Merge `main` back into `develop`
9. CI deploys tagged release to production

### Hotfix Release

1. Create `hotfix/description` from `main`
2. Implement fix with test
3. Open PR targeting `main` — 2 required approvals
4. Merge and tag as patch release
5. Merge `main` back into `develop`

---

## Versioning Rules

See `docs/governance/versioning-strategy.md` for full SemVer rules and what constitutes a breaking change.

---

## Rollback Procedure

If a release causes a production incident:

1. Identify the last known-good tag
2. Deploy the previous tag immediately — do not wait for a fix
3. Open a P1 bug issue with `[REGRESSION vX.Y.Z]` in the title
4. Fix on a hotfix branch targeting the known-good state
5. Document the incident in the CHANGELOG under the bad release version

---

## Deployment

[[FILL: Describe your deployment mechanism. Examples: GitHub Actions CD workflow, manual deploy script, Supabase deploy. Reference the relevant workflow file in .github/workflows/.]]

---

## Release Calendar

[[FILL: If the service has a regular release cadence (e.g., weekly), document it here. If releases are continuous or event-driven, document the trigger instead. If none, remove this section.]]
