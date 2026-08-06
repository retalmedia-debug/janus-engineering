# Package Manager Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06
**Ecosystem ADR:** [ADR-E003](../../adr/ecosystem/ADR-E003-package-manager.md)

---

## Decision

All JANUS services that use a Node.js package manager use **pnpm**.

---

## Required Configuration

**`package.json` — engine field:**
```json
{
  "engines": {
    "node": ">=20.0.0",
    "pnpm": ">=9.0.0"
  },
  "packageManager": "pnpm@9.x.x"
}
```

The `packageManager` field is set to the exact pnpm version in use. This enforces consistency across the team and in CI.

**`.npmrc`:**
```ini
engine-strict=true
auto-install-peers=true
strict-peer-dependencies=false
```

**Lockfile:** `pnpm-lock.yaml` is committed to version control and must be up to date in every PR.

---

## Prohibited Alternatives

- `npm` — not used in any JANUS service
- `yarn` (classic or berry) — not used in any JANUS service

The presence of `package-lock.json` or `yarn.lock` in a JANUS service repository is a compliance violation. These files indicate the wrong package manager was used.

---

## CI Configuration

CI pipelines use `pnpm` exclusively:

```yaml
- uses: pnpm/action-setup@v4
  with:
    version: 9
- uses: actions/setup-node@v4
  with:
    node-version: '20'
    cache: 'pnpm'
- run: pnpm install --frozen-lockfile
```

The `--frozen-lockfile` flag ensures CI fails if the lockfile is out of sync with `package.json`. This is not optional.

---

## Workspace Configuration

For services with multiple packages (monorepo structure within a service), pnpm workspaces are used:

```yaml
# pnpm-workspace.yaml
packages:
  - 'apps/*'
  - 'packages/*'
```

Workspace packages are referenced using the `workspace:` protocol:
```json
{
  "dependencies": {
    "@service/shared-types": "workspace:*"
  }
}
```

---

## Why pnpm

The rationale is documented in full in `ADR-E003`. The short version:

- **Disk efficiency** — Content-addressable store prevents duplicate package storage across projects
- **Strict node_modules** — pnpm creates a non-flat node_modules that prevents access to undeclared dependencies
- **Lockfile consistency** — `pnpm-lock.yaml` is deterministic across platforms
- **Workspace support** — First-class support for multi-package repositories
- **Speed** — Significantly faster than npm for CI environments with caching configured

Ecosystem consistency — all JANUS services using the same package manager — enables shared CI caching configuration, shared tooling scripts, and a single mental model for all engineers.
