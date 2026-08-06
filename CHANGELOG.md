# Changelog

All notable changes to the janus-engineering standards suite are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This repository uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html) for the suite as a whole.

---

## [Unreleased]

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
