<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/operations/error-handling-standards.md -->

# Error Handling Standards

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS error handling standard: `standards/operations/error-handling-standard.md` in `janus-engineering`
Error code catalog: `docs/api/error-catalog.md`

---

## Error Envelope (JANUS Standard)

All HTTP API errors return this structure:

```json
{
  "error": {
    "code": "SCREAMING_SNAKE_CASE",
    "message": "Human-readable description",
    "requestId": "uuid-v4",
    "details": {}
  }
}
```

`message` is safe for end users. `code` is machine-readable. `details` contains field-level validation errors when applicable.

---

## Error Class Hierarchy for {{SERVICE_NAME}}

[[FILL: List the error classes used in this service. Extend from a base ServiceError class.]]

```typescript
// Base — all errors extend this
class {{SERVICE_NAME}}Error extends Error {
  constructor(
    public readonly code: string,
    message: string,
    public readonly statusCode: number,
    public readonly details?: Record<string, unknown>
  ) { super(message) }
}

// Examples — replace with actual error classes for this service:
class NotFoundError extends {{SERVICE_NAME}}Error { /* 404 */ }
class ValidationError extends {{SERVICE_NAME}}Error { /* 422 */ }
class UnauthorizedError extends {{SERVICE_NAME}}Error { /* 401 */ }
class ForbiddenError extends {{SERVICE_NAME}}Error { /* 403 */ }
class ConflictError extends {{SERVICE_NAME}}Error { /* 409 */ }
class ServiceUnavailableError extends {{SERVICE_NAME}}Error { /* 503 */ }
```

---

## Error Code Naming

All error codes for this service are prefixed with `{{SERVICE_ENV_PREFIX}}_`.

Examples: `{{SERVICE_ENV_PREFIX}}_NOT_FOUND`, `{{SERVICE_ENV_PREFIX}}_VALIDATION_FAILED`

Full catalog: `docs/api/error-catalog.md`

---

## Rules

- Never swallow errors silently — every caught error must be logged or re-thrown
- Never expose stack traces in API responses
- Never expose database error messages or SQL directly
- Error codes are stable across releases — existing codes are never renamed
- Adding a new error code does not require a MAJOR version bump (it is additive)
- Changing the meaning of an existing error code is a MAJOR breaking change

---

## External API Error Handling

When calling external services or JANUS sibling services:

- Timeout: 30 seconds maximum
- Retries: 3 attempts with exponential backoff (1s, 2s, 4s)
- On final failure: throw `ServiceUnavailableError` — never propagate the raw upstream error
- Log the upstream error (with `requestId`) before wrapping it
