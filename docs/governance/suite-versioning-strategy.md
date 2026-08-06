# Suite Versioning Strategy

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06
**Ecosystem ADR:** [ADR-T001](../../adr/internal/ADR-T001-standards-suite-versioning.md)

---

## Version Semantics

The standards suite uses Semantic Versioning: `MAJOR.MINOR.PATCH`

| Component | When it bumps |
|---|---|
| `PATCH` | Typo fixes, clarification with no behavioral change, code example updates |
| `MINOR` | New standard added, new template added, additive change to existing standard or template |
| `MAJOR` | Breaking change to a `Mandatory` standard (changes required behavior), deprecation of a previously `Mandatory` standard, removal of a template |

The current version lives in the `VERSION` file. It is the single source of truth.

---

## Release Process

```
1. Changes are implemented via PR
2. The PR updates VERSION and CHANGELOG.md
3. PR is merged to main after JAC review
4. CI creates an annotated git tag: v<MAJOR>.<MINOR>.<PATCH>
5. CI runs notify-services.yml — creates GitHub Issues in all registered service repos
6. Services adopt the new version on their own schedule within grace periods
```

Tags are created by CI, not manually. This prevents version tagging before the PR is merged.

---

## How Services Declare Compliance

Each service declares its target suite version in `.janus-compliance.yaml`:

```yaml
janus_engineering_suite_version: "1.0.0"
```

This is the version the service's governance was written against. When the service upgrades to a new suite version, this field is updated in a `chore: upgrade to janus-engineering@1.1.0` PR.

The compliance check (`validate-compliance.sh`) reads this field to know which mandatory requirements to enforce.

---

## Grace Periods

After a MINOR or MAJOR suite release, services have a grace period to adopt the changes:
- MINOR: 60 days from release date
- MAJOR: 90 days from release date

During the grace period:
- Services are notified via the GitHub Issue created by `notify-services.yml`
- The previous version's requirements remain valid for services still on the old version
- The compliance check uses the version declared in `.janus-compliance.yaml` — services are not penalized for being on an older version within the grace period

After the grace period, the compliance check flags services that have not updated past the change.

---

## Suite Cadence

| Release type | Expected frequency |
|---|---|
| PATCH | As needed — typically within days of a typo report or clarification request |
| MINOR | Quarterly — batched additions and improvements |
| MAJOR | Annually at most — breaking changes are expensive for all services and should be rare |

MINOR releases are intentionally batched (quarterly rather than per-change) to reduce the notification load on service teams. PATCH releases are unblocked — they ship as soon as the correction is ready.

---

## Rollback

Suite version tags are never deleted. If a released version contains an error:
1. A new PATCH release corrects the error
2. The incorrect version remains tagged and accessible for historical reference
3. Service teams on the incorrect version are notified to upgrade to the corrected PATCH

Rolling back a suite release by deleting its tag would create inconsistency between services that had already adopted it and those that had not.
