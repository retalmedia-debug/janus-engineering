# Runbook Standard

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Status:** Active
**Binding Level:** Mandatory
**Applies To:** All JANUS services in production
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `standards/operations/alerting-standard.md` · `standards/operations/logging-standard.md` · `templates/repository/docs/operations/incident-response-runbook.md`

---

## Purpose

A runbook is a structured response guide for a specific operational condition. This standard ensures runbooks are actionable, maintained, and discoverable — not aspirational documents that rot between incidents.

---

## Runbook Types

| Type | Trigger | Location |
|---|---|---|
| **Alert Runbook** | A specific alert fires | `docs/operations/incident-response-runbook.md` |
| **Scheduled Operation** | A task that runs on a calendar (e.g., key rotation, capacity review) | `docs/operations/incident-response-runbook.md` |
| **Break-Glass Procedure** | An extreme event (data recovery, emergency access) | `docs/operations/incident-response-runbook.md` + restricted access |

---

## Alert Runbook Format

Every P0 and P1 alert must have a corresponding runbook section:

```markdown
## Alert: [Alert Name]

**Severity:** P0 | P1
**Alert Condition:** [Exact condition that fires this alert]
**Service:** [Service name]
**On-Call Owner:** [Role or team]

### What This Means

[One paragraph: what is failing, what is the likely user impact, why this alert exists]

### Initial Diagnosis (do these first — takes < 5 minutes)

1. Check the `/health` endpoint: `curl https://[service-url]/health`
2. Check the `/ready` endpoint: `curl https://[service-url]/ready`
3. Review the last 50 error logs: [log query or command]
4. [Service-specific quick check]

### Common Causes and Remediation

#### Cause: [Most common root cause]
[Diagnostic steps] → [Remediation steps]

#### Cause: [Second most common root cause]
[Diagnostic steps] → [Remediation steps]

### Escalation

If not resolved within [N minutes]:
1. [Escalation step]
2. Contact [Role]: [contact method]

### All Clear Condition

[Specific condition that indicates the incident is resolved and the alert will clear]

### Post-Incident

- [ ] Incident issue opened with `[P0]` or `[P1]` label
- [ ] Stakeholders notified of resolution
- [ ] Post-mortem scheduled (P0 only — within 48 hours)
```

---

## Runbook Quality Requirements

A runbook is **not compliant** if it:

- Contains steps that require knowledge not available at 2 AM to a responder who didn't build the system
- References tooling that is not documented (how to install it, what credentials are needed)
- Has steps that haven't been tested in the past 6 months
- Refers to people by name without providing a backup contact
- Says "investigate logs" without specifying which logs and how to access them

A runbook is **compliant** if:

- A new engineer could follow it without knowing the service internals
- Every tool referenced has an installation path or known-available assumption
- Every command includes the expected output for the successful case
- The escalation path specifies a role, not just a person name (roles persist; people change)

---

## Runbook Freshness Policy

| Event | Action |
|---|---|
| Alert is modified | Update corresponding runbook within the same PR |
| Infrastructure changes (new DB, new service endpoint) | Update runbook within 5 business days |
| Incident occurs | Validate and update runbook within 24 hours of post-mortem |
| Quarterly review | CSA audits all runbooks against current system state |
| Runbook not updated in > 6 months | CSA must explicitly re-verify and re-date, or flag as outdated |

A runbook that has not been reviewed in > 6 months is marked `[STALE]` in the document header. Stale runbooks are treated as P2 debt items.

---

## Scheduled Operation Runbook Format

For non-alert operational procedures (e.g., certificate rotation, backup verification):

```markdown
## Operation: [Operation Name]

**Frequency:** [Daily / Weekly / Monthly / Quarterly / On demand]
**Owner:** [Role]
**Estimated Duration:** [N minutes]
**Last Performed:** YYYY-MM-DD
**Next Scheduled:** YYYY-MM-DD

### Prerequisites

- [Tool or access required]
- [Expected pre-condition]

### Steps

1. [Step with expected output]
2. [Step with expected output]
3. Verify: [how to verify success]

### On Failure

[What to do if the operation fails]

### Completion Checklist

- [ ] [Verification step]
- [ ] [Notification step — who to notify that this was done]
```

---

## Rationale

Runbooks that are written once and never maintained are worse than no runbooks — they create false confidence. The freshness policy, audit cadence, and quality requirements in this standard are calibrated to keep runbooks as a living operational asset rather than historical documentation.
