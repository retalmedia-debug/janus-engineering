<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/api/event-catalog.md -->

# Event Catalog

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS event schema standard: `standards/api/event-schema-standard.md` in `janus-engineering`

---

## Overview

This catalog documents all events published by {{SERVICE_NAME}}. All events use the JANUS CloudEvents v1.0 envelope.

**Publisher identifier:** `{{SERVICE_REPO}}` (used in the `source` field)

[[FILL: If this service does not publish events, add: "{{SERVICE_NAME}} does not publish events. It consumes events from [services] — see docs/architecture/ecosystem-integration.md." and remove the rest of this document.]]

---

## Event Registry

| Event Type | Trigger | Consumers | Schema Version |
|---|---|---|---|
| `janus.{{SERVICE_REPO}}.[[FILL: entity]].[[FILL: verb]]` | [[FILL: trigger]] | [[FILL: consumers or "TBD"]] | `1.0` |

---

## Event Definitions

### `janus.{{SERVICE_REPO}}.[[FILL: entity]].[[FILL: verb]]`

**What it represents:** [[FILL: What happened in the domain that triggered this event]]
**Trigger:** [[FILL: Specific action or condition that causes this event to be produced]]
**Produced by:** {{SERVICE_NAME}}
**Consumers:** [[FILL: List known consumers, or "TBD"]]
**Delivery guarantee:** [[FILL: At-least-once / At-most-once — depends on your event infrastructure]]
**Ordering guarantee:** [[FILL: Ordered per [entity] / Unordered]]

#### Envelope

```json
{
  "specversion": "1.0",
  "id": "uuid-v4",
  "source": "janus/{{SERVICE_REPO}}/[[FILL: domain]]",
  "type": "janus.{{SERVICE_REPO}}.[[FILL: entity]].[[FILL: verb]]",
  "time": "2026-08-06T14:23:01.123Z",
  "datacontenttype": "application/json",
  "correlationid": "uuid-v4",
  "suiteversion": "{{JANUS_SUITE_VERSION}}",
  "data": {
    [[FILL: data fields — see payload schema below]]
  }
}
```

#### Payload Schema

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `string` (UUID v4) | Yes | Unique identifier for the domain entity involved |
| `[[FILL]]` | `[[FILL: string / number / boolean]]` | Yes / No | [[FILL: description]] |

#### Example

```json
{
  "specversion": "1.0",
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "source": "janus/{{SERVICE_REPO}}/[[FILL: domain]]",
  "type": "janus.{{SERVICE_REPO}}.[[FILL: entity]].[[FILL: verb]]",
  "time": "2026-08-06T14:23:01.123Z",
  "datacontenttype": "application/json",
  "correlationid": "f1e2d3c4-b5a6-7890-1234-abcdef567890",
  "suiteversion": "{{JANUS_SUITE_VERSION}}",
  "data": {
    "id": "entity-uuid-here",
    [[FILL: example field values]]
  }
}
```

---

## Schema Versioning

When a breaking change is required to an event's `data` payload:

1. Create a new event type: `janus.{{SERVICE_REPO}}.[[FILL: entity]].[[FILL: verb]].v2`
2. Continue publishing the old type for minimum 90 days (MAJOR grace period)
3. Update this catalog with both versions and the sunset date for the old version

Non-breaking additions (new optional fields in `data`) do not require a new version. Consumers must tolerate unknown fields.
