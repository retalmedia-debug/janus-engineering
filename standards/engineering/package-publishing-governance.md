# Package Publishing Governance

**Suite Version:** 1.0.0
**Binding Level:** Mandatory-if-applicable
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

Applies to: JANUS services that publish shared packages (tooling configs, shared type libraries, shared utility packages).

---

## Purpose

Shared packages are the mechanism by which common code is made available across the JANUS ecosystem without duplication. They require more discipline than application code because their consumers depend on their stability. A breaking change in a shared package is a deployment event for every consumer.

---

## When to Create a Shared Package

A module becomes a shared package when it has **two or more actual consumers** in the ecosystem. Do not create packages for speculative future consumption.

Questions to answer before creating a package:
1. Are there two real consumers of this code today?
2. Is the interface stable enough to be versioned?
3. Is the package's responsibility narrow and clearly defined?
4. Will the package be maintained actively?

If the answer to any of these is no, the code should remain in its current location.

---

## Package Naming

All JANUS shared packages use the `@janus` npm scope:

```
@janus/eslint-config
@janus/tsconfig
@janus/prettier-config
@janus/commitlint-config
@janus/shared-types         (example for domain types)
@janus/test-utilities       (example for shared test helpers)
```

Package names:
- Lowercase, hyphen-separated
- Descriptive of the package's purpose, not its origin service
- Never include a service name (e.g., not `@janus/atlas-types`) unless the types are genuinely ATLAS-specific

---

## Versioning

Shared packages follow Semantic Versioning independently from the services that consume them.

| Change type | Version bump |
|---|---|
| Bug fix, backward-compatible | PATCH |
| New backward-compatible API addition | MINOR |
| Breaking change (consumers must update their code) | MAJOR |

A MAJOR version bump requires:
1. The breaking change is documented in the CHANGELOG
2. A migration guide is published before the new version is released
3. Consumers are notified at least 30 days before the old MAJOR version is no longer published
4. The old version remains published and receives security patches for 90 days after the new MAJOR is released

---

## Publishing Process

1. Changes are made in a dedicated PR for the package
2. The PR updates the package version in `package.json` and `CHANGELOG.md`
3. The PR is reviewed and merged to `main` (following the service's standard PR process)
4. CI publishes the package automatically on merge to `main` via the `publish-tooling.yml` workflow
5. A git tag is created for the package version: `@janus/package-name@v1.2.3`

Manual publishing from a local machine is prohibited. All publishing occurs through CI.

---

## Deprecation

Before removing a package:
1. Release a version with a deprecation notice in `package.json`:
   ```json
   { "deprecated": "Use @janus/replacement-package instead. See migration guide: [URL]" }
   ```
2. Announce the deprecation to all known consumers
3. Provide a migration guide
4. Allow 90 days minimum before removing the package from the registry
5. The last published version remains available (unpublishing is prohibited except for security incidents)

---

## Package Quality Requirements

Every published `@janus` package must:
- Have TypeScript type declarations (`declaration: true` in tsconfig)
- Have a complete `README.md` with usage examples
- Have a `CHANGELOG.md` following Keep a Changelog format
- Pass all tests in CI before publishing
- Have a `peerDependencies` declaration for any runtime dependency that consumers must install
- Not include `node_modules/` or build artifacts other than the compiled output
