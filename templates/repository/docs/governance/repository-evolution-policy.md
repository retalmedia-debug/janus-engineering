<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/repository-evolution-policy.md -->

# Repository Evolution Policy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Purpose

This policy governs how the `{{SERVICE_REPO}}` repository structure, tooling, and conventions change over time. Repository structure is architecture — changes follow the same governance as code changes.

---

## What Requires a PR + CSA Approval

Any of the following changes require a dedicated PR with the CSA as required reviewer:

- Adding a new top-level directory
- Removing an existing directory
- Renaming a directory that is referenced in documentation or other scripts
- Changing the `tsconfig` base or extends chain
- Changing the ESLint flat config rules (not just overrides)
- Changing the Prettier config
- Changing the CI workflow structure
- Upgrading a major dependency (`MAJOR` version bump)
- Adding a new dependency that introduces a runtime behavior

---

## What Requires an ADR

The following changes require an accepted ADR before implementation:

- Changing the primary programming language or runtime
- Introducing a new persistence layer (new database, new cache)
- Changing the API framework or transport protocol
- Significant restructuring of the source code architecture
- Adopting a new testing tool that changes coverage collection

---

## Directory Evolution Rules

- New source directories must be documented in `docs/architecture/folder-strategy.md`
- Empty directories must contain a `.gitkeep` file until they have contents
- `docs/` structure mirrors the JANUS standard documentation hierarchy. Additions that don't map to an existing section require CSA approval and documentation in `docs/INDEX.md`

---

## Tooling Upgrade Policy

| Tool | Upgrade Frequency | Process |
|---|---|---|
| `@janus/*` packages | Follow suite version bump notification | Chore PR |
| Node.js | LTS versions only | ADR if major version |
| ESLint / Prettier | Track `@janus/eslint-config` and `@janus/prettier-config` | Chore PR |
| Test runner | [[FILL: vitest / jest / etc.]] | ADR if changing tool |

---

## JANUS Suite Version Upgrades

When a new janus-engineering suite version is released:

1. CSA reviews the CHANGELOG for breaking changes and grace periods
2. Open a `chore: upgrade JANUS suite to vX.Y.Z` PR
3. Update `janus-suite-version` in `.janus-compliance.yaml`
4. Update all template metadata comments in copied template files
5. Apply any standard changes required by the new version
6. CI compliance check must pass before merge
