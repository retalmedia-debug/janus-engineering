<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/ecosystem-integration.md -->

# Ecosystem Integration

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

Ecosystem integration principles: `standards/architecture/engineering-principles.md` in `janus-engineering`
Ecosystem map: `docs/ecosystem-map.md` in `janus-engineering`

---

## {{SERVICE_NAME}}'s Position in the JANUS Ecosystem

[[FILL: 2-3 sentences. What does this service provide to the ecosystem? What does it depend on? What is its integration contract?]]

---

## Outbound Integrations (Services This Service Calls)

[[FILL: List each service or external system this service calls. If none currently, state that explicitly.]]

### [[FILL: Service or System Name]]

| Field | Value |
|---|---|
| Type | [[FILL: JANUS service / External API / Managed service]] |
| Protocol | [[FILL: REST / Webhook / Event / SDK]] |
| Purpose | [[FILL: What does this service get from it?]] |
| Contract | [[FILL: Link to OpenAPI spec or event schema]] |
| Pinned version | [[FILL: API version or SDK version]] |
| Failure behavior | [[FILL: How does this service handle an outage of this dependency?]] |
| Timeout | [[FILL: Timeout value]] |
| Retry policy | [[FILL: Max retries, backoff strategy]] |

---

## Inbound Integrations (Services That Call This Service)

[[FILL: List each service that calls this service's API or consumes its events. If none, state explicitly.]]

### [[FILL: Consumer Service Name]]

| Field | Value |
|---|---|
| What they consume | [[FILL: Which endpoints or events]] |
| Contract | [[FILL: Link to OpenAPI spec or event schema]] |
| SLA provided | [[FILL: Uptime / latency commitment]] |
| Breaking change notice | [[FILL: How much notice is given before a breaking change]] |

---

## Integration Principles Applied

Per JANUS ecosystem standards, this service:

1. Integrates through published contracts — never through shared databases
2. Handles dependency failures gracefully (circuit breaker, timeout, fallback)
3. Propagates `X-Request-ID` headers on all outbound calls
4. Pins the version of every external API it consumes
5. Documents any deviation from these principles as an ADR

---

## Future Integration Points

[[FILL: If there are planned integrations not yet implemented, list them here with expected timeline. If none, remove this section.]]
