# ADR-E002: GitHub Actions as CI/CD Platform

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect
**Services Impacted:** All
**Migration Lead Time Required:** Immediate
**Grace Period:** N/A

---

## Context

All JANUS services require automated CI/CD pipelines for testing, quality gates, deployment, and compliance checking. A consistent CI/CD platform across services enables:
- Shared workflow templates (maintainable from `janus-engineering`)
- Consistent compliance check integration
- Shared CI caching strategies
- A single mental model for engineers working across services

The platform decision also determines tooling compatibility, secrets management, and cost structure.

---

## Options Considered

### Option A: GitHub Actions

CI/CD native to GitHub, where all JANUS repositories are hosted.

**Pros:**
- No additional third-party service required — GitHub is already the code host
- Native integration with PR checks, branch protection, and deployment environments
- Workflow templates can be maintained in `janus-engineering` and consumed via `template/github/workflows/`
- Secrets management via GitHub Secrets (per-repo and organization-level)
- Large ecosystem of pre-built actions with pinnable versions
- Matrix builds for multi-environment testing
- No additional authentication setup for deployment to common platforms

**Cons:**
- GitHub Actions pricing at scale (minutes consumed per run)
- Less flexible than self-hosted for custom runner requirements
- Vendor lock-in to GitHub

### Option B: CircleCI / Travis CI / External Platform

Separate CI platform from the code host.

**Pros:**
- Greater portability if the code host changes
- Some platforms offer faster runner performance at specific price points

**Cons:**
- Additional authentication and secrets synchronization between GitHub and the CI platform
- Workflow configuration does not live alongside the code in a natural way for GitHub PRs
- Cannot be shared as GitHub workflow templates from `janus-engineering`
- Additional service to maintain, monitor, and pay for
- Integration with GitHub branch protection requires webhook configuration per repository

---

## Decision

**GitHub Actions.** All JANUS services use GitHub Actions for CI/CD.

The decisive factors:
1. All JANUS repositories are hosted on GitHub. Using GitHub Actions eliminates a cross-service authentication layer.
2. Workflow templates can be maintained in `janus-engineering/templates/github/workflows/` and consumed by all service repositories — enabling centrally-maintained CI consistency.
3. The compliance check (`scripts/validate-compliance.sh`) integrates naturally as a GitHub Actions step.
4. Secrets management via GitHub Secrets integrates with branch protection and deployment environments without additional tooling.

The vendor lock-in risk is accepted. Migrating CI/CD platforms is a bounded engineering problem. The consistency benefit across the ecosystem is immediate and ongoing.

---

## Consequences

**Positive:**
- Single CI/CD mental model across all JANUS services
- Compliance check workflow maintained centrally and distributed via templates
- GitHub PR checks and branch protection are natively integrated
- No additional authentication setup for GitHub-integrated deployment targets

**Negative / Trade-offs:**
- GitHub Actions billing at scale — costs are monitored per service
- Workflow template updates in `janus-engineering` must be manually applied to consuming service repositories (not auto-applied)

**Risks:**
- GitHub service incidents affect all JANUS services simultaneously — mitigated by deployment pipeline architecture that can be triggered manually if needed

**Configuration standard:**
- All GitHub Actions steps pin to exact versions with SHA hashes, not floating tags: `uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683`
- Floating tags (`@v4`, `@main`) are prohibited — they are an untrusted dependency

**Migration path:**
All new JANUS services bootstrap from `templates/github/workflows/ci-base.yml`. Existing services adopt this template during their compliance review.
