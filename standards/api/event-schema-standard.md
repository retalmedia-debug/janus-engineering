# Event Schema Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory-if-applicable
**Applies To:** All JANUS services that produce or consume asynchronous events
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/api/api-design-standard.md` · `standards/operations/logging-standard.md` · `adr/ecosystem/ADR-E005-api-response-envelope.md`

---

## Purpose

Synchronous REST APIs are governed by `standards/api/api-design-standard.md`. This standard governs **asynchronous event payloads** — messages published to queues, event buses, webhooks, or any mechanism where producer and consumer are decoupled in time. Consistent event schemas prevent integration failures, enable downstream traceability, and make the ecosystem's event stream readable without service-specific knowledge.

---

## When This Standard Applies

This standard is **Mandatory-if-applicable** — it applies when:

- A service publishes events to an event bus, message queue, or webhook
- A service emits domain events consumed by other JANUS services
- A service publishes webhooks to external consumers

It does **not** apply to:
- Server-sent events (SSE) for real-time UI updates within a single service
- Internal in-process event emitters
- Log events (governed by `standards/operations/logging-standard.md`)

---

## Canonical Event Envelope

All JANUS events must conform to this envelope:

```json
{
  "specversion": "1.0",
  "id": "uuid-v4",
  "source": "janus/[service-identifier]/[domain]",
  "type": "janus.[service].[entity].[verb]",
  "time": "2026-08-06T14:23:01.123Z",
  "datacontenttype": "application/json",
  "correlationid": "uuid-v4",
  "suiteversion": "1.0.0",
  "data": { }
}
```

This envelope follows [CloudEvents v1.0](https://cloudevents.io/). The `data` field contains the event-specific payload.

---

## Envelope Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `specversion` | `string` | Yes | Always `"1.0"` — CloudEvents spec version |
| `id` | `string` (UUID v4) | Yes | Unique identifier for this event occurrence. Never reused. |
| `source` | `string` (URI) | Yes | Origin of the event. Format: `janus/[identifier]/[domain]` |
| `type` | `string` | Yes | Event type. See naming convention below. |
| `time` | `string` (ISO 8601 UTC ms) | Yes | Time the event was produced by the source |
| `datacontenttype` | `string` | Yes | Always `"application/json"` for JANUS events |
| `correlationid` | `string` (UUID v4) | Yes | The `requestId` or transaction ID that caused this event. Enables tracing across services. |
| `suiteversion` | `string` | Yes | The JANUS suite version under which this event schema was produced |
| `data` | `object` | Yes | Event-specific payload. See schema documentation requirements below. |

---

## Event Type Naming Convention

```
janus.[service-identifier].[entity].[verb]
```

All lowercase. Dot-separated. No underscores.

| Component | Description | Example |
|---|---|---|
| `janus` | Ecosystem prefix — always present | `janus` |
| `[service-identifier]` | From `services/registry.yaml` `identifier` field | `atlas`, `gcs`, `venus` |
| `[entity]` | The domain entity the event is about | `geofence`, `alert`, `session` |
| `[verb]` | Past tense — something that happened | `created`, `updated`, `deleted`, `triggered`, `expired` |

**Examples:**
- `janus.atlas.geofence.created`
- `janus.atlas.alert.triggered`
- `janus.gcs.session.expired`
- `janus.cronos.task.completed`

---

## Data Payload Rules

1. All fields in `data` use `camelCase` (consistent with REST API field naming)
2. All timestamps in `data` are ISO 8601 UTC with milliseconds
3. The `data` object must not contain the envelope fields — no `id`, `source`, or `type` duplication inside `data`
4. The `data` object must not contain secrets, credentials, passwords, or PII beyond what is minimally necessary for the consumer
5. IDs in `data` are UUID v4 strings — never numeric auto-increment IDs

---

## Schema Documentation Requirement

Every event type a service publishes must be documented before it is deployed:

```markdown
## Event: janus.[service].[entity].[verb]

**Produced by:** [Service Name]
**Consumed by:** [List of consuming services, or "TBD"]
**Trigger:** [What causes this event to be produced]
**Guarantees:** [At-least-once / At-most-once / Exactly-once — depends on infrastructure]
**Ordering:** [Ordered per entity / Unordered — depends on infrastructure]

### Data Payload

| Field | Type | Required | Description |
|---|---|---|---|
| ... | ... | ... | ... |

### Example

```json
{ "specversion": "1.0", "id": "...", ..., "data": { ... } }
```
```

Event documentation lives in `docs/api/event-catalog.md` within the producing service's repository.

---

## Versioning

Event schemas are versioned through the `type` field:

- **Backward-compatible additions** (new optional fields in `data`): No version change required; consumers must tolerate unknown fields
- **Breaking changes** (removed fields, changed types, changed semantics): New event type with a version suffix: `janus.atlas.geofence.created.v2`
- Old event types must continue to be published for the duration of the migration window (minimum 90 days for MAJOR changes)

---

## Consumer Rules

Event consumers must:

1. **Tolerate unknown fields** in `data` — do not fail on unrecognized fields
2. **Validate the `type` field** before processing — reject events of unexpected types
3. **Be idempotent** — the same event may be delivered more than once depending on infrastructure guarantees
4. **Forward the `correlationid`** in any downstream events or API calls triggered by the event

---

## Rationale

Adopting CloudEvents v1.0 as the envelope standard provides:
- A well-specified, vendor-neutral schema that is widely understood
- A consistent correlation mechanism across the ecosystem
- Future compatibility with CNCF-ecosystem tooling (Knative, KEDA, etc.)
- Unambiguous event typing that is human-readable without schema lookup
