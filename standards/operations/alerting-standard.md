# Alerting Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS services in production
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/operations/logging-standard.md` · `standards/security/security-baseline.md` · `templates/repository/docs/operations/observability-strategy.md`

---

## Purpose

Unmonitored services fail silently. This standard ensures every JANUS production service has a minimum alerting baseline that can detect failures before users report them, with clear ownership and response expectations.

---

## Mandatory Alerts (All Production Services)

Every JANUS service in production must have these alerts configured before the first production deployment:

| Alert | Condition | Severity | Response SLA |
|---|---|---|---|
| Service liveness failure | `/health` returns non-200 for 3 consecutive checks within 60s | P0 | Immediate (24/7) |
| Service readiness failure | `/ready` returns non-200 for 5 consecutive checks within 2 min | P1 | < 2 hours |
| Error rate spike | 5xx error rate > 1% over 5 minutes | P1 | < 2 hours |
| High latency | P99 response time > 2× the established baseline for 5 minutes | P1 | < 2 hours |
| Dependency failure | External service calls failing > 50% over 2 minutes | P1 | < 2 hours |
| Security event | Authentication failure rate > 10× baseline over 5 minutes | P0 | Immediate (24/7) |
| Disk/memory pressure | > 85% utilization for > 10 minutes | P2 | < 24 hours |

**Baseline establishment:** Baselines (error rate, latency) must be measured from the first 30 days of production operation and documented in `docs/operations/observability-strategy.md`. A service may not enter production with zero baselines — use conservative initial thresholds until real baselines are established.

---

## Alert Severity Definitions

| Severity | Definition | On-Call Required? | SLA |
|---|---|---|---|
| **P0** | Complete service outage or data integrity risk | Yes (24/7) | Page immediately |
| **P1** | Significant functionality degraded; users impacted | Yes (business hours; after-hours if severe) | < 2 hours |
| **P2** | Minor degradation; workaround exists | No (business hours) | < 24 hours |
| **P3** | Trending toward a problem; no current user impact | No | Next sprint |

---

## Alert Quality Requirements

### Every alert must have:

1. **A description** — What does this alert mean? What happened?
2. **A runbook link** — Where does the responder go to diagnose and remediate?
3. **An owner** — Which service's on-call is responsible?
4. **A severity** — P0 / P1 / P2 / P3
5. **A firing condition** — Specific threshold and duration (not just "high error rate")
6. **A recovery condition** — When does the alert clear?

### Prohibited alert behaviors:

- **Noisy alerts** — Alerts that fire more than once per week without producing action must be tuned or removed
- **Actionless alerts** — Every alert must have a documented response. If you don't know what to do when it fires, it should not be an alert.
- **Alert storms** — A single failure must not trigger more than 3 distinct alerts. Use alert grouping.
- **Alert suppression as a workaround** — If alerts are suppressed for > 48 hours, a P2 issue must be opened to address the root cause

---

## Notification Routing

| Severity | Channel | Notes |
|---|---|---|
| P0 | PagerDuty / Opsgenie (or equivalent) + Slack | Must wake someone up |
| P1 | PagerDuty / Opsgenie (business hours) + Slack | Escalate if no acknowledgment in 30 min |
| P2 | Slack + email | Daily digest acceptable |
| P3 | Slack | Weekly digest acceptable |

Each service must document its notification routing in `docs/operations/observability-strategy.md`.

---

## Runbook Requirement

Every P0 and P1 alert must have a corresponding runbook section in `docs/operations/incident-response-runbook.md`. The runbook section must:

1. State the alert name and what it means
2. Provide initial diagnostic steps (what to check first)
3. Provide remediation steps for the most common causes
4. Specify the escalation path if first responder cannot resolve
5. Define the "all clear" condition

---

## Alert Review Cadence

| Review Type | Frequency | Owner |
|---|---|---|
| Alert audit (are all mandatory alerts configured?) | Monthly | CSA |
| Noise review (which alerts are firing without action?) | Monthly | CSA |
| Threshold review (are thresholds still appropriate?) | Quarterly | CSA |
| Runbook review (are runbook steps still accurate?) | Quarterly | CSA + Tech Lead |

---

## Pre-Production Gate

No service may enter production until the following checklist is complete:

- [ ] All 7 mandatory alerts are configured
- [ ] All P0 and P1 alerts have runbook entries
- [ ] Notification routing is configured and tested (test alert received)
- [ ] On-call rotation is established with at least 2 people
- [ ] Initial baselines documented (or conservative initial thresholds justified)

This checklist is part of the release gate in `docs/governance/quality-gates.md`.
