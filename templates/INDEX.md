# Templates Index

**Suite Version:** 1.0.0
**Last Updated:** 2026-08-06

Templates are copied at service creation via `scripts/scaffold-service.sh`. Once copied, the service owns its instance. See [ADR-T002](../adr/internal/ADR-T002-template-copy-not-link.md) for the rationale.

---

## Repository Scaffold

`templates/repository/` — Complete repository scaffold for a new JANUS service. Copied in full by `scaffold-service.sh`.

**Root files:**
- `README.md` — Service entry point template
- `CLAUDE.md` — Claude Code instruction template (critical — fill completely)
- `AGENTS.md` — AI agent instruction template
- `CHANGELOG.md` — Empty changelog with [Unreleased] header
- `.gitignore` — Base JANUS gitignore
- `.editorconfig` — Frozen — same for all JANUS repos
- `.janus-compliance.yaml` — Compliance declaration
- `package.json` — Service package.json stub with @janus dev dependencies and standard scripts
- `.nvmrc` — Node.js version pin (Node 20 LTS)

**Governance documents** (`docs/governance/`):
- `repository-governance.md` — Decision matrix, roles, health reviews
- `development-workflow.md` — Feature lifecycle, Architectural Order reference
- `branching-strategy.md` — GitFlow model + service-specific scopes
- `commit-convention.md` — Format + service-specific scopes table
- `pull-request-rules.md` — Review requirements, size limits, turnaround
- `definition-of-done.md` — Universal criteria + work-type checklists
- `quality-gates.md` — Pre-commit, pre-merge, pre-release gates
- `release-strategy.md` — Release lifecycle + rollback procedure
- `versioning-strategy.md` — SemVer rules + artifact-specific versioning
- `repository-evolution-policy.md` — Directory evolution rules
- `onboarding.md` — Prerequisites, setup, first run, first PR
- `data-privacy.md` — Data classification framework + service entities
- `escalation-matrix.md` — Escalation categories + service contacts

**Architecture documents** (`docs/architecture/`):
- `engineering-principles.md` — Universal reference + domain-specific extensions
- `folder-strategy.md` — Directory structure documentation
- `repository-standards.md` — Root files, env conventions, configuration rules
- `ecosystem-integration.md` — Integration patterns + service's integration points
- `domain-model.md` — Entity format + service domain entities
- `system-context.md` — C4 Level 1 context
- `adr/README.md` — ADR index + process reference

**Engineering documents** (`docs/engineering/`):
- `coding-standards.md` — Standards reference + service tech specifics
- `naming-conventions.md` — JANUS framework + service domain terms

**Testing documents** (`docs/testing/`):
- `testing-strategy.md` — Pyramid from standard + service coverage thresholds

**Security documents** (`docs/security/`):
- `security-baseline.md` — JANUS categories + service platform specifics
- `threat-model.md` — Adversary format + service threats

**Operations documents** (`docs/operations/`):
- `configuration-management.md` — Framework + service env var prefix
- `environment-management.md` — Environment definitions + service topology
- `observability-strategy.md` — Categories + service metrics
- `logging-standards.md` — Standard reference + service-name registration
- `error-handling-standards.md` — Standard reference + service error codes
- `incident-response-runbook.md` — Runbook format + service-specific steps

**AI collaboration documents** (`docs/ai-collaboration/`):
- `claude-code-responsibilities.md` — JANUS scope + service-specific activities
- `cursor-responsibilities.md` — Scope + service cursor rules

**Database documents** (`docs/database/`):
- `database-governance.md` — Platform reference + service schema rules
- `migration-governance.md` — Standard reference (if Supabase service)

**API documents** (`docs/api/`):
- `api-governance.md` — Standard reference + service extensions
- `error-catalog.md` — Error code catalog format
- `event-catalog.md` — Event catalog for async events published by this service (CloudEvents format)

**Documentation index** (`docs/`):
- `INDEX.md` — Complete documentation index template covering all 13 governance, 7 architecture, and other doc sections

**GitHub templates** (`.github/`):
- `pull_request_template.md`
- `ISSUE_TEMPLATE/bug-report.md`
- `ISSUE_TEMPLATE/feature-request.md`
- `ISSUE_TEMPLATE/technical-debt.md`
- `ISSUE_TEMPLATE/adr-proposal.md`
- `ISSUE_TEMPLATE/governance-exception.md`
- `ISSUE_TEMPLATE/integration-request.md` — Cross-service integration request (redirects to janus-engineering)

---

## Individual Document Templates

`templates/documents/` — Templates for documents added to an existing service or filed during the service lifecycle.

**ADR:**
- `adr/ADR-XXXX-template.md` — Copy for each new ADR

**RFC:**
- `rfc/RFC-TEMPLATE.md` — Copy when filing a standard change RFC with the JAC

**Post-Mortem:**
- `post-mortem/POST-MORTEM-TEMPLATE.md` — Copy after every P0 or P1 incident

**Incident Report:**
- `incident-report/INCIDENT-REPORT-TEMPLATE.md` — Open as a GitHub Issue when declaring an incident

---

## GitHub Issue Templates (for janus-engineering itself)

`.github/ISSUE_TEMPLATE/` — Issue templates for changes to the engineering platform:
- `rfc-standard-change.md` — File an RFC for a standard change or addition
- `service-registration.md` — Register a new JANUS service (Phase 0, Gate 0.1)
- `ecosystem-adr-proposal.md` — Propose an ecosystem-level ADR

---

## GitHub Workflow Templates

`templates/github/workflows/` — CI/CD workflow templates for JANUS services:
- `ci-base.yml` — Base CI workflow (compliance, lint, test, security)
- `compliance-check.yml` — Standalone compliance check with weekly drift detection
