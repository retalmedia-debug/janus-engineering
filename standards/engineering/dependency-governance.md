# Dependency Governance

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Every dependency is a decision to trust another team's code, adopt their security posture, accept their breaking changes, and inherit their operational complexity. Dependencies accumulate. The decision to add one is rarely evaluated as carefully as it deserves.

This standard defines how JANUS services evaluate, add, update, and remove dependencies.

---

## Risk Classification

| Level | Characteristics | Approval Required |
|---|---|---|
| **Low** | Widely adopted, security track record, actively maintained, permissive license, single well-defined purpose | Engineer |
| **Medium** | Less-established project, or broad surface area, or less-permissive license, or fewer maintainers | Senior Engineer |
| **High** | New or unproven project, complex surface area, restrictive or unclear license, security-sensitive domain | CSA |
| **Critical** | Touches auth, cryptography, secret management, or financial data; or >50k LOC of new code entering the dependency tree | CSA + explicit ADR |

---

## Evaluation Criteria

Before adding any dependency, evaluate:

1. **Necessity** — Does this solve a real problem that cannot be solved with ~50 lines of well-tested code?
2. **Adoption** — Is it widely used in similar production systems? (npm weekly downloads, GitHub stars are signals, not conclusions)
3. **Maintenance** — When was the last commit? Are issues addressed? Is there more than one active maintainer?
4. **License** — Is the license compatible with JANUS's licensing model? (See License Policy below)
5. **Security history** — Does it have a history of CVEs? How were they handled?
6. **Bundle impact** — What does this add to build size? Is there a lighter alternative?
7. **Transitive dependencies** — What does adding this package also add? Run `npm ls --depth=2` to see the full tree.
8. **Lockfile validation** — Confirm the installed version matches the declared range
9. **Bus factor** — Is this package owned by a single individual with no organizational backing?

---

## Dependency Addition Process

1. Confirm the dependency is necessary and classify its risk level
2. Obtain the required approval for the risk level
3. Pin the exact version in `package.json` for Critical-risk dependencies
4. Document the dependency in the PR description: what it does, why it was chosen over alternatives, what risk level it was classified as
5. Ensure the dependency appears in the Dependency Register (see below)
6. CI must pass with the new dependency before merging

---

## Dependency Register

Each service maintains a Dependency Register as a section of `docs/engineering/` or as a labeling convention in GitHub Issues. The register tracks:

- Package name and version range
- Risk classification
- Purpose
- License
- Last security audit date
- Owner / team responsible for monitoring

The register is reviewed quarterly as part of the maintenance cadence.

---

## Update Policy

| Update type | Policy |
|---|---|
| Security patch (CVE remediation) | Immediate — within the window defined by vulnerability severity |
| Minor/patch update | Quarterly routine review — update as a batch |
| Major version update | Evaluated as a new dependency addition: same evaluation criteria and approval process |
| Automated patch updates | Permitted via Dependabot/Renovate with CI gate — auto-merge requires all tests passing |

---

## Automated Updates

Automated update tools (Dependabot, Renovate) are permitted with the following constraints:
- Patch updates: auto-merge if all CI gates pass
- Minor updates: requires engineer review before merge
- Major updates: treated as a new dependency addition
- Security advisories: auto-create PRs immediately; human review required before merge

---

## License Policy

| License | Status |
|---|---|
| MIT | Approved |
| Apache 2.0 | Approved |
| BSD 2-Clause / 3-Clause | Approved |
| ISC | Approved |
| CC0 / Unlicense | Approved |
| LGPL v2.1 / v3 | Permitted with CSA review — linking restrictions must be understood |
| GPL v2 / v3 | Prohibited for application dependencies |
| AGPL | Prohibited |
| Commercial / Proprietary | Requires CSA + explicit ADR |
| Unknown / Custom | Never — clarify before consideration |

When a dependency's license is unclear or has changed, stop and clarify before merging.

---

## Security Vulnerability Response

| Severity | Response Window |
|---|---|
| Critical (CVSS ≥ 9.0) | Mitigate within 24 hours. If no patch is available: remove the dependency or disable the affected feature. |
| High (CVSS 7.0–8.9) | Mitigate within 72 hours |
| Medium (CVSS 4.0–6.9) | Mitigate within 14 days |
| Low (CVSS < 4.0) | Resolve in next quarterly dependency review |

Mitigation means either updating to a patched version, removing the dependency, or applying an approved workaround that removes the attack vector. "We know about it" is not mitigation.

---

## Removing Dependencies

A dependency that is no longer needed must be removed promptly. Unused dependencies that remain in `package.json`:
- Inflate CI time
- Increase attack surface
- Create confusion about what the codebase actually uses

Run dependency usage checks (`depcheck` or equivalent) during quarterly maintenance reviews. Removal of an unused dependency requires no special approval — it is expected housekeeping.
