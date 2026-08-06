# Changelog

All notable changes to the janus-engineering standards suite are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This repository uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html) for the suite as a whole.

---

## [Unreleased]

### Added — PKG-004 Gap Resolution (2026-08-06)

**Standards**
- `standards/operations/observability-standard.md` — Three-pillar observability (logs/metrics/traces), 6 mandatory metrics with labels, X-Request-ID propagation contract, health endpoint format, pre-production gate checklist

**Architecture Decision Records**
- `adr/ecosystem/ADR-E008-supabase-as-database-platform.md` — Formalizes Supabase as ecosystem default database platform (services may deviate with JAC approval)

**Templates — Scaffold Gaps Resolved**
- `templates/repository/docs/api/event-catalog.md` — Event catalog for async events (required by event-schema-standard, missing from scaffold)
- `templates/repository/package.json` — Service package.json stub with @janus dev dependencies and standard scripts
- `templates/repository/.nvmrc` — Node.js 20 LTS version pin
- `templates/repository/docs/INDEX.md` — Complete documentation index template (all 13 governance + all architecture, engineering, testing, security, operations, database, api, ai-collaboration sections)
- `templates/repository/.github/ISSUE_TEMPLATE/integration-request.md` — Service-level integration request redirect to janus-engineering

**Tooling READMEs**
- `tooling/eslint-config-janus/README.md` — @janus/eslint-config installation, usage, non-overridable rules
- `tooling/tsconfig-janus/README.md` — @janus/tsconfig base.json and strict.json usage, what cannot be disabled
- `tooling/prettier-config-janus/README.md` — @janus/prettier-config usage (package.json reference only), frozen configuration
- `tooling/commitlint-config-janus/README.md` — @janus/commitlint-config usage, 13 JANUS commit types

**Index Updates**
- `standards/INDEX.md` — Updated to 34 standards (was 33); observability-standard added
- `templates/INDEX.md` — New scaffold files listed: event-catalog.md, package.json, .nvmrc, docs/INDEX.md, integration-request.md

### Added — Phase 2 (2026-08-06)

**Ecosystem Governance**
- `docs/governance/ecosystem-service-roadmap.md` — Canonical 10-service implementation sequence (mandatory governance artifact)
- `docs/governance/cross-service-integration-governance.md` — Inter-service integration approval, contract, and versioning governance
- `docs/governance/incident-management-policy.md` — Ecosystem-wide incident declaration, severity, communication, post-mortem policy
- `docs/governance/jac-operating-procedures.md` — JAC meeting cadence, quorum, voting protocol, RFC disposition process
- `docs/governance/service-deprecation-playbook.md` — Phased service retirement: deprecation notice, migration, data disposition
- `docs/governance/jac-decisions.md` — Running log of all JAC decisions (founding entries added)

**Standards**
- `standards/engineering/code-review-standard.md` — Review requirements, author/reviewer responsibilities, PR size policy, turnaround SLAs
- `standards/engineering/sprint-governance.md` — Sprint structure, capacity allocation (20% debt floor), ceremony requirements, debt sprint trigger
- `standards/api/event-schema-standard.md` — CloudEvents v1.0 envelope, event type naming convention, schema documentation requirements
- `standards/operations/alerting-standard.md` — 7 mandatory production alerts, severity definitions, runbook requirements, pre-production gate
- `standards/operations/runbook-standard.md` — Alert runbook format, quality requirements, freshness policy, audit cadence
- `standards/security/secret-management-standard.md` — 7 absolute rules, storage requirements, rotation policy, breach response
- `standards/architecture/service-sizing-guidance.md` — 5 criteria for new service creation, anti-patterns, decision process

**Guides**
- `docs/guides/how-to-scaffold-a-service.md` — scaffold-service.sh usage, fill-in priority order, initial commit, registry update

**Templates**
- `templates/documents/rfc/RFC-TEMPLATE.md` — Full RFC document template with JAC disposition section
- `templates/documents/post-mortem/POST-MORTEM-TEMPLATE.md` — Blameless post-mortem with timeline, root cause, and action items
- `templates/documents/incident-report/INCIDENT-REPORT-TEMPLATE.md` — Live incident tracking issue template

**Platform Tracking**
- `docs/WORKLOG.md` — Architect worklog with current package, risks, and architectural decisions
- `docs/ROADMAP.md` — Engineering package roadmap with status, dependencies, and complexity estimates

**GitHub**
- `.github/ISSUE_TEMPLATE/integration-request.md` — Cross-service integration request template (Gate 1 of integration governance)

**Service Registry**
- `services/registry.yaml` — Expanded to 10 services: APOLLO (4), HERMES (5), CRAT (7) added; all services assigned `implementation_sequence` field

**Index Updates**
- `standards/INDEX.md` — Updated: 33 standards total (was 26)
- `templates/INDEX.md` — Updated: RFC, post-mortem, incident report templates added
- `docs/INDEX.md` — Updated: 11 governance docs, 6 guides, 2 platform tracking documents

---

## [1.0.0] — 2026-08-06

### Added

**Standards**
- `standards/engineering/git-strategy.md` — Version control philosophy, rebase rules, force-push policy, tagging rules
- `standards/engineering/refactoring-policy.md` — Refactoring definition, types, approval requirements
- `standards/engineering/long-term-maintenance.md` — Maintenance cadences, dead code policy, knowledge preservation
- `standards/engineering/dependency-governance.md` — Risk classification, evaluation, license policy, vulnerability response
- `standards/engineering/technical-debt-policy.md` — Debt classes, register, 20% rule, debt sprint trigger
- `standards/engineering/feature-flag-lifecycle.md` — Flag creation, activation, documentation, retirement
- `standards/engineering/package-publishing-governance.md` — Publishing standards, versioning, deprecation
- `standards/engineering/package-manager-standard.md` — pnpm as the JANUS standard package manager
- `standards/engineering/linting-standard.md` — ESLint base config, required plugins, configuration rules
- `standards/engineering/formatter-standard.md` — Prettier as the JANUS formatter, frozen configuration
- `standards/engineering/typescript-baseline.md` — TypeScript compiler options, strict mode requirements
- `standards/architecture/engineering-principles.md` — 11 universal engineering principles
- `standards/architecture/architectural-order.md` — Non-negotiable sequencing: Vision → Optimization
- `standards/architecture/adr-format.md` — ADR format, lifecycle, submission process
- `standards/documentation/documentation-strategy.md` — What to document, where, why
- `standards/documentation/documentation-lifecycle.md` — Document states, lifecycle, versioning
- `standards/testing/testing-philosophy.md` — Pyramid ratios, determinism, speed, honest failure
- `standards/security/security-baseline.md` — Universal security categories and minimum requirements
- `standards/security/containerization-standard.md` — Base image, non-root user, scanning requirements
- `standards/operations/logging-standard.md` — Structured JSON format, required fields, log levels
- `standards/operations/error-handling-standard.md` — Error taxonomy, response envelope format
- `standards/database/supabase-migration-governance.md` — Migration immutability, safety rules, review process
- `standards/api/api-design-standard.md` — URL patterns, HTTP semantics, response format, versioning
- `standards/ai-collaboration/ai-collaboration-rules.md` — AI as assistant, approved tools, universal rules
- `standards/ai-collaboration/chatgpt-responsibilities.md` — External AI tool governance
- `standards/ai-collaboration/human-responsibilities.md` — Non-delegable human responsibilities

**Architecture Decision Records**
- `adr/ecosystem/ADR-E001-polyrepo-strategy.md` — All JANUS systems are independent repositories
- `adr/ecosystem/ADR-E002-cicd-platform.md` — GitHub Actions as the standard CI/CD platform
- `adr/ecosystem/ADR-E003-package-manager.md` — pnpm as the standard package manager
- `adr/ecosystem/ADR-E004-typescript-primary-language.md` — TypeScript as primary language for web/API surfaces
- `adr/ecosystem/ADR-E005-api-response-envelope.md` — Unified response envelope across all JANUS APIs
- `adr/ecosystem/ADR-E006-logging-format.md` — Structured JSON logging as the ecosystem standard
- `adr/internal/ADR-T001-standards-suite-versioning.md` — Suite versioned as a whole via git tags
- `adr/internal/ADR-T002-template-copy-not-link.md` — Templates copied at creation, not linked
- `adr/internal/ADR-T003-tooling-via-npm-packages.md` — Tooling configs published as @janus npm packages

**Templates** — Full repository scaffold for new JANUS services

**Tooling** — @janus/eslint-config, @janus/tsconfig, @janus/prettier-config, @janus/commitlint-config

**Governance Documentation**
- RFC process, standards amendment policy, service compliance policy, suite versioning strategy

**Guides**
- New service lifecycle, how to consume standards, how to write a standard, compliance checking guide

**Services**
- `services/registry.yaml` — JANUS service registry (ATLAS registered as first consumer)

**Scripts**
- `scripts/scaffold-service.sh` — New service repository scaffolding
- `scripts/validate-compliance.sh` — Service compliance checking
- `scripts/check-standards-drift.sh` — Standards drift detection

[Unreleased]: https://github.com/janus/janus-engineering/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/janus/janus-engineering/releases/tag/v1.0.0
