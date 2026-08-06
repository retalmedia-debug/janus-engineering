<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/domain-model.md -->

# Domain Model

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Domain Overview

[[FILL: 2-4 sentences describing the domain this service owns. What real-world concepts does it model? What are its boundaries — what explicitly does it NOT model?]]

**Domain boundary:** {{SERVICE_NAME}} owns [[FILL: what it owns]]. It does NOT own [[FILL: what it explicitly does not own — important for preventing scope creep]].

---

## Core Entities

[[FILL: Document each primary entity in this domain. An entity is a concept with identity that persists over time. Use the format below for each.]]

### [[FILL: Entity Name]]

**What it represents:** [[FILL: One sentence definition.]]

**Key attributes:**

| Attribute | Type | Description |
|---|---|---|
| `id` | UUID | Primary identifier |
| `[[FILL]]` | `[[FILL: string / number / boolean / timestamp]]` | [[FILL: description]] |
| `created_at` | Timestamp (ISO 8601 UTC ms) | Creation time |
| `updated_at` | Timestamp (ISO 8601 UTC ms) | Last modification time |

**Business rules:**

- [[FILL: Rule 1 — e.g., "An entity may not be deleted if it has active references"]]
- [[FILL: Rule 2]]

---

## Value Objects

[[FILL: Document value objects — concepts defined by their attributes, not identity. Examples: coordinates, time ranges, monetary amounts.]]

### [[FILL: Value Object Name]]

**What it represents:** [[FILL]]
**Attributes:** [[FILL]]
**Validation rules:** [[FILL]]

---

## Relationships

[[FILL: Describe how entities relate to each other. ASCII diagram preferred.]]

```
[[FILL: Entity A]] ──── 1:N ──── [[FILL: Entity B]]
[[FILL: Entity B]] ──── M:N ──── [[FILL: Entity C]]
```

---

## Ubiquitous Language

Terms used consistently across code, documentation, and communication for this domain:

| Term | Definition |
|---|---|
| [[FILL]] | [[FILL]] |

Do not use synonyms for these terms in code or documentation. If a term is ambiguous, clarify in this table.
