# ADR-E003: pnpm as Package Manager

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect
**Services Impacted:** All TypeScript/Node.js services
**Migration Lead Time Required:** Immediate
**Grace Period:** N/A

---

## Context

All JANUS services with TypeScript or Node.js components require a package manager. Using different package managers across services creates friction when engineers move between repositories and prevents shared CI caching strategies. A single standard enables consistent lockfile format, consistent workspace patterns, and shared tooling scripts.

---

## Options Considered

### Option A: npm

Node.js's built-in package manager.

**Pros:**
- Zero additional tooling — ships with Node.js
- Universal familiarity
- Well-documented

**Cons:**
- Flat `node_modules` allows access to undeclared transitive dependencies (phantom dependencies)
- Slower than pnpm in CI environments without caching
- `package-lock.json` is large and produces noisy diffs
- Workspace support (npm workspaces) is functional but less ergonomic than pnpm

### Option B: pnpm

Fast, disk-efficient package manager with strict dependency resolution.

**Pros:**
- Content-addressable store eliminates duplicate package storage across projects on the same machine
- Strict `node_modules` by default — prevents access to undeclared transitive dependencies
- `pnpm-lock.yaml` produces cleaner diffs than `package-lock.json`
- First-class workspace support with `workspace:` protocol
- Significantly faster than npm in CI with cache configured correctly
- `--frozen-lockfile` flag enforces lockfile currency in CI

**Cons:**
- Not built into Node.js — requires installation
- Less universally familiar than npm
- Some packages have undeclared peer dependencies that strict pnpm resolution surfaces (usually correct behavior — the package is broken)

### Option C: Yarn (Berry)

**Pros:**
- PnP (Plug'n'Play) mode eliminates `node_modules` entirely
- Strong TypeScript support

**Cons:**
- PnP mode has compatibility issues with some tools
- `yarn.lock` format diverges significantly from npm; engineers familiar with npm face a steeper adjustment
- Two major Yarn versions (classic vs. berry) create ecosystem confusion

---

## Decision

**pnpm.** All JANUS Node.js services use pnpm.

The decisive factors:
1. Strict dependency resolution prevents phantom dependencies — a class of bugs where code works locally because a transitive dependency happens to be installed but fails in CI or in other environments where the dependency tree differs.
2. `--frozen-lockfile` in CI is the strongest guarantee that installed dependencies match declared dependencies. npm's equivalent is weaker.
3. Content-addressable store is a meaningful disk efficiency benefit for engineers working across multiple JANUS services simultaneously.
4. Workspace support is first-class — relevant for services with monorepo-style internal package organization.

The not-built-into-Node.js friction is resolved by the `packageManager` field in `package.json` (Corepack support) and by CI workflow templates that install pnpm before any other step.

---

## Consequences

**Positive:**
- Consistent `pnpm-lock.yaml` format across all JANUS services
- Phantom dependency bugs are caught early rather than silently
- Shared CI caching strategy works across services
- Workspace-based internal package organization is available to all services

**Negative / Trade-offs:**
- Engineers new to pnpm need to learn `pnpm add`, `pnpm install`, `pnpm run` instead of `npm` equivalents — minor friction
- Some CI environments need explicit pnpm installation step

**Risks:**
- A package with undeclared peer dependencies may produce pnpm installation errors that npm would not catch — this is correct behavior and requires fixing the package or hoisting the dependency explicitly

**Migration path:**
ATLAS and all future services bootstrap with pnpm. The presence of `package-lock.json` or `yarn.lock` in any JANUS service is a compliance violation. See `standards/engineering/package-manager-standard.md`.
