<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/versioning-strategy.md -->

# Versioning Strategy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Versioning Scheme

{{SERVICE_NAME}} uses [Semantic Versioning 2.0.0](https://semver.org/): `MAJOR.MINOR.PATCH`

---

## Version Bump Rules

| Scenario | Bump |
|---|---|
| Breaking change to a published API contract | MAJOR |
| Removal of a previously supported behavior | MAJOR |
| New backward-compatible feature | MINOR |
| New endpoint (non-breaking) | MINOR |
| Bug fix | PATCH |
| Performance improvement (no behavior change) | PATCH |
| Dependency update (no behavior change) | PATCH |
| Documentation change | PATCH |
| Hotfix | PATCH |

---

## Breaking Change Definition

A change is **breaking** if any existing consumer must change their integration to continue working correctly. Examples:

- Renaming or removing a field in a response body
- Changing the HTTP method or URL of an endpoint
- Changing the semantics of an existing parameter
- Removing an API endpoint
- Changing authentication or authorization requirements

When in doubt: if a consumer's integration could silently break (wrong data, wrong behavior), treat as breaking.

---

## Pre-1.0.0 Period

While this service is `0.x.y`:
- MINOR bumps may contain breaking changes (public API is not yet stable)
- Clearly document breaking changes in CHANGELOG even during `0.x` phase

---

## API Versioning

[[FILL: If this service exposes a public API, document how API versions are managed. Example: URL path versioning (v1/, v2/), support window for old versions, deprecation notice period. If no external API, remove this section.]]

---

## Artifact Versioning

| Artifact | Versioning | Notes |
|---|---|---|
| Git tag | `vX.Y.Z` | Source of truth |
| `package.json` version | `X.Y.Z` | Must match git tag |
| Docker image tag (if applicable) | `vX.Y.Z` | Never use `latest` in production |
| [[FILL: other artifacts]] | [[FILL]] | |
