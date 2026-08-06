# API Design Standard

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06
**Ecosystem ADR:** [ADR-E005](../../adr/ecosystem/ADR-E005-api-response-envelope.md)

---

## Purpose

APIs are contracts between a service and its consumers. A consistent API design across the JANUS ecosystem means developers working with multiple JANUS services encounter the same patterns, the same response structures, and the same conventions. Consistency reduces integration cost and prevents a class of bugs that arise from per-service variations.

This standard defines the design rules for all JANUS REST APIs. Realtime, webhook, and internal data access patterns are governed by service-specific documentation.

---

## URL Design

- Paths are lowercase, hyphen-separated words: `/api/v1/geofence-alerts`
- Collections are plural nouns: `/api/v1/geofences`, `/api/v1/alerts`, `/api/v1/users`
- Individual resources are identified by path parameter: `/api/v1/geofences/{id}`
- Nested resources reflect ownership: `/api/v1/geofences/{id}/alerts`
- Actions that do not map to CRUD use verb-based paths: `/api/v1/geofences/{id}/activate`
- Query parameters are camelCase: `?pageSize=20&sortBy=createdAt&order=desc`
- No trailing slashes
- No file extensions in paths

---

## HTTP Methods

| Method | Semantics | Body | Idempotent |
|---|---|---|---|
| `GET` | Retrieve a resource or collection | None | Yes |
| `POST` | Create a resource or trigger an action | Resource or action parameters | No |
| `PUT` | Replace a resource entirely | Full resource representation | Yes |
| `PATCH` | Partially update a resource | Changed fields only | No |
| `DELETE` | Remove a resource | None | Yes |

`POST` is used for operations that do not fit the CRUD model (e.g., `POST /api/v1/geofences/{id}/activate`).

---

## HTTP Status Codes

| Code | When |
|---|---|
| `200 OK` | Successful GET, PUT, PATCH |
| `201 Created` | Successful POST that created a resource. Include `Location` header. |
| `204 No Content` | Successful DELETE, or POST with no response body |
| `400 Bad Request` | Malformed request or validation failure |
| `401 Unauthorized` | Missing or invalid authentication |
| `403 Forbidden` | Authenticated but not authorized for this operation |
| `404 Not Found` | Resource does not exist |
| `409 Conflict` | Resource state conflict (e.g., duplicate unique field) |
| `422 Unprocessable Entity` | Business rule violation |
| `429 Too Many Requests` | Rate limit exceeded. Include `Retry-After` header. |
| `500 Internal Server Error` | Unexpected server error |
| `503 Service Unavailable` | Upstream dependency unavailable |

---

## Request Bodies

- All request bodies are JSON
- `Content-Type: application/json` is required on all requests with a body
- Field names are camelCase
- Required fields are documented in the OpenAPI specification
- Unknown fields in the request body are silently ignored (not rejected)
- No `null` values for required fields — absence means omission, not explicit null

---

## Response Bodies

### Success — Single Resource

```json
{
  "data": {
    "id": "uuid",
    "name": "Resource Name",
    "createdAt": "2026-08-06T14:30:00.000Z",
    "updatedAt": "2026-08-06T14:30:00.000Z"
  }
}
```

### Success — Collection

```json
{
  "data": [
    { "id": "uuid", "name": "Item One" },
    { "id": "uuid", "name": "Item Two" }
  ],
  "pagination": {
    "page": 1,
    "pageSize": 20,
    "total": 143,
    "totalPages": 8
  }
}
```

### Error

See `standards/operations/error-handling-standard.md`.

---

## Pagination

All collection endpoints support pagination. Default parameters:
- `page` — 1-based page number, default `1`
- `pageSize` — items per page, default `20`, maximum `100`

The response always includes the `pagination` object even when all results fit on one page.

Cursor-based pagination is preferred for time-series or high-volume collections. When cursor pagination is used, the response includes `nextCursor` instead of `totalPages`.

---

## Timestamps

All timestamps are ISO 8601 strings in UTC with millisecond precision:
```
"2026-08-06T14:30:00.000Z"
```

- No Unix timestamps in the API
- No timestamps without timezone offset
- The `Z` suffix is required (UTC)

---

## Geographic Data

All geographic data is represented in [GeoJSON (RFC 7946)](https://datatracker.ietf.org/doc/html/rfc7946) format.

**Coordinate order is `[longitude, latitude]`** — not latitude-longitude. This is GeoJSON spec. It is a common source of bugs. Every code path that handles coordinates must document the axis order explicitly.

```json
{
  "type": "Point",
  "coordinates": [13.404954, 52.520008]
}
```

Services that do not deal with geographic data may omit this section from their API governance documents.

---

## API Versioning

JANUS services use URL path versioning: `/api/v1/`, `/api/v2/`

Version strategy is chosen because the version is visible in every request without header inspection and routes can be directed to different implementations transparently.

**Breaking changes require a new version.** A breaking change is any change that causes an existing client to fail without code modifications:
- Removing a field from a response
- Changing a field's type
- Removing an endpoint
- Changing an endpoint's URL structure
- Changing the meaning of a field

**Non-breaking changes do not require a new version:**
- Adding a new optional field to a response
- Adding a new endpoint
- Adding a new optional query parameter

**Version support lifecycle:**

| State | Meaning |
|---|---|
| `Current` | Actively supported. New features may be added. |
| `Maintenance` | No new features. Security fixes only. |
| `Deprecated` | Sunset announced. Consumers must migrate. Include `Deprecation` response header. |
| `Retired` | No longer available. |

Minimum support period after deprecation announcement: **6 months**. No version is retired without confirming all known consumers have migrated.

---

## Authentication

All endpoints require authentication via JWT Bearer token unless explicitly documented as public:

```
Authorization: Bearer <jwt-token>
```

JWT verification is the first operation in every request handler, before any business logic.

Public endpoints (if any) are explicitly documented in the service's OpenAPI specification with `security: []`. The default assumption for any endpoint is that it requires authentication.

---

## Rate Limiting

Rate limits are applied before production launch. All JANUS services define their rate limits in their `docs/api/api-governance.md`. The JANUS ecosystem minimum:

| Category | Limit | Window |
|---|---|---|
| Authenticated endpoints | 1000 requests | Per minute per user |
| Unauthenticated endpoints | 100 requests | Per minute per IP |

Rate limit exceeded responses use status `429` with a `Retry-After` header.

---

## API Documentation

Every endpoint is documented in OpenAPI 3.1.0 specification **before it is implemented**.

The specification is the contract. The implementation must match the specification — not the other way around. When implementation and specification diverge, the specification is authoritative.

Each endpoint's specification includes:
- HTTP method and path
- Description of purpose and behavior
- All parameters (path, query, header) with types and constraints
- Request body schema
- All response schemas by status code
- Authentication requirement
- Rate limiting behavior

The OpenAPI specification is maintained in the service repository at `docs/api/openapi.yaml`.

---

## Backward Compatibility Commitment

When an API version is `Current` or `Maintenance`:
- No breaking changes are made under any circumstances
- Any change that could break a client is reviewed by the CSA before implementation
- When uncertain whether a change is breaking, treat it as breaking and create a new version

Breaking this commitment is an incident. It requires a post-mortem and a migration path for all affected consumers.
