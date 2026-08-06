# Error Handling Standard

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06
**Ecosystem ADR:** [ADR-E005](../../adr/ecosystem/ADR-E005-api-response-envelope.md)

---

## Purpose

Every JANUS service that exposes an API must return errors in the same format. A developer integrating multiple JANUS services must not learn multiple error formats. Consistency in error structure is a prerequisite for shared error-handling libraries and meaningful error display in any frontend that consumes JANUS APIs.

---

## Error Taxonomy

| Class | Meaning | Who is responsible |
|---|---|---|
| `Validation` | The request is malformed or contains invalid values | Caller |
| `Authorization` | The caller lacks permission to perform this operation | Caller (or auth configuration) |
| `NotFound` | The requested resource does not exist | Caller |
| `Conflict` | The operation conflicts with the current resource state | Caller |
| `Domain` | The operation violates a business rule | Caller |
| `Infrastructure` | A downstream dependency (database, external API) failed | Service |
| `Unknown` | An unexpected condition with no more specific classification | Service |

The error class determines the HTTP status code. The error code identifies the specific error. The error message is for humans.

---

## HTTP Status Code Mapping

| Error Class | HTTP Status |
|---|---|
| `Validation` | 400 Bad Request |
| `Authorization` (unauthenticated) | 401 Unauthorized |
| `Authorization` (authenticated, no permission) | 403 Forbidden |
| `NotFound` | 404 Not Found |
| `Conflict` | 409 Conflict |
| `Domain` | 422 Unprocessable Entity |
| `Infrastructure` | 503 Service Unavailable |
| `Unknown` | 500 Internal Server Error |

---

## Error Response Envelope

All API error responses use this structure:

```json
{
  "error": {
    "code": "SCREAMING_SNAKE_CASE_ERROR_CODE",
    "message": "Human-readable description of the error.",
    "requestId": "550e8400-e29b-41d4-a716-446655440000",
    "details": {}
  }
}
```

**Rules:**

- `code` is always `SCREAMING_SNAKE_CASE`. It identifies the specific error condition. It is machine-readable and stable — callers may switch on it.
- `message` is always a complete English sentence ending in a period. It is human-readable and may change between versions. Callers must not switch on `message` content.
- `requestId` is always present. It matches the `X-Request-ID` header returned in the response. It enables support and debugging.
- `details` is optional. When present, it contains structured additional context.

---

## Validation Error Details

Validation errors include field-level details:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request contains invalid values.",
    "requestId": "550e8400-e29b-41d4-a716-446655440000",
    "details": {
      "fields": [
        {
          "field": "coordinates.longitude",
          "code": "OUT_OF_RANGE",
          "message": "Longitude must be between -180 and 180."
        },
        {
          "field": "name",
          "code": "REQUIRED",
          "message": "Name is required."
        }
      ]
    }
  }
}
```

---

## Error Code Registry

Each service maintains an error code catalog in `docs/api/error-catalog.md`. The catalog lists every error code the service can return, its class, its HTTP status, and an example of when it occurs.

Error codes within a service must be unique. A code registered in the error catalog is never reused for a different error condition.

---

## Never Swallow Errors

```typescript
// Wrong — error is silently discarded
try {
  await doSomething()
} catch {
  return null
}

// Wrong — error is logged but not propagated
try {
  await doSomething()
} catch (error) {
  logger.error('Something failed', { error })
  return null
}

// Correct — error is logged, transformed to the appropriate error class, and propagated
try {
  await doSomething()
} catch (error) {
  logger.error('Something failed', {
    operation: 'do_something',
    errorCode: 'INFRASTRUCTURE_ERROR',
    requestId,
  })
  throw new InfrastructureError('INFRASTRUCTURE_ERROR', 'An upstream dependency failed.')
}
```

An operation that fails should fail visibly. The caller — whether a user, a consuming service, or an internal operation — needs to know the failure occurred and why.

---

## Error Class Hierarchy

Each service implements its own error class hierarchy. The base structure:

```typescript
class ServiceError extends Error {
  constructor(
    public readonly code: string,
    message: string,
    public readonly statusCode: number,
    public readonly details?: Record<string, unknown>,
  ) {
    super(message)
    this.name = this.constructor.name
  }
}

class ValidationError extends ServiceError {
  constructor(code: string, message: string, details?: Record<string, unknown>) {
    super(code, message, 400, details)
  }
}

class AuthorizationError extends ServiceError {
  constructor(code: string, message: string) {
    super(code, message, 403)
  }
}

class NotFoundError extends ServiceError {
  constructor(code: string, message: string) {
    super(code, message, 404)
  }
}

class DomainError extends ServiceError {
  constructor(code: string, message: string, details?: Record<string, unknown>) {
    super(code, message, 422, details)
  }
}

class InfrastructureError extends ServiceError {
  constructor(code: string, message: string) {
    super(code, message, 503)
  }
}
```

The service-specific class names are prefixed with the service name (e.g., `AtlasError`, `VenusError`).

---

## External API Error Handling

When calling external APIs, JANUS services:
- Apply a timeout (maximum 30 seconds for any external call)
- Retry with exponential backoff (maximum 3 retries, starting at 1 second)
- Classify the result as `InfrastructureError` on exhaustion
- Never propagate external API error details directly to callers — the external service's error messages may contain internal information that should not be exposed

Timeout and retry configuration is not hardcoded. It is configurable via environment variables documented in the service's `docs/operations/configuration-management.md`.

---

## Database Error Translation

Database errors are translated to the appropriate service error class before being returned to callers. PostgreSQL error codes are the input; `ServiceError` subclasses are the output.

| PostgreSQL Error Code | Translation |
|---|---|
| `23505` (unique_violation) | `ConflictError` |
| `23503` (foreign_key_violation) | `DomainError` |
| `23514` (check_violation) | `DomainError` |
| `42P01` (undefined_table) | `InfrastructureError` — this is a schema bug |
| `57014` (query_canceled) | `InfrastructureError` — timeout |
| Connection errors | `InfrastructureError` |

Raw PostgreSQL error messages and codes are never returned to API callers.
