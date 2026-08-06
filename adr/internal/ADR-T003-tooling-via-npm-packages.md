# ADR-T003: Tooling Configurations as npm Packages

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect

---

## Context

Shared tooling configurations — ESLint rules, TypeScript compiler options, Prettier settings, commitlint rules — must be maintained consistently across all JANUS services. The question is how to distribute them.

---

## Options Considered

### Option A: Copy into Each Service Repository

Tooling configurations are copied from a reference location into each service at creation time (same model as document templates).

**Pros:**
- No external dependency at runtime
- Services are fully self-contained

**Cons:**
- Tooling configuration drift across services — each service accumulates local modifications
- Security patches to linting rules or TypeScript options must be applied to each service individually
- No version tracking — a service doesn't know which version of the ESLint config it is using
- Reviewing a tooling change requires touching every service repository

### Option B: Published npm Packages under `@janus` Scope

Tooling configurations are published as versioned npm packages. Services add them as `devDependencies`.

**Pros:**
- Version-tracked — `package.json` shows exactly which version of each config a service uses
- Updates are applied by bumping the version in `package.json` — one PR per service
- Security patches to configs produce a new package version that services adopt on their upgrade schedule
- A MINOR or PATCH tooling update can be flagged as "safe to auto-merge if CI passes" via Dependabot/Renovate rules
- Services on different versions can coexist during gradual rollout

**Cons:**
- Requires a package registry (GitHub Packages or npm registry)
- An internet-connected install step is required in CI
- Publishing workflow must be maintained in `janus-engineering`

---

## Decision

**Published npm packages under `@janus` scope.** Tooling configurations are published as `@janus/eslint-config`, `@janus/tsconfig`, `@janus/prettier-config`, `@janus/commitlint-config`.

Version tracking is the decisive factor. When a service's `package.json` shows `"@janus/eslint-config": "1.2.0"`, both the service team and any compliance check know exactly what linting rules apply. When a version is bumped, the diff is visible in the PR. This traceability cannot be achieved with copied configuration files.

The publishing overhead (a GitHub Actions workflow and a package registry) is a one-time setup cost that pays dividends for the lifetime of the ecosystem.

---

## Consequences

**Positive:**
- Services know exactly which version of each tooling configuration they use
- Tooling updates are applied service-by-service via standard `pnpm update` workflow
- Dependabot/Renovate can flag tooling update PRs for review
- A single change to `@janus/eslint-config` propagates to all services as they upgrade

**Negative / Trade-offs:**
- Requires a package registry (GitHub Packages, scoped to the `@janus` organization)
- Publishing workflow must be kept operational
- Services must explicitly upgrade — tooling does not auto-update

**Registry:**
All `@janus` packages are published to GitHub Packages (private registry, accessible to all JANUS repositories within the GitHub organization). This requires CI authentication configuration for `pnpm install` in service repositories.

**Publishing trigger:**
Packages are published automatically by CI on merge to `main` in `janus-engineering` when the package version in `package.json` has been incremented.
