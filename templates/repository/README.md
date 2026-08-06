<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/README.md -->

# {{SERVICE_NAME}}

> [[FILL: One-sentence description of what this service does and why it exists.]]

**Domain:** {{SERVICE_DOMAIN}}
**Status:** [[FILL: bootstrapping | governance-establishment | architecture | implementation | production]]
**Repository:** `{{SERVICE_REPO}}`
**Chief Software Architect:** {{SERVICE_CSA}}
**Suite Version:** {{JANUS_SUITE_VERSION}}

---

## What This Service Does

[[FILL: 2-4 sentences. What domain does this service own? What problem does it solve? Who are its users? Do not describe technology choices here.]]

---

## Ecosystem Position

{{SERVICE_NAME}} is part of the [JANUS ecosystem](https://github.com/janus/janus-engineering). It governs the **{{SERVICE_DOMAIN}}** domain.

**Upstream dependencies:** [[FILL: List services this service consumes, or "None"]]
**Downstream consumers:** [[FILL: List services that consume this service, or "None currently"]]

---

## Documentation

| Section | Location |
|---|---|
| Governance | `docs/governance/` |
| Architecture | `docs/architecture/` |
| Engineering | `docs/engineering/` |
| Testing | `docs/testing/` |
| Security | `docs/security/` |
| Operations | `docs/operations/` |
| Database | `docs/database/` |
| API | `docs/api/` |
| AI Collaboration | `docs/ai-collaboration/` |

Full documentation index: [`docs/INDEX.md`](docs/INDEX.md)

---

## Getting Started

See [`docs/governance/onboarding.md`](docs/governance/onboarding.md) for environment setup, prerequisites, and first-run instructions.

---

## JANUS Standards

This service is governed by the JANUS Engineering Standards suite. Compliance is declared in [`.janus-compliance.yaml`](.janus-compliance.yaml).

Standards reference: `https://github.com/janus/janus-engineering`
