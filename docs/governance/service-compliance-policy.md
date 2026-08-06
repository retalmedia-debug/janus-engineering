# Service Compliance Policy

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## What Compliance Means

A JANUS service is **compliant** with the standards suite when:

1. Its `.janus-compliance.yaml` declares a suite version that is within the active support window
2. The `validate-compliance.sh` check passes with no mandatory violations
3. All declared compliance exceptions have non-expired waivers
4. No mandatory document is missing from `docs/`
5. The `@janus` tooling packages are declared in `package.json`

Compliance is not a binary judgment about every word in every governance document. Content of governance documents is reviewed by humans. The compliance check validates structure and configuration — the presence of required documents, the correct tooling dependencies, the `.janus-compliance.yaml` declaration.

---

## Compliance Check Scope

What `validate-compliance.sh` validates:

**Required:**
- [ ] `.janus-compliance.yaml` exists and has valid YAML syntax
- [ ] `janus_engineering_suite_version` field is present and valid
- [ ] `CLAUDE.md` exists and contains the suite version reference
- [ ] All mandatory governance documents exist (presence, not content)
- [ ] `.github/pull_request_template.md` exists
- [ ] At minimum one ISSUE_TEMPLATE exists in `.github/ISSUE_TEMPLATE/`
- [ ] `@janus/eslint-config` is declared in `devDependencies`
- [ ] `@janus/tsconfig` is declared in `devDependencies` (for TypeScript services)
- [ ] `@janus/prettier-config` is declared in `devDependencies`
- [ ] `@janus/commitlint-config` is declared in `devDependencies`
- [ ] No `package-lock.json` or `yarn.lock` exists (pnpm required)
- [ ] No `--no-verify` appears in any `.github/workflows/` file

**Not validated by the automated check (human review):**
- Content accuracy of governance documents
- ADR completeness
- Error catalog completeness
- Quality of test coverage
- Security baseline implementation

---

## Suite Version Support Window

| Suite Version Status | Meaning |
|---|---|
| `Current` | Active support. New features and patches. Services should be on this version. |
| `Supported` | No new features. Receives security-related PATCH releases. Services may remain here within grace period. |
| `Unsupported` | No longer maintained. Services must upgrade or obtain a waiver. |

A suite version becomes `Unsupported` 90 days after the next MAJOR release.

---

## Waivers

A service may request a waiver from a specific mandatory requirement when:
- Adoption would require more time than the grace period allows (legitimate technical reasons, not resource preference)
- A requirement conflicts with a service-specific constraint not anticipated by the standard

**Waiver request process:**
1. Open a GitHub Issue in `janus-engineering` using the `governance-exception.md` template
2. Include: the requirement being waived, the affected service, the technical justification, the proposed expiry date
3. JAC reviews within 10 business days
4. If granted: the waiver is documented in the service's `.janus-compliance.yaml` under `compliance_exceptions`

**Waiver properties:**
- Always time-bounded — no permanent waivers
- Maximum duration: 90 days per waiver
- Renewable once for a further 90 days with renewed justification
- After two renewals, the waiver requires a formal RFC to change the underlying standard

```yaml
# .janus-compliance.yaml example
compliance_exceptions:
  - standard: "standards/engineering/package-manager-standard.md"
    waiver_id: "WAIVER-001"
    rationale: "Service is mid-migration from npm; pnpm adoption completing by 2026-11-01"
    expiry: "2026-11-01"
    approved_by: "JANUS Principal Architect"
```

---

## Ecosystem Compliance Report

The `generate-compliance-report.sh` script produces a monthly report:

```
JANUS Ecosystem Compliance Report — 2026-08-06
Suite Version: 1.0.0

Service          | Suite Version | Mandatory  | Exceptions | Status
-----------------+---------------+------------+------------+--------
atlas-v1         | 1.0.0         | PASS        | 0           | COMPLIANT
[future-service] | —             | —           | —           | NOT REGISTERED
```

The report is generated monthly and posted to the `services/compliance/` directory as a YAML file. It is also available as a GitHub Actions artifact from the `compliance-report.yml` workflow.

---

## Non-Compliant Services

A service that fails the compliance check and has no valid waiver:
1. Receives a notification via GitHub Issue in the service repository
2. Has 30 days to resolve the violation or obtain a waiver
3. After 30 days: the Principal Architect escalates to the service CSA directly

The compliance check is a tool for awareness, not a deployment blocker (the service's own CI gates block deployments on quality failures; the ecosystem compliance check tracks governance compliance separately). However, a persistently non-compliant service reflects on the ecosystem's governance integrity and is treated as a serious concern.
