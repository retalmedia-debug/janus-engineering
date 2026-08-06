# Observability Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS services in production
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/operations/logging-standard.md` · `standards/operations/alerting-standard.md` · `standards/operations/runbook-standard.md` · `templates/repository/docs/operations/observability-strategy.md`

---

## Purpose

Observability is the ability to understand the internal state of a system by examining its outputs. A JANUS service is observable when an engineer who has never read its code can diagnose a production problem in under 30 minutes using only logs, metrics, and traces. This standard defines the minimum required outputs for all JANUS production services.

---

## The Three Pillars

All JANUS services must implement all three pillars before entering production:

| Pillar | Standard | Required? |
|---|---|---|
| **Logs** | `standards/operations/logging-standard.md` | Mandatory |
| **Metrics** | This document — Metrics section | Mandatory |
| **Traces** | This document — Tracing section | Mandatory |

No pillar may substitute for another. Metrics without logs hide context. Logs without traces cannot show request flows across services.

---

## Logs

Governed entirely by `standards/operations/logging-standard.md`. Key requirements:

- Structured JSON always
- Required fields: `timestamp`, `level`, `message`, `service`, `requestId`
- No PII, no credentials in log output
- `console.log` prohibited in production code

---

## Metrics

### Mandatory Metrics

Every JANUS service in production must expose the following metrics. The implementation mechanism (Prometheus, StatsD, Datadog, etc.) is a service-level ADR decision.

| Metric | Type | Labels | Description |
|---|---|---|---|
| `http_requests_total` | Counter | `method`, `path`, `status_code` | Total HTTP requests received |
| `http_request_duration_seconds` | Histogram | `method`, `path`, `status_code` | HTTP request latency (buckets: 0.01, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5) |
| `http_errors_total` | Counter | `method`, `path`, `error_code` | HTTP responses with 4xx/5xx status |
| `db_query_duration_seconds` | Histogram | `operation`, `table` | Database query latency |
| `dependency_call_duration_seconds` | Histogram | `service`, `endpoint` | Outbound call latency to external services |
| `dependency_errors_total` | Counter | `service`, `endpoint`, `error_type` | Failed outbound calls |

**Label conventions:**
- All label values use `snake_case`
- `path` values are templated — use `/users/{id}` not `/users/abc123` (prevents cardinality explosion)
- `error_code` uses the JANUS error code format (`SCREAMING_SNAKE_CASE`)

### Service-Specific Metrics

Services may define domain-specific metrics beyond the mandatory set. All custom metrics must:
- Be documented in `docs/operations/observability-strategy.md`
- Use the service's env prefix: `{{SERVICE_REPO}}_[metric_name]`
- Follow the same label conventions

### Metric Exposure

Metrics are exposed at `GET /metrics` (Prometheus format) or equivalent endpoint for the chosen monitoring platform. The `/metrics` endpoint must not require authentication but must be protected from public internet exposure (internal network only).

---

## Distributed Tracing

### Trace Propagation Contract

Every JANUS service that receives HTTP requests must:

1. **Extract** the `X-Request-ID` header from inbound requests, or generate a UUID v4 if absent
2. **Store** the `requestId` in the request context for the duration of the request lifecycle
3. **Include** `requestId` in every log line for the request
4. **Forward** `X-Request-ID` in all outbound HTTP calls to other JANUS services or external APIs
5. **Return** `X-Request-ID` in the HTTP response headers

This creates a correlation chain that spans services without requiring a distributed tracing SDK.

### OpenTelemetry (Recommended)

Services are encouraged to adopt OpenTelemetry for structured distributed tracing. When adopted:

- The trace ID from OpenTelemetry is used as the `requestId`
- Trace context propagation follows the W3C TraceContext standard (`traceparent` header)
- The service exports traces to the ecosystem's configured trace backend

OpenTelemetry adoption is Recommended (not yet Mandatory) and is logged in the service's ADR.

---

## Health Endpoints

Per `standards/security/containerization-standard.md` and JANUS API standards, every service must expose:

| Endpoint | Purpose | Response |
|---|---|---|
| `GET /health` | Liveness — is the process alive? | `{ "status": "ok" }` — 200 always if alive |
| `GET /ready` | Readiness — are all dependencies healthy? | `{ "status": "ready", "checks": [...] }` — 200 when ready, 503 when not |

The `/ready` response body should include dependency check details:

```json
{
  "status": "ready",
  "checks": [
    { "name": "database", "status": "ok" },
    { "name": "external-service-name", "status": "ok" }
  ]
}
```

On failure: `"status": "degraded"` with the failed check identified.

---

## Observability Documentation Requirement

Every service must maintain `docs/operations/observability-strategy.md` with:

- Chosen tooling for each pillar (logs, metrics, traces)
- Custom metrics beyond the mandatory set
- Alert thresholds and their rationale
- Dashboards (links or descriptions)
- Performance baselines once established

The observability strategy is reviewed as part of the pre-production checklist.

---

## Pre-Production Observability Gate

Before a service enters production:

- [ ] All 6 mandatory metrics are implemented and verified to emit
- [ ] Log output includes all required fields and excludes prohibited content
- [ ] `/health` and `/ready` endpoints verified working
- [ ] `X-Request-ID` propagation verified end-to-end
- [ ] At least one dashboard or monitoring view is configured
- [ ] All P0 and P1 alerts are configured per `standards/operations/alerting-standard.md`

---

## Rationale

The minimum mandatory metric set was chosen based on the USE Method (Utilization, Saturation, Errors) and RED Method (Rate, Errors, Duration) frameworks for service health monitoring. The tracing propagation contract via `X-Request-ID` was chosen over requiring a full distributed tracing SDK because it provides correlation capability without introducing a complex dependency on a tracing backend, which may not exist at early service stages.
