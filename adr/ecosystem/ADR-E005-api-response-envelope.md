# ADR-E005: Unified API Response Envelope

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect
**Services Impacted:** All services that expose REST APIs
**Migration Lead Time Required:** Immediate
**Grace Period:** N/A

---

## Context

The JANUS ecosystem consists of multiple services, each with their own APIs. Services within the ecosystem consume each other's APIs. Future frontends may consume multiple JANUS service APIs in a single application. The engineering cost of learning a different response format for each service is real — it must be paid every time an engineer integrates with a new JANUS service, and every time an integration is debugged.

A unified response envelope means that an engineer who has worked with one JANUS API already knows how to parse and handle responses from all other JANUS APIs.

---

## Decision

All JANUS REST API responses use the following envelope structure.

**Success — single resource:**
```json
{
  "data": { ... }
}
```

**Success — collection:**
```json
{
  "data": [ ... ],
  "pagination": {
    "page": 1,
    "pageSize": 20,
    "total": 143,
    "totalPages": 8
  }
}
```

**Error:**
```json
{
  "error": {
    "code": "SCREAMING_SNAKE_CASE_ERROR_CODE",
    "message": "Human-readable description ending in a period.",
    "requestId": "uuid",
    "details": { }
  }
}
```

---

## Rationale

The envelope structure is chosen to:

1. **Separate the payload from the metadata.** `data` contains the resource. `pagination` contains traversal metadata. `error` contains error context. Each concern is namespaced.

2. **Make errors machine-readable.** The `code` field is a stable, `SCREAMING_SNAKE_CASE` string that callers can switch on. The `message` is for humans and may change between versions. This separation allows callers to handle errors programmatically without depending on string matching of human-readable messages.

3. **Include `requestId` in every error.** A support conversation about a production error is only actionable if the error can be traced in logs. `requestId` makes that possible.

4. **Provide future extension points.** The `details` field in errors allows structured additional context (e.g., field-level validation errors) without changing the top-level envelope.

---

## Consequences

**Positive:**
- Engineers integrating multiple JANUS services encounter the same response format everywhere
- Error handling libraries can be shared between services and frontends
- `requestId` in errors enables log correlation across all JANUS services
- The envelope structure is simple enough to be implemented without a library

**Negative / Trade-offs:**
- Services cannot return "bare" resource objects — all responses must be wrapped
- The `data` key adds one level of nesting compared to a bare response

**Non-negotiable aspects:**
- The top-level keys (`data`, `pagination`, `error`) are fixed
- The `error.code` field is always `SCREAMING_SNAKE_CASE`
- The `error.requestId` field is always present in error responses
- The `error.message` field is always a complete human-readable sentence

**Extension:**
Services may add fields alongside `data` in success responses (e.g., `meta`, `links`) without an RFC, as long as they do not conflict with the reserved keys (`data`, `pagination`, `error`). Adding a new top-level key to error responses requires an RFC.
