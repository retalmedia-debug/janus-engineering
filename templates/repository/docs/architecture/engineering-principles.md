<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/engineering-principles.md -->

# Engineering Principles — {{SERVICE_NAME}}

**Version:** 1.0.0
**Status:** Draft
**Owner:** Chief Software Architect
**Last Reviewed:** {{DATE}}

---

## Universal Principles

{{SERVICE_NAME}} follows all 11 universal JANUS Engineering Principles defined in:
[Engineering Principles](https://github.com/janus/janus-engineering/blob/v{{JANUS_SUITE_VERSION}}/standards/architecture/engineering-principles.md)
Suite version: janus-engineering@{{JANUS_SUITE_VERSION}}

The universal principles are not repeated here. They are authoritative at the ecosystem level.

---

## Domain-Specific Principles

These principles extend the universal principles for the specific domain of {{SERVICE_NAME}}: {{SERVICE_DOMAIN}}.

Domain principles do not contradict universal principles. They narrow scope and provide domain-specific guidance that the universal principles cannot anticipate.

[[FILL: Author domain-specific principles below. Each principle follows this format:

### Principle N — [Principle Name]

[Statement of the principle]

**Applied:** [How this principle manifests in {{SERVICE_NAME}}'s specific implementation context]

Examples from existing JANUS services:
- "Geography is a First-Class Domain" (ATLAS) — every coordinate has a documented axis order; geospatial constraints are enforced at the database level, not only in application code
- If your service has no domain-specific principles yet, write: "No domain-specific principles have been identified at this stage of the service's lifecycle. This document is revisited with each Architecture phase review."
]]
