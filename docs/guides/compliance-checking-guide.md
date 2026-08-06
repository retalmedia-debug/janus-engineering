# Compliance Checking Guide

**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## What Compliance Means

A JANUS service is compliant when it meets all five conditions:

1. Declares a supported suite version in `.janus-compliance.yaml`
2. Passes all automated checks in `validate-compliance.sh`
3. Has no expired waivers
4. Has completed all human-only checks for its development phase
5. Is registered in `janus-engineering/services/registry.yaml`

Full policy: `docs/governance/service-compliance-policy.md`

---

## Running the Compliance Check

### Locally

From the root of your service repository:

```bash
curl -fsSL https://raw.githubusercontent.com/janus/janus-engineering/main/scripts/validate-compliance.sh \
  | bash -s -- --repo-path .
```

Or, if you have the `janus-engineering` repository cloned locally:

```bash
/path/to/janus-engineering/scripts/validate-compliance.sh --repo-path /path/to/your-service
```

### In CI

The compliance check runs as the first job in the CI workflow (see `templates/github/workflows/ci-base.yml`). A compliance failure blocks all subsequent jobs.

---

## Interpreting Results

The script outputs one of three markers per check:

| Marker | Meaning |
|---|---|
| `[PASS]` | Requirement is met |
| `[WARN]` | Advisory check not met — does not fail CI but should be addressed |
| `[FAIL]` | Requirement not met — CI fails |

At the end of the run, the script prints a summary:

```
Compliance check complete.
  Passed:  24
  Warned:  2
  Failed:  0

Result: COMPLIANT
```

Exit code 0 means compliant. Exit code 1 means one or more `[FAIL]` results.

---

## Common Failures and Fixes

### `[FAIL] .janus-compliance.yaml not found`

Create the file using the template:
```bash
cp templates/repository/.janus-compliance.yaml .janus-compliance.yaml
# Then fill in the placeholders
```

### `[FAIL] Suite version not declared`

Open `.janus-compliance.yaml` and set `janus-suite-version` to the current suite version (check `janus-engineering/VERSION`).

### `[FAIL] CLAUDE.md does not reference janus-engineering suite version`

Your `CLAUDE.md` must contain a `JANUS Standards Reference` section that includes the suite version. See `templates/repository/CLAUDE.md` for the required format.

### `[FAIL] Required document missing: docs/governance/repository-governance.md`

The required governance document does not exist. Copy it from the template:
```bash
cp /path/to/janus-engineering/templates/repository/docs/governance/repository-governance.md docs/governance/
# Then fill in all [[FILL:]] placeholders
```

### `[FAIL] Unfilled placeholder found: [[FILL:`

One or more template files were copied but not completed. Search for unfilled markers:
```bash
grep -r '\[\[FILL:' docs/
```
Fill each one or remove the section if it does not apply to your service.

### `[WARN] pnpm-lock.yaml not found`

You have not run `pnpm install`. Run it and commit the lockfile.

### `[WARN] @janus/eslint-config not in package.json`

Add `@janus/eslint-config` as a dev dependency. See `standards/engineering/linting-standard.md`.

---

## Human-Only Checks

The following cannot be automated and are checked during CSA review:

1. ADRs are complete and reflect actual decisions made
2. Threat model covers the actual attack surface
3. Definition of Done criteria are appropriate for the service
4. Data privacy document accurately lists entities and classifications
5. Escalation matrix contacts are current and reachable

---

## Requesting a Waiver

If a check fails for a legitimate reason and compliance is not immediately achievable:

1. Open a Governance Exception Request using the `.github/ISSUE_TEMPLATE/governance-exception.md` template
2. Provide a specific, time-bounded remediation plan
3. Obtain CSA approval and Principal Architect approval
4. Waivers expire after 90 days and may be renewed once
5. A second renewal requires an RFC to the JAC

Waivers do not suspend the compliance check — the check will still fail, but the waiver is noted in the ecosystem compliance report.

---

## Upgrading to a New Suite Version

When a new janus-engineering suite version is released:

1. Review the CHANGELOG for changes that apply to your service
2. Update `.janus-compliance.yaml` to the new `janus-suite-version`
3. Apply any required standard changes within the grace period
4. Run the compliance check locally to verify
5. Open a `chore: upgrade JANUS suite to vX.Y.Z` PR
