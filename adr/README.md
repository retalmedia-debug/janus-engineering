# Architecture Decision Records — janus-engineering

This directory contains ecosystem-level and internal Architecture Decision Records for the JANUS ecosystem.

---

## ADR Classes

| Prefix | Location | Scope |
|---|---|---|
| `ADR-E` | `ecosystem/` | Decisions binding on all JANUS services |
| `ADR-T` | `internal/` | Decisions specific to how janus-engineering operates |
| `ADR-0001` (plain numbers) | `<service-repo>/docs/architecture/adr/` | Service-specific decisions; never stored here |

---

## Ecosystem ADR Index

| ADR | Title | Status | Date |
|---|---|---|---|
| [ADR-E001](ecosystem/ADR-E001-polyrepo-strategy.md) | Polyrepo Strategy | Accepted | 2026-08-06 |
| [ADR-E002](ecosystem/ADR-E002-cicd-platform.md) | GitHub Actions as CI/CD Platform | Accepted | 2026-08-06 |
| [ADR-E003](ecosystem/ADR-E003-package-manager.md) | pnpm as Package Manager | Accepted | 2026-08-06 |
| [ADR-E004](ecosystem/ADR-E004-typescript-primary-language.md) | TypeScript as Primary Language | Accepted | 2026-08-06 |
| [ADR-E005](ecosystem/ADR-E005-api-response-envelope.md) | Unified API Response Envelope | Accepted | 2026-08-06 |
| [ADR-E006](ecosystem/ADR-E006-logging-format.md) | Structured JSON Logging Standard | Accepted | 2026-08-06 |

## Internal ADR Index

| ADR | Title | Status | Date |
|---|---|---|---|
| [ADR-T001](internal/ADR-T001-standards-suite-versioning.md) | Standards Suite Versioned as a Whole | Accepted | 2026-08-06 |
| [ADR-T002](internal/ADR-T002-template-copy-not-link.md) | Templates Copied at Creation, Not Linked | Accepted | 2026-08-06 |
| [ADR-T003](internal/ADR-T003-tooling-via-npm-packages.md) | Tooling Configurations as npm Packages | Accepted | 2026-08-06 |

---

## Ecosystem ADR Process

Ecosystem ADRs follow the RFC process defined in `docs/governance/rfc-process.md`.

An ecosystem ADR is required when a decision:
- Affects how two or more JANUS services must be built or operated
- Changes the interface between JANUS services
- Introduces a new technology or platform used by more than one service
- Changes a standard to which all services must conform

The ADR format is defined in `standards/architecture/adr-format.md`.

---

## Numbering

Numbers are never reused. A rejected ADR retains its number with `Status: Rejected`. If a decision is revisited, a new ADR supersedes the original.

Next available ecosystem number: `ADR-E007`
Next available internal number: `ADR-T004`
