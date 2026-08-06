<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/api/api-governance.md -->

# API Governance

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS API standard: `standards/api/api-design-standard.md` in `janus-engineering`
Error catalog: `docs/api/error-catalog.md`

---

## API Type

[[FILL: REST / GraphQL / WebSocket / Internal only. If this service has no external API, state that explicitly.]]

---

## OpenAPI Specification

**Spec location:** [[FILL: docs/api/openapi.yaml or openapi.json]]
**Spec version:** OpenAPI 3.1.0 (JANUS standard)

The specification is the contract. Implementation follows the spec — the spec does not follow the implementation. The spec must exist before implementation begins.

---

## Base URL

| Environment | Base URL |
|---|---|
| Local | `http://localhost:[[FILL: port]]/api/v[[FILL: version]]` |
| Staging | `[[FILL: staging URL]]/api/v[[FILL: version]]` |
| Production | `[[FILL: production URL]]/api/v[[FILL: version]]` |

---

## Versioning

Current API version: **v[[FILL: 1]]**

Breaking changes require a new API version (v2, v3, etc.). The previous version must remain supported for [[FILL: 6 months / 1 year / duration]] after a new version is released.

See `docs/governance/versioning-strategy.md` for the breaking change definition.

---

## Authentication

[[FILL: Describe how API consumers authenticate. Example: "All endpoints except /health and /ready require a valid JWT Bearer token in the Authorization header. Tokens are issued by Supabase Auth."]]

---

## Rate Limiting

| Tier | Rate Limit | Notes |
|---|---|---|
| Unauthenticated | [[FILL: e.g., 60 req/min per IP]] | |
| Authenticated | [[FILL: e.g., 1000 req/min per user]] | |
| Admin | [[FILL: e.g., 5000 req/min]] | |

Rate limit headers are returned in all responses:
- `X-RateLimit-Limit`
- `X-RateLimit-Remaining`
- `X-RateLimit-Reset`

---

## Backward Compatibility Commitment

Per JANUS API standard, {{SERVICE_NAME}} commits to:

- Existing fields will not be removed from response bodies
- Existing fields will not change their type
- New optional fields may be added to responses at any time
- New optional query parameters may be added at any time
- HTTP method and URL path changes are always MAJOR breaking changes

---

## Service-Specific API Rules

[[FILL: Document any API conventions specific to this service. Examples:
- Pagination style (cursor-based vs. offset)
- File upload conventions
- Webhook conventions and retry behavior
- Specific response fields added to the JANUS envelope
If none, remove this section.]]
