<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/repository-governance.md -->

# Repository Governance

**Version:** 1.0.0
**Status:** Draft
**Owner:** Chief Software Architect
**Last Reviewed:** {{DATE}}

---

## 1. Purpose

This document defines the governance structure for `{{SERVICE_REPO}}` — the {{SERVICE_DOMAIN}} service in the JANUS ecosystem.

This governance document is governed by the JANUS Engineering Standard:
[How This Repository Is Governed](https://github.com/janus/janus-engineering/blob/v{{JANUS_SUITE_VERSION}}/docs/governance/how-this-repo-is-governed.md)
Suite version: janus-engineering@{{JANUS_SUITE_VERSION}}

---

## 2. Authority

**Chief Software Architect (CSA):** [[FILL: Name]]
**Technical Lead(s):** [[FILL: Names, or "CSA only" if single-person team]]

The CSA is the Directly Responsible Individual (DRI) for all engineering decisions in `{{SERVICE_REPO}}`. The DRI ensures the Architectural Order is followed, all governance documents are current, and the Definition of Done is enforced on every PR.

---

## 3. Decision Authority Matrix

| Decision Type | Who Can Decide |
|---|---|
| Accept or reject an ADR | CSA |
| Approve a PR to `main` | CSA + one other engineer (2 approvals total) |
| Approve a PR to `develop` | Any engineer with codebase context |
| Add a high-risk dependency | CSA |
| Approve a database migration to main tables | CSA |
| Waive a quality gate | CSA (documented waiver required) |
| Create or modify a branch protection rule | CSA |
| Request a janus-engineering standards waiver | CSA |

[[FILL: Adjust the matrix above to reflect the actual team structure. If this is a solo service, note "CSA only" where appropriate.]]

---

## 4. Branch Protection

| Branch | Rules |
|---|---|
| `main` | Protected. Requires [[FILL: 2]] approvals including CSA. All CI gates must pass. No direct push. |
| `develop` | Protected. Requires [[FILL: 1]] approval. All CI gates must pass. No direct push. |

Branch protection is configured in GitHub repository settings. It is not configurable via PR.

---

## 5. Repository Health Reviews

**Monthly:** CSA reviews the technical debt register and open GitHub Issues.

**Quarterly:**
- Documentation accuracy review
- Dependency security and update review
- Quality gate effectiveness review
- ADR relevance review

**Annually:**
- Full repository audit against janus-engineering compliance
- Suite version upgrade assessment
- Architecture review against current domain understanding

---

## 6. Governance Document Maintenance

All documents in `docs/` are owned by the role listed in their `Owner` header. When a document is materially changed by a code change, the code PR includes the documentation update. Documentation PRs are not deferred.

---

## 7. Conflict Resolution

Technical conflicts are resolved by:
1. Discussion in the relevant PR or GitHub Issue
2. If unresolved: CSA makes the final decision
3. If the conflict involves a JANUS engineering standard: escalated to the JAC via an RFC

---

## 8. CSA Succession

If the CSA is unavailable or changes:
1. A Senior Engineer with knowledge of the codebase serves as acting CSA
2. All active ADRs and open governance decisions are documented before transition
3. The incoming CSA reviews all governance documents before making changes
4. The service registry entry in `janus-engineering/services/registry.yaml` is updated

Bus factor for `{{SERVICE_NAME}}` must remain ≥ 2 at all times.
