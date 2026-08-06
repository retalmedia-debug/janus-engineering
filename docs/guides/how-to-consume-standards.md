# How to Consume Standards

**Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## The Three Consumption Mechanisms

JANUS services consume `janus-engineering` through three distinct mechanisms. Each mechanism governs a different type of content.

---

## Mechanism 1 — Standards (Reference)

Standards in `standards/` are **referenced**, not copied.

In a service's governance document, reference the applicable standard:

```markdown
This document is governed by the JANUS Engineering Standard:
[Dependency Governance](https://github.com/janus/janus-engineering/blob/v1.0.0/standards/engineering/dependency-governance.md)
Suite version: janus-engineering@1.0.0
```

The `v1.0.0` in the URL pins the reference to the version the service declared in `.janus-compliance.yaml`. When the service upgrades its suite version, these references are updated.

**Why reference, not copy?**
A copied standard drifts. When `janus-engineering` updates the standard, the copy in the service is not updated. The service team no longer knows whether they are following the current standard or a stale copy. Reference keeps the relationship explicit.

---

## Mechanism 2 — Templates (Copy at Creation)

Templates in `templates/` are **copied** at service creation time via `scaffold-service.sh`.

After copying:
- The service **owns** the document
- `janus-engineering` does not push template updates to the service
- The service team fills in `{{PLACEHOLDER}}` values and resolves `[[FILL:]]` markers
- The template origin is recorded in a metadata comment at the top of each copied file

**After scaffolding, the service team's responsibility:**
- Resolve all `[[FILL:]]` sections before marking the document `Active`
- Resolve all `[[DECISION REQUIRED:]]` sections before the corresponding Phase gate closes
- Reference the correct JANUS standard URL in the governance document's header

**When a template is updated in janus-engineering:**
The service team receives a notification via GitHub Issue when the suite version bumps. The notification identifies which template changed and provides the diff. The service team reviews and applies the relevant changes to their document during the grace period.

The `check-standards-drift.sh` script identifies which copied documents use a template from an older suite version.

---

## Mechanism 3 — Tooling (npm Package Dependency)

Tooling configurations are consumed as **versioned npm packages** under the `@janus` scope.

**`package.json` setup:**
```json
{
  "devDependencies": {
    "@janus/eslint-config": "1.0.0",
    "@janus/tsconfig": "1.0.0",
    "@janus/prettier-config": "1.0.0",
    "@janus/commitlint-config": "1.0.0"
  }
}
```

**ESLint (`eslint.config.mjs`):**
```javascript
import janusConfig from '@janus/eslint-config'
export default [...janusConfig]
```

**TypeScript (`tsconfig.json`):**
```json
{ "extends": "@janus/tsconfig/base.json" }
```

**Prettier (`.prettierrc.json`):**
```json
"@janus/prettier-config"
```

**Commitlint (`commitlint.config.js`):**
```javascript
export default { extends: ['@janus/commitlint-config'] }
```

**Upgrading tooling:**
Tooling is upgraded via a standard `chore(deps): upgrade @janus tooling to 1.1.0` PR. Dependabot/Renovate can be configured to automatically create these PRs when new versions are published.

---

## Declaring Your Suite Version

Every service declares its target suite version in `.janus-compliance.yaml`:

```yaml
janus_engineering_suite_version: "1.0.0"
service_name: "VENUS"
service_repo: "venus-v1"
created_date: "2026-08-06"
csa: "Engineer Name"
compliance_exceptions: []
mandatory_only_check: false
```

---

## Upgrading to a New Suite Version

When `janus-engineering` releases a new MINOR or MAJOR version:

1. You receive a GitHub Issue in your repository via `notify-services.yml`
2. Read the CHANGELOG entry and the linked RFC or ADR for context on what changed
3. Open an upgrade PR in your service repository:
   - Update `.janus-compliance.yaml` `janus_engineering_suite_version`
   - Update standard reference URLs in governance documents where the standard changed
   - Apply any template changes relevant to your service
   - Update `@janus` npm package versions in `package.json`
4. Run `validate-compliance.sh` locally to verify the upgrade
5. Run `check-standards-drift.sh` to identify any remaining stale template references
6. Merge the upgrade PR: `chore: upgrade to janus-engineering@1.1.0`

Upgrade PRs are scoped: one PR per suite version upgrade. Do not combine with feature work.

---

## CLAUDE.md Responsibility

Your service's `CLAUDE.md` must contain a section that tells Claude Code where to find the applicable standards:

```markdown
## JANUS Standards Reference

This service targets: janus-engineering@1.0.0

Binding standards:
- Engineering: https://github.com/janus/janus-engineering/blob/v1.0.0/standards/engineering/
- Architecture: https://github.com/janus/janus-engineering/blob/v1.0.0/standards/architecture/
- Security: https://github.com/janus/janus-engineering/blob/v1.0.0/standards/security/
- Operations: https://github.com/janus/janus-engineering/blob/v1.0.0/standards/operations/
- AI Collaboration: https://github.com/janus/janus-engineering/blob/v1.0.0/standards/ai-collaboration/

When a question arises that this CLAUDE.md does not answer, consult the applicable JANUS standard
before making assumptions. If the standard does not address the question, raise it via the RFC
process in janus-engineering.
```

This ensures Claude Code at the service level operates within the correct ecosystem constraints.
