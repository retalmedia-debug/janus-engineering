<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/operations/logging-standards.md -->

# Logging Standards

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS logging standard: `standards/operations/logging-standard.md` in `janus-engineering`

---

## Service Registration

The `service` field in all log entries for {{SERVICE_NAME}} is:

```
"service": "{{SERVICE_REPO}}"
```

This value is registered in `janus-engineering/services/registry.yaml` and must not be changed without updating the registry.

---

## Required Log Fields (JANUS Standard)

| Field | Value |
|---|---|
| `timestamp` | ISO 8601 UTC with milliseconds — `2026-08-06T14:23:01.123Z` |
| `level` | `error` / `warn` / `info` / `debug` |
| `message` | Human-readable summary |
| `service` | `{{SERVICE_REPO}}` |
| `requestId` | UUID from `X-Request-ID` header |

---

## Service-Specific Log Fields

[[FILL: Define any additional fields this service includes in its structured logs. These must not conflict with the required fields above.]]

| Field | Type | When Present | Description |
|---|---|---|---|
| `[[FILL: e.g., userId]]` | `string` | When authenticated request | [[FILL: Opaque user identifier — not email or name]] |
| `[[FILL: e.g., operation]]` | `string` | Always | [[FILL: The domain operation being performed]] |

---

## Prohibited Content

Never log:
- Passwords, tokens, API keys, or any credential
- PII (names, emails, phone numbers, addresses)
- Full request bodies (log field names and types only, never values for sensitive fields)
- Full response bodies for auth endpoints

---

## Log Level Guidelines

| Level | When to Use |
|---|---|
| `error` | Unexpected failure that requires attention; unhandled exceptions |
| `warn` | Degraded operation; retryable failure; deprecated feature use |
| `info` | Significant lifecycle events: request received, auth success, domain operation completed |
| `debug` | Diagnostic detail; disabled in production by default |

Avoid noisy `info` logging — every `info` log should mean something to an operator.

---

## Request Tracing

Every inbound HTTP request must:
1. Read the `X-Request-ID` header (or generate a UUID if absent)
2. Attach the `requestId` to the request context
3. Include `requestId` in every log line for the duration of the request
4. Return the `requestId` in the response `X-Request-ID` header

Every outbound HTTP call to other services must forward `X-Request-ID`.
