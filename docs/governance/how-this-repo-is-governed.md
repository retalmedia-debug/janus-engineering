# How This Repository Is Governed

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## The JANUS Architecture Council (JAC)

`janus-engineering` is governed by the **JANUS Architecture Council** — the authority that changes standards binding on all services.

### JAC Composition

| Role | Authority | Membership |
|---|---|---|
| JANUS Principal Architect | Final decision authority over all ecosystem standards; tie-break vote | Permanent |
| Chief Software Architect (per active service) | Voting member for standards affecting their service | One per active service |
| Security Lead | Voting member for all security-related standards | Permanent (if role exists) |

**Quorum:** The Principal Architect plus a majority of active service CSAs.

### JAC Meeting Cadence

- Monthly: Standard review and RFC disposition
- On-demand: Urgent RFC dispositions (emergency security changes, critical defect corrections)

JAC decisions are documented in the relevant RFC GitHub Issue or ecosystem ADR, not in meeting notes.

---

## Authority Levels

| Action | Authority Required |
|---|---|
| Fix a typo in a standard | Any engineer via PR + one JAC member review |
| Add a `Recommended` standard | RFC + JAC acceptance |
| Add a `Mandatory` or `Mandatory-if-applicable` standard | RFC + JAC acceptance |
| Change a `Mandatory` standard | RFC + JAC acceptance + grace period |
| Accept an ecosystem ADR | JAC quorum |
| Reject an ecosystem ADR | Principal Architect (unilateral) or JAC quorum |
| Bump the suite MAJOR version | Principal Architect authorization |
| Bump the suite MINOR version | Automatic on RFC acceptance |
| Publish a `@janus` tooling package | CI/CD automated on merge to `main` (PR reviewed by JAC member) |
| Add a service to the registry | Service CSA via PR + Principal Architect acknowledgment |

---

## Protected Branches

| Branch | Rules |
|---|---|
| `main` | Protected. No direct push. Requires PR with ≥1 JAC member approval. All CI gates must pass. |
| `develop` (if used) | Protected. No direct push. Requires PR with ≥1 engineer approval. |

---

## How janus-engineering Differs from Service Governance

Service governance documents describe how one team operates one service. `janus-engineering` governance describes how the JAC operates the ecosystem's constitutional layer.

Key differences:
- Changes here affect all JANUS services — the blast radius is always ecosystem-wide
- The RFC process is required for substantive changes — no "quick fixes" to mandatory standards
- Grace periods are mandatory for MINOR and MAJOR changes — services are not expected to update immediately
- The Principal Architect has final authority — this cannot be overridden by an individual service's CSA

---

## janus-engineering Follows Its Own Standards

This repository complies with every standard it defines. It is itself a JANUS service (a meta-service). Its compliance is maintained in `services/compliance/janus-engineering.yaml`.

When a standard changes in janus-engineering, this repository is the first to adopt the new standard. Leading by example is a governance principle, not just good practice.

---

## Succession

If the Principal Architect role changes:
1. The outgoing Principal Architect documents all active RFCs, pending ecosystem ADRs, and in-progress suite changes
2. The incoming Principal Architect reviews all active governance documents before making any changes
3. The JAC composition record is updated
4. No active RFC is abandoned — it is either completed or explicitly deferred with rationale

The JAC maintains a minimum of one Senior Engineer per service who can serve as CSA if the current CSA is unavailable. Bus factor ≥ 2 applies at the ecosystem level as well as the service level.
