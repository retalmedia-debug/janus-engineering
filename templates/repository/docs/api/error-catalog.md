<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/api/error-catalog.md -->

# Error Catalog

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

Error handling standard: `docs/operations/error-handling-standards.md`
JANUS error standard: `standards/operations/error-handling-standard.md` in `janus-engineering`

---

## Error Code Registry

All error codes for {{SERVICE_NAME}} are prefixed `{{SERVICE_ENV_PREFIX}}_`.

Error codes are **stable** — once defined and shipped, a code is never renamed or removed. Its meaning may be narrowed but not changed.

---

## Common Errors (All JANUS Services)

These error codes follow the JANUS standard and apply to all services:

| HTTP Status | Code | Description |
|---|---|---|
| 400 | `VALIDATION_FAILED` | Request body or parameters failed validation |
| 401 | `UNAUTHORIZED` | No valid authentication token |
| 403 | `FORBIDDEN` | Authenticated but not authorized for this resource |
| 404 | `NOT_FOUND` | Resource does not exist |
| 409 | `CONFLICT` | Resource state conflict (e.g., duplicate) |
| 422 | `UNPROCESSABLE_ENTITY` | Valid JSON but semantically invalid |
| 429 | `RATE_LIMITED` | Too many requests |
| 500 | `INTERNAL_ERROR` | Unexpected server error |
| 503 | `SERVICE_UNAVAILABLE` | Dependency unavailable |

---

## {{SERVICE_NAME}}-Specific Error Codes

[[FILL: Document all domain-specific error codes for this service. Each code must be unique across the entire JANUS ecosystem within its prefix. Use the prefix {{SERVICE_ENV_PREFIX}}_.]]

| HTTP Status | Code | When It Occurs | `details` Fields |
|---|---|---|---|
| [[FILL: 404]] | `{{SERVICE_ENV_PREFIX}}_[[FILL: ENTITY_NOT_FOUND]]` | [[FILL: When the requested entity does not exist]] | `{ "entityType": "...", "id": "..." }` |
| [[FILL: 409]] | `{{SERVICE_ENV_PREFIX}}_[[FILL: ENTITY_ALREADY_EXISTS]]` | [[FILL: When trying to create a duplicate]] | `{ "field": "...", "value": "..." }` |
| [[FILL]] | `{{SERVICE_ENV_PREFIX}}_[[FILL]]` | [[FILL]] | |

---

## Validation Error Format

For `VALIDATION_FAILED` (400) and `UNPROCESSABLE_ENTITY` (422), the `details` field contains field-level errors:

```json
{
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Request validation failed",
    "requestId": "uuid",
    "details": {
      "fields": [
        {
          "field": "email",
          "code": "INVALID_FORMAT",
          "message": "Must be a valid email address"
        }
      ]
    }
  }
}
```

---

## Deprecation Policy

Error codes are never deprecated — they are permanent. If a behavior changes such that a code no longer applies, the code may become unused but remains documented here with a `Deprecated:` note and the version it became unused.
