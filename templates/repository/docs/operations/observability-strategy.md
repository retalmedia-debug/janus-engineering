<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/operations/observability-strategy.md -->

# Observability Strategy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Three Pillars

| Pillar | Tool | Status |
|---|---|---|
| Logs | [[FILL: e.g., Structured JSON → Supabase Logflare / Datadog]] | [[FILL: Implemented / Planned]] |
| Metrics | [[FILL: e.g., Prometheus / Datadog / None yet]] | [[FILL]] |
| Traces | [[FILL: e.g., OpenTelemetry → Honeycomb / None yet]] | [[FILL]] |

---

## Logging

Standard: `standards/operations/logging-standard.md` in `janus-engineering`
Service detail: `docs/operations/logging-standards.md`

All logs are structured JSON. The `service` field value for {{SERVICE_NAME}} is:
`"{{SERVICE_REPO}}"` — registered in `janus-engineering/services/registry.yaml`

---

## Metrics

[[FILL: Define the key metrics for this service. Every service should have at minimum an error rate and a latency metric.]]

| Metric | Type | Description | Alert Threshold |
|---|---|---|---|
| `{{SERVICE_ENV_PREFIX}}_error_rate` | Gauge | % of requests returning 5xx | [[FILL: e.g., > 1% over 5 min]] |
| `{{SERVICE_ENV_PREFIX}}_p99_latency_ms` | Histogram | 99th percentile response time | [[FILL: e.g., > 2000ms]] |
| `[[FILL]]` | | | |

**Performance baselines** (established in production, not pre-launch):
- P99 latency target: [[FILL: ms]]
- Error rate target: [[FILL: %]]

A >20% regression from baseline blocks release (JANUS long-term maintenance standard).

---

## Health Check Endpoints

Per JANUS containerization standard:

| Endpoint | Purpose | Response |
|---|---|---|
| `GET /health` | Liveness check | `{ "status": "ok" }` — always 200 if process is alive |
| `GET /ready` | Readiness check | `{ "status": "ready" }` — 200 when all dependencies are healthy; 503 otherwise |

---

## Alerting

[[FILL: Describe the alerting setup. Who gets paged? What tool? What are the alert conditions?]]

| Alert | Condition | Recipient | Channel |
|---|---|---|---|
| Service down | `/health` fails 3 times in 60s | {{SERVICE_CSA}} | [[FILL: PagerDuty / Slack]] |
| High error rate | Error rate > [[FILL: %]] | {{SERVICE_CSA}} | [[FILL]] |
| [[FILL]] | | | |

---

## Runbook Reference

Incident runbook: `docs/operations/incident-response-runbook.md`
