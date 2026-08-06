# janus-engineering

**The engineering constitution of the JANUS ecosystem.**

This repository does not run. It does not serve users. It does not contain application code, APIs, databases, or frontends. It contains only engineering knowledge — the standards, templates, and architectural decisions that govern every JANUS service.

Every team that builds a JANUS service begins here.

---

## What This Repository Contains

| Directory | Purpose |
|---|---|
| `standards/` | Binding JANUS Engineering Standards (JES). All JANUS services must comply. |
| `templates/` | Document templates instantiated into each new service repository at creation. |
| `adr/` | Ecosystem-level Architecture Decision Records binding on all services. |
| `tooling/` | Shared tooling configurations published as `@janus` npm packages. |
| `docs/` | Governance of this repository itself: the RFC process, compliance policy, service guides. |
| `scripts/` | Compliance checking and service scaffolding tools. |
| `services/` | Registry of all JANUS services with compliance status. |

---

## Suite Version

The standards suite is versioned as a whole. The current version is in `VERSION`.

Services declare which suite version they target in `.janus-compliance.yaml`.

---

## How to Use This Repository

**Starting a new JANUS service:**
Read `docs/guides/new-service-lifecycle.md`. Then run `scripts/scaffold-service.sh`.

**Consuming standards in an existing service:**
Read `docs/guides/how-to-consume-standards.md`.

**Proposing a change to a standard:**
Read `docs/governance/rfc-process.md`. Open a GitHub Issue using the `rfc-standard-change.md` template.

**Checking compliance:**
Run `scripts/validate-compliance.sh` from within a service repository.

---

## JANUS Ecosystem

| Service | Repository | Domain | Status |
|---|---|---|---|
| ATLAS | `atlas-v1` | Geo Intelligence & External Intelligence | Active |
| VENUS | `venus-v1` | _Reserved_ | Not started |
| NARCOS | `narcos-v1` | _Reserved_ | Not started |
| AURUS | `aurus-v1` | _Reserved_ | Not started |
| CRONOS | `cronos-v1` | _Reserved_ | Not started |
| GCS | `gcs-v1` | _Reserved_ | Not started |
| HERA | `hera-v1` | _Reserved_ | Not started |

Full ecosystem context: `docs/ecosystem-map.md`

---

## Governance

This repository is governed by the JANUS Architecture Council (JAC).

Standard changes follow the RFC process documented in `docs/governance/rfc-process.md`.

No standard is changed without a comment period, JAC disposition, and a grace period for service adoption.

---

## Repository Integrity

This repository follows every standard it defines for others.

It uses the same commit convention, branching strategy, PR rules, and documentation lifecycle that it requires of all JANUS services. A repository that does not comply with its own standards is not credible.
