# Standards Index

**Suite Version:** 1.0.0
**Last Updated:** 2026-08-06
**Count:** 34

All JANUS Engineering Standards are listed here. The `Binding Level` column defines the obligation for each JANUS service.

| Binding Level | Meaning |
|---|---|
| `Mandatory` | All JANUS services must comply. No waiver without JAC approval and a documented exception. |
| `Mandatory-if-applicable` | Mandatory for services that use the relevant technology or pattern. |
| `Recommended` | Strong guidance. Deviations permitted but must be documented in a service ADR. |

---

## Architecture

| Standard | Binding Level | Description |
|---|---|---|
| [engineering-principles.md](architecture/engineering-principles.md) | Mandatory | 11 universal engineering principles |
| [architectural-order.md](architecture/architectural-order.md) | Mandatory | Non-negotiable sequencing: Vision → Optimization |
| [adr-format.md](architecture/adr-format.md) | Mandatory | ADR format, lifecycle, submission process |
| [service-sizing-guidance.md](architecture/service-sizing-guidance.md) | Mandatory | When to create a new service vs. extend an existing one |

## Engineering

| Standard | Binding Level | Description |
|---|---|---|
| [git-strategy.md](engineering/git-strategy.md) | Mandatory | Version control philosophy, rebase rules, tagging |
| [code-review-standard.md](engineering/code-review-standard.md) | Mandatory | Review requirements, author/reviewer responsibilities, comment protocol |
| [refactoring-policy.md](engineering/refactoring-policy.md) | Mandatory | Refactoring definition, types, when permitted |
| [long-term-maintenance.md](engineering/long-term-maintenance.md) | Mandatory | Maintenance cadences, dead code, knowledge preservation |
| [dependency-governance.md](engineering/dependency-governance.md) | Mandatory | Risk classification, evaluation, license policy, vulnerability response |
| [technical-debt-policy.md](engineering/technical-debt-policy.md) | Mandatory | Debt classification, register, 20% sprint rule |
| [sprint-governance.md](engineering/sprint-governance.md) | Mandatory | Sprint structure, capacity allocation, ceremony requirements |
| [feature-flag-lifecycle.md](engineering/feature-flag-lifecycle.md) | Mandatory | Flag creation, activation, documentation, retirement |
| [package-publishing-governance.md](engineering/package-publishing-governance.md) | Mandatory-if-applicable | Publishing, versioning, deprecation for shared packages |
| [package-manager-standard.md](engineering/package-manager-standard.md) | Mandatory | pnpm as the JANUS standard package manager |
| [linting-standard.md](engineering/linting-standard.md) | Mandatory | ESLint configuration requirements |
| [formatter-standard.md](engineering/formatter-standard.md) | Mandatory | Prettier as the JANUS formatter |
| [typescript-baseline.md](engineering/typescript-baseline.md) | Mandatory-if-applicable | TypeScript compiler options for TypeScript services |

## Documentation

| Standard | Binding Level | Description |
|---|---|---|
| [documentation-strategy.md](documentation/documentation-strategy.md) | Mandatory | What to document, where, why |
| [documentation-lifecycle.md](documentation/documentation-lifecycle.md) | Mandatory | Document states, lifecycle, versioning |

## Testing

| Standard | Binding Level | Description |
|---|---|---|
| [testing-philosophy.md](testing/testing-philosophy.md) | Mandatory | Pyramid ratios, determinism, speed, honest failure |

## Security

| Standard | Binding Level | Description |
|---|---|---|
| [security-baseline.md](security/security-baseline.md) | Mandatory | Universal security categories and minimum requirements |
| [containerization-standard.md](security/containerization-standard.md) | Mandatory-if-applicable | Base image, non-root user, scanning for containerized services |
| [secret-management-standard.md](security/secret-management-standard.md) | Mandatory | Secret storage, rotation, breach response, access controls |

## Operations

| Standard | Binding Level | Description |
|---|---|---|
| [logging-standard.md](operations/logging-standard.md) | Mandatory | Structured JSON format, required fields, log levels |
| [error-handling-standard.md](operations/error-handling-standard.md) | Mandatory | Error taxonomy, response envelope format |
| [alerting-standard.md](operations/alerting-standard.md) | Mandatory | Mandatory alerts, severity definitions, runbook requirements |
| [runbook-standard.md](operations/runbook-standard.md) | Mandatory | Runbook format, quality requirements, freshness policy |
| [observability-standard.md](operations/observability-standard.md) | Mandatory | Three-pillar observability (logs/metrics/traces), mandatory metrics, X-Request-ID contract |

## Database

| Standard | Binding Level | Description |
|---|---|---|
| [supabase-migration-governance.md](database/supabase-migration-governance.md) | Mandatory-if-applicable | Migration immutability, safety rules (Supabase services) |

## API

| Standard | Binding Level | Description |
|---|---|---|
| [api-design-standard.md](api/api-design-standard.md) | Mandatory | URL patterns, HTTP semantics, response format, versioning |
| [event-schema-standard.md](api/event-schema-standard.md) | Mandatory-if-applicable | CloudEvents envelope, event type naming, schema versioning |

## AI Collaboration

| Standard | Binding Level | Description |
|---|---|---|
| [ai-collaboration-rules.md](ai-collaboration/ai-collaboration-rules.md) | Mandatory | AI as assistant, approved tools, universal rules |
| [chatgpt-responsibilities.md](ai-collaboration/chatgpt-responsibilities.md) | Mandatory | External AI tool governance |
| [human-responsibilities.md](ai-collaboration/human-responsibilities.md) | Mandatory | Non-delegable human responsibilities |
