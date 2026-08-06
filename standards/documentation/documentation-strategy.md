# Documentation Strategy

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Philosophy

Documentation is knowledge transfer. It bridges the gap between what an engineer knows in their head and what the next engineer needs to know to work effectively. Documentation that is too detailed becomes outdated. Documentation that is too sparse is useless. The discipline is knowing which knowledge must be written down and which knowledge is already encoded in the code itself.

**Document the why. Trust the code for the what.**

Well-named identifiers, clear function signatures, and small focused modules already document what the code does. Documentation's job is to explain why decisions were made, what constraints exist, what non-obvious invariants apply, and what the system looks like from a distance that the code cannot provide.

---

## What Must Be Documented

| Subject | Where |
|---|---|
| Architectural decisions with significant trade-offs | ADR in `docs/architecture/adr/` |
| Engineering principles and their application | `docs/architecture/engineering-principles.md` |
| Why the repository is structured as it is | `docs/architecture/folder-strategy.md` |
| How the repository integrates with the JANUS ecosystem | `docs/architecture/ecosystem-integration.md` |
| How to develop locally (setup to first test run) | `docs/governance/onboarding.md` |
| All governance rules and their rationale | `docs/governance/` |
| Database schema intent, relationships, and RLS | `docs/database/schema/` |
| API contracts, error codes, and versioning | `docs/api/` |
| Security requirements and threat model | `docs/security/` |
| How and where to configure each environment | `docs/operations/configuration-management.md` |
| What the monitoring and alerting surfaces look like | `docs/operations/observability-strategy.md` |
| Non-obvious code behavior | Inline comments |
| The domain model and its entities | `docs/architecture/domain-model.md` |

---

## What Is Not Separately Documented

| Subject | Reason |
|---|---|
| What a well-named function does | The function name and signature already say it |
| How to use a library | The library's own documentation already says it |
| What a variable contains | The type and name already say it |
| Step-by-step implementation guides | The code is the implementation guide |
| Business requirements | Product management artifacts, not engineering docs |

Do not write documentation that repeats what the code already communicates clearly. Writing documentation for documentation's sake creates maintenance burden and dilutes the signal of the documentation that matters.

---

## Document Header Format

Every document in `docs/` begins with a metadata header:

```markdown
# Document Title

**Version:** 1.0.0
**Status:** Draft | Active | Under Review | Deprecated
**Owner:** [Role or Name]
**Last Reviewed:** YYYY-MM-DD
```

Documents without this header are not considered Active and will not be indexed.

---

## Documentation Hierarchy

Documents live where they describe:

```
docs/
├── governance/       ← How the repository operates
├── architecture/     ← Structure, decisions, ecosystem context
│   └── adr/         ← Architecture Decision Records
├── engineering/      ← Coding standards, naming, refactoring
├── testing/          ← Test strategy, coverage, tooling
├── security/         ← Baseline, threat model
├── operations/       ← Configuration, environments, observability, logging
├── ai-collaboration/ ← Tool responsibilities, human responsibilities
├── database/         ← Governance, schema documentation
└── api/              ← Design, specifications, error catalog
```

A document lives in the directory that best describes what it governs. If a document governs how the team works, it is in `governance/`. If it governs the shape of the data, it is in `database/`. If it governs how the API behaves, it is in `api/`.

---

## Language Standards

- Active voice: "The CSA approves ADRs" not "ADRs are approved by the CSA"
- Present tense: "The system returns 404" not "The system will return 404"
- Second person: "You configure the environment" not "Engineers configure the environment"
- Complete sentences in prose sections; bullet points for lists of items
- No acronyms without expansion on first use per document (even familiar ones: JWT, UUID, RLS)

---

## Ownership

Every document has an owner. The owner is responsible for:
- Keeping the document accurate as the system evolves
- Initiating reviews when the document's subject matter changes
- Resolving disputes about the document's content

The owner is listed in the document header. When an owner changes roles or leaves, the CSA assigns a new owner within 5 business days.

---

## Documentation in the Development Workflow

Documentation is not an afterthought. The Architectural Order (Phase 4) is dedicated to documentation planning. Documentation for a feature is:
- Written before implementation (API specs, schema docs, ADRs)
- Updated in the same PR as the code change it documents
- Reviewed as part of the PR review

A PR that changes behavior without updating the relevant documentation fails the Documentation DoD checklist item and should not be merged.
