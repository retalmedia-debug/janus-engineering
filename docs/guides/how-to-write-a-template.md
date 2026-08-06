# How to Write a Template

**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## When to Create a Template

A template is warranted when:
- Every new JANUS service needs a version of this document
- The document has a predictable structure that can be generalized
- A blank page is a meaningful obstacle to getting it right

Templates are not summaries of standards — they are the starting point for service-specific documents. They must be filled out, not used as-is.

---

## Template Metadata Comment

Every template file must begin with a metadata comment identifying its origin:

```markdown
<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/path/to/template/file.md -->
```

This comment is copied with the file when `scaffold-service.sh` runs. The `check-standards-drift.sh` script uses it to detect when a service's copy is out of date with the current suite version.

The `{{JANUS_SUITE_VERSION}}` placeholder is substituted at scaffold time by `scaffold-service.sh`.

---

## Placeholder Conventions

Templates use two types of placeholder:

### `{{PLACEHOLDER}}` — Substitution Placeholders

Machine-substituted by `scaffold-service.sh` using `sed`. Do not invent new `{{}}` placeholders without adding them to `scaffold-service.sh`.

| Placeholder | Substituted With |
|---|---|
| `{{SERVICE_NAME}}` | Service display name (e.g., `ATLAS`) |
| `{{SERVICE_REPO}}` | Repository name (e.g., `atlas-v1`) |
| `{{SERVICE_DOMAIN}}` | Domain description |
| `{{SERVICE_CSA}}` | Chief Software Architect name |
| `{{SERVICE_ENV_PREFIX}}` | Environment variable prefix (e.g., `ATLAS`) |
| `{{JANUS_SUITE_VERSION}}` | Suite version at scaffold time |

### `[[FILL: description]]` — Human Fill Markers

Must be filled by a human during governance establishment. The description inside the brackets explains what to put there.

Examples:
- `[[FILL: YYYY-MM-DD]]` — A date the human must enter
- `[[FILL: Name of the CSA on the review team]]` — A specific piece of information
- `[[FILL: List the integration points for this service]]` — A section requiring domain knowledge

### `[[DECISION REQUIRED: description]]`

Marks a place where a significant choice must be made before the document is filed. Use this for decisions that require ADR-level consideration (not just filling in a value).

Example: `[[DECISION REQUIRED: Choose the authentication mechanism for this service — see ADR template in docs/architecture/adr/]]`

---

## What a Good Template Section Looks Like

A good template section:
1. Has the structure already defined — the human fills in values, not format
2. Has `[[FILL:]]` markers that are precise enough to guide without restricting judgment
3. Has examples where the format is non-obvious
4. Does not try to capture every possible service — handles the common case and leaves room for extensions

A bad template section:
1. Is entirely `[[FILL: everything]]` — provides no structure
2. Is entirely hardcoded — leaves no room for service-specific content
3. Is too long — better to link to the relevant standard than repeat it

---

## Template Categories

| Category | Location | Copied By |
|---|---|---|
| Repository scaffold (all files for a new service) | `templates/repository/` | `scaffold-service.sh` |
| Mid-lifecycle document additions | `templates/documents/` | Manual copy |
| GitHub workflow starters | `templates/github/workflows/` | Manual copy |

---

## Adding a New Template

1. Write the template file with the metadata comment and appropriate `{{PLACEHOLDER}}` and `[[FILL:]]` markers
2. Place it in the correct `templates/` subdirectory
3. If it uses `{{PLACEHOLDER}}` substitution, verify that `scaffold-service.sh` handles those placeholders
4. Add it to `templates/INDEX.md`
5. If it is part of the repository scaffold, add the path to `scaffold-service.sh`'s file list
6. Open a PR with a PATCH suite version bump (if it is a new template, it is additive)

---

## Template Maintenance

When a standard changes in a way that requires a template update:
- Update the template file
- Update the metadata comment version (the `{{JANUS_SUITE_VERSION}}` substitution handles this automatically at scaffold time, but the static comment at the top of existing templates shows the version they were created from)
- Document in CHANGELOG.md what changed
- The suite version bump associated with the standard change covers the template update — no separate bump required
- Services that have already scaffolded will see drift detected by `check-standards-drift.sh` on their next CI run
