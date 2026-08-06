<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/INDEX.md -->

# {{SERVICE_NAME}} Documentation Index

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Last Updated:** [[FILL: YYYY-MM-DD]]

---

## Governance

| Document | Description |
|---|---|
| [Repository Governance](governance/repository-governance.md) | Decision authority matrix, branch protection, health reviews |
| [Development Workflow](governance/development-workflow.md) | Feature lifecycle and Architectural Order |
| [Branching Strategy](governance/branching-strategy.md) | Branch types, protection rules, naming conventions |
| [Commit Convention](governance/commit-convention.md) | Format and service-specific scopes |
| [Pull Request Rules](governance/pull-request-rules.md) | Review requirements, size limits, turnaround SLAs |
| [Definition of Done](governance/definition-of-done.md) | Universal criteria and work-type checklists |
| [Quality Gates](governance/quality-gates.md) | Pre-commit, pre-merge, pre-release gates |
| [Release Strategy](governance/release-strategy.md) | Release lifecycle and rollback procedure |
| [Versioning Strategy](governance/versioning-strategy.md) | SemVer rules and breaking change definition |
| [Repository Evolution Policy](governance/repository-evolution-policy.md) | How the repository structure changes over time |
| [Onboarding Guide](governance/onboarding.md) | Prerequisites, setup, first PR |
| [Data Privacy](governance/data-privacy.md) | Data classification and entity inventory |
| [Escalation Matrix](governance/escalation-matrix.md) | Incident contacts and escalation paths |

## Architecture

| Document | Description |
|---|---|
| [Engineering Principles](architecture/engineering-principles.md) | Universal principles + domain-specific extensions |
| [Folder Strategy](architecture/folder-strategy.md) | Directory structure and conventions |
| [Repository Standards](architecture/repository-standards.md) | Required root files, env conventions |
| [Ecosystem Integration](architecture/ecosystem-integration.md) | How this service connects to the JANUS ecosystem |
| [Domain Model](architecture/domain-model.md) | Core entities, value objects, relationships |
| [System Context](architecture/system-context.md) | C4 Level 1 context diagram |
| [ADR Index](architecture/adr/README.md) | Architecture decisions for this service |

## Engineering

| Document | Description |
|---|---|
| [Coding Standards](engineering/coding-standards.md) | Standards reference and service-specific conventions |
| [Naming Conventions](engineering/naming-conventions.md) | TypeScript, file, API, and database naming |

## Testing

| Document | Description |
|---|---|
| [Testing Strategy](testing/testing-strategy.md) | Pyramid ratios, tooling, coverage thresholds |

## Security

| Document | Description |
|---|---|
| [Security Baseline](security/security-baseline.md) | Authentication, authorization, secret management |
| [Threat Model](security/threat-model.md) | STRIDE analysis and open threats |

## Operations

| Document | Description |
|---|---|
| [Configuration Management](operations/configuration-management.md) | Environment variable registry |
| [Environment Management](operations/environment-management.md) | Environment topology and isolation |
| [Observability Strategy](operations/observability-strategy.md) | Logs, metrics, traces, alerting |
| [Logging Standards](operations/logging-standards.md) | Service-specific logging configuration |
| [Error Handling Standards](operations/error-handling-standards.md) | Error classes and error catalog reference |
| [Incident Response Runbook](operations/incident-response-runbook.md) | Alert runbooks and operational procedures |

## Database

| Document | Description |
|---|---|
| [Database Governance](database/database-governance.md) | Schema ownership, naming, RLS |
| [Migration Governance](database/migration-governance.md) | Migration rules and review requirements |

## API

| Document | Description |
|---|---|
| [API Governance](api/api-governance.md) | OpenAPI spec location, versioning, authentication |
| [Error Catalog](api/error-catalog.md) | All error codes for this service |
| [Event Catalog](api/event-catalog.md) | All events published by this service |

## AI Collaboration

| Document | Description |
|---|---|
| [Claude Code Responsibilities](ai-collaboration/claude-code-responsibilities.md) | Authorized and prohibited AI activities |
| [Cursor Responsibilities](ai-collaboration/cursor-responsibilities.md) | Cursor scope and rules |
