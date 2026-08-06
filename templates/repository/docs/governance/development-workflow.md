<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/development-workflow.md -->

# Development Workflow

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Overview

All development in {{SERVICE_NAME}} follows the JANUS Architectural Order. No phase may begin before its gate is cleared.

**Architectural Order:**
Vision → Governance → Architecture → Documentation → Specification → Database → API → Implementation → Testing → Deployment → Automation → Optimization

---

## Feature Development Lifecycle

### 1. Proposal

- Open a Feature Request issue using the `.github/ISSUE_TEMPLATE/feature-request.md` template
- Assign to CSA for triage and phase assignment within 2 business days

### 2. Design (if architectural impact)

- Assess if an ADR is required (see `docs/architecture/adr/README.md`)
- If ADR required: write and get Accepted before proceeding
- Document any spec changes before any code changes

### 3. Branch

Create a branch from `develop` following the naming convention in `docs/governance/branching-strategy.md`.

### 4. Implementation

- Follow Architectural Order within the feature scope
- Write tests alongside implementation (not after)
- Commit atomically per `docs/governance/commit-convention.md`

### 5. Pull Request

- Self-review against Definition of Done (`docs/governance/definition-of-done.md`)
- Open PR against `develop`
- Resolve all CI failures before requesting review
- See `docs/governance/pull-request-rules.md` for review requirements

### 6. Merge

- Squash merge into `develop`
- Delete feature branch after merge

### 7. Release

- See `docs/governance/release-strategy.md`

---

## Hotfix Workflow

1. Branch from `main`: `hotfix/description`
2. Fix the issue with a test that proves the fix
3. PR targeting `main` directly
4. After merge to `main`: merge `main` back into `develop`
5. Tag the release per `docs/governance/release-strategy.md`

---

## Prohibited Practices

- Direct commits to `main` or `develop`
- Merging a PR with failing CI
- Skipping the Definition of Done checklist
- Writing implementation before design/spec is cleared
- Force-pushing to shared branches (see `docs/governance/branching-strategy.md`)
