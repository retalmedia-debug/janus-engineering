# How to Publish @janus Tooling Packages

**Owner:** Principal Architect / janus-engineering maintainer
**Last Updated:** 2026-08-06

This guide covers the complete process for releasing a new version of any `@janus/*` tooling package to GitHub Packages.

---

## Prerequisites

- You have write access to the `janus-engineering` repository
- The change has been merged to `main`
- A JAC review has been completed if the change is breaking (see below)

---

## When to Publish

| Change Type | SemVer Bump | JAC Required? |
|---|---|---|
| Bug fix (rule severity fix, typo) | PATCH | No |
| New rule (non-breaking, warn level) | MINOR | No |
| New rule (error level, or any breaking change) | MAJOR | Yes — must produce service grace period |
| Configuration freeze removal or loosening | MAJOR | Yes |

**Grace periods after publish:**

| Version | Grace Period | What services must do |
|---|---|---|
| PATCH | 0 days | Update within next sprint |
| MINOR | 60 days | Update before grace period expires |
| MAJOR | 90 days | Coordinate with JAC; services may require waivers |

See `standards/engineering/dependency-governance.md` for the full grace period policy.

---

## Step 1 — Make the Change

All four packages are in `tooling/` within this repository:

```
tooling/
  eslint-config-janus/
  tsconfig-janus/
  prettier-config-janus/
  commitlint-config-janus/
```

Make your change in the relevant package directory. Open a PR to `main` as normal.

---

## Step 2 — Update Version and CHANGELOG

All packages are versioned and published together under a unified `tooling/vX.Y.Z` tag. You must update **all four packages** in the same release, even if only one changed. This prevents version skew across the tooling suite.

In each `tooling/*/package.json`, bump `"version"` to the new version:

```json
{
  "version": "1.1.0"
}
```

In each `tooling/*/CHANGELOG.md`, move the relevant changes from `[Unreleased]` to a new version section:

```markdown
## [1.1.0] — YYYY-MM-DD

### Changed
- Description of what changed and why
```

Packages with no changes in this release still receive a `CHANGELOG.md` entry noting "No changes in this release."

Commit these updates and merge to `main` before tagging.

---

## Step 3 — Tag the Release

Once the version bumps are merged to `main`, create and push the release tag:

```bash
git checkout main
git pull
git tag tooling/v1.1.0
git push origin tooling/v1.1.0
```

The tag format is exactly `tooling/v{semver}` (e.g., `tooling/v1.1.0`). Do not create package-specific tags.

---

## Step 4 — Monitor the Workflow

The GitHub Actions workflow `.github/workflows/publish-tooling.yml` triggers automatically on the tag push.

Go to **Actions → Publish @janus Tooling Packages** to monitor the run. The workflow:

1. **Validates** all four `package.json` files exist
2. **Verifies** all four packages have `"version"` matching the tag
3. **Verifies** all four `CHANGELOG.md` files have an entry for the version
4. **Publishes** all four packages in parallel to GitHub Packages (`npm.pkg.github.com`)

If validation fails, the workflow exits before publishing. Fix the issue, delete the tag, and re-tag:

```bash
git tag -d tooling/v1.1.0
git push origin --delete tooling/v1.1.0
# fix the issue, then:
git tag tooling/v1.1.0
git push origin tooling/v1.1.0
```

---

## Step 5 — Notify Services

After a successful publish:

1. Update `docs/WORKLOG.md` with the release entry
2. For MINOR/MAJOR: Open a GitHub Discussion or issue in each affected service repository noting the new version and the grace period deadline
3. For MAJOR: Create a `CHANGELOG.md` entry in `janus-engineering` main `CHANGELOG.md` and open a JAC decision record in `docs/governance/jac-decisions.md`

---

## Dry Run (Testing)

To validate the publish workflow without actually publishing:

1. Go to **Actions → Publish @janus Tooling Packages**
2. Click **Run workflow**
3. Set `dry_run` to `true`
4. Click **Run workflow**

The workflow will run all validation steps and `npm pack --dry-run` for each package without publishing.

---

## Package Registry

All `@janus/*` packages are published to the GitHub Packages npm registry:

```
https://npm.pkg.github.com
```

Services consuming these packages must configure `.npmrc` with:

```
@janus:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```

---

## Troubleshooting

**Workflow fails with "version mismatch"**
All four `package.json` files must have the same version as the tag. Check and align all four.

**Workflow fails with "CHANGELOG.md missing"**
Each package directory must have a `CHANGELOG.md`. Create it using the existing format.

**npm publish fails with 403**
The workflow uses `GITHUB_TOKEN` which has `packages: write` permission. If publishing fails, verify the token scope in the workflow `permissions` block.

**Package not visible to services after publish**
GitHub Packages can take a few minutes to propagate. If it persists, verify the package name matches `@janus/<package-name>` and the registry URL is `https://npm.pkg.github.com`.
