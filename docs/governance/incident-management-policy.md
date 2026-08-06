# Ecosystem Incident Management Policy

**Classification:** [JES] JANUS Governance Document
**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/operations/alerting-standard.md` · `standards/operations/runbook-standard.md` · `templates/repository/docs/operations/incident-response-runbook.md` · `templates/documents/post-mortem/POST-MORTEM-TEMPLATE.md`

---

## Purpose

An incident is any unplanned event that degrades or threatens to degrade a JANUS service's availability, correctness, or security. This policy governs how incidents are detected, declared, communicated, resolved, and learned from across the ecosystem — not just within a single service.

---

## Severity Definitions

| Severity | Definition | Examples |
|---|---|---|
| **P0 — Critical** | Complete service outage, data loss or corruption, active security breach | Service returning 503 for all users; database corruption; credential exposure |
| **P1 — Major** | Core functionality unavailable for a significant user segment, or a security vulnerability with active risk | Core API endpoint failing for 20%+ of requests; RCE vulnerability discovered |
| **P2 — Moderate** | Degraded performance or partial functionality loss; workaround available | P99 latency 3× normal; non-critical feature returning errors |
| **P3 — Minor** | Cosmetic or low-impact issue with no meaningful user impact | Non-critical API returning unexpected empty response occasionally |

---

## Incident Declaration

### Who May Declare

Any engineer or on-call responder may declare an incident. When in doubt, declare — false positives are acceptable; undeclared incidents are not.

### How to Declare

1. Open a GitHub Issue in the affected service's repository:
   - Title: `[P0] [P1] [P2] Brief description`
   - Apply labels: `incident`, `p0` / `p1` / `p2` / `p3`
2. Post in the incident Slack channel with a link to the issue
3. Notify the CSA of the affected service (P0 and P1 only — immediately)

### Ecosystem-Level Incidents

An incident is **ecosystem-level** if it:
- Affects more than one JANUS service
- Is caused by a shared dependency (infrastructure, `janus-engineering` tooling, shared config)
- Has potential to cascade across services

For ecosystem-level incidents, the **JANUS Principal Architect is the Incident Commander**. Service CSAs report to the Principal Architect.

---

## Communication Requirements

### During a P0 Incident

| Milestone | Communication | Channel | Who |
|---|---|---|---|
| Declaration | "We have declared a P0 incident for [service]. Investigating now." | Incident channel + stakeholder channel | Incident Commander |
| T+15 minutes | Status update with initial findings | Incident channel | Incident Commander |
| T+30 minutes | Update and ETA or "still investigating" | Stakeholder channel | Incident Commander |
| Every 30 minutes thereafter | Status update until resolved | Incident channel | Incident Commander |
| Resolution | "P0 incident resolved. [Brief summary]. Post-mortem will follow." | All channels | Incident Commander |

Never go silent during a P0. Silence is interpreted as the incident worsening.

### During a P1 Incident

| Milestone | Communication | Who |
|---|---|---|
| Declaration | Notify CSA and post in incident channel | First responder |
| T+1 hour | Status update | Incident Commander |
| Resolution | Summary post in incident channel | Incident Commander |

---

## Resolution Requirements

An incident is resolved only when:

1. The symptom is eliminated (not just mitigated)
2. The root cause is identified (hypothesis is acceptable if confirmed by evidence)
3. The `/health` and `/ready` endpoints return 200
4. Monitoring confirms stable metrics for minimum 15 minutes
5. No active P0 or P1 alerts remain firing

"Monitoring for now" is not resolution. A resolved-but-monitoring state is a P2 incident.

---

## Post-Mortem Requirements

| Severity | Post-Mortem Required? | Deadline |
|---|---|---|
| P0 | Yes — mandatory | Within 48 hours of resolution |
| P1 | Yes — mandatory | Within 5 business days |
| P2 | Recommended if root cause is non-obvious | Within 1 sprint |
| P3 | Not required | — |

Post-mortems use the template in `templates/documents/post-mortem/POST-MORTEM-TEMPLATE.md`.

**Post-mortem rules:**
- Blameless — individuals are never the root cause; systems and processes are
- The "5 Whys" technique is applied to find the systemic root cause, not the proximate cause
- Every post-mortem produces at least one action item with an owner and due date
- Action items are tracked as GitHub issues with the `post-mortem-action` label
- Post-mortems are published to the service repository within the deadline

---

## Ecosystem Incident Review

The JAC reviews P0 and ecosystem-level post-mortems within 14 days of publication. The review determines:

- Whether the incident reveals a gap in `janus-engineering` standards or templates
- Whether cross-service coordination improvements are needed
- Whether the ecosystem-level alerting or escalation process needs improvement

JAC findings are filed as RFCs if they require standards changes.

---

## Incident Metrics

The JAC tracks quarterly across all services:

| Metric | Definition |
|---|---|
| MTTD | Mean Time to Detect (alert fires to incident declared) |
| MTTF | Mean Time to Fix (incident declared to resolved) |
| Incident frequency by severity | Count of P0, P1, P2 incidents per quarter |
| Post-mortem on-time rate | % of P0/P1 post-mortems filed within deadline |
| Action item completion rate | % of post-mortem actions completed within their due date |

Services with MTTF > 4 hours for P0 or recurring P1 incidents in the same area trigger a mandatory architectural review.
