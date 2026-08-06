<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/operations/incident-response-runbook.md -->

# Incident Response Runbook

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

Escalation contacts: `docs/governance/escalation-matrix.md`

---

## Incident Severity Definitions

| Severity | Definition | Response SLA |
|---|---|---|
| P0 — Critical | Service down or data loss in production | Immediate (24/7) |
| P1 — Major | Core functionality broken, significant user impact | < 2 hours |
| P2 — Moderate | Degraded performance or partial functionality loss | < 24 hours |
| P3 — Minor | Minor issue, workaround available | Next sprint |

---

## Incident Response Steps

### 1. Detect

- Monitoring alert fires, or
- User report received, or
- Anomaly spotted in logs or metrics

### 2. Assess

- Determine severity (P0–P3)
- Identify affected functionality and users
- Check: `GET /health` and `GET /ready` endpoints

### 3. Declare (P0/P1 only)

- Open an incident issue: `[P0] Description of incident`
- Notify contacts per `docs/governance/escalation-matrix.md`
- Do NOT post technical details in public channels

### 4. Contain

- Consider: can affected functionality be disabled via feature flag?
- Consider: is rollback to previous version faster than a fix?
- Rollback procedure: `docs/governance/release-strategy.md` → Rollback Procedure

### 5. Resolve

- Identify root cause before declaring resolved
- Deploy fix or confirm rollback is stable
- Update status communication to stakeholders

### 6. Post-Mortem (P0/P1 required)

Post-mortem must be completed within 48 hours of resolution:

- Timeline of events
- Root cause (not "human error" — find the systemic cause)
- Detection gap (why did this not alert sooner?)
- Fix applied
- Follow-up actions (each with owner and due date)

---

## Common Runbooks

### Database Connectivity Issue

```
1. Check /ready endpoint — reports database health
2. Check Supabase dashboard / database logs
3. Verify environment variables are set correctly
4. Check for migrations that may have failed
5. Escalate to CSA if not resolved in 15 minutes
```

### Authentication Service Unavailable

```
1. Check external auth provider status page
2. Verify JWT secret has not been rotated without service restart
3. Check token expiry and clock skew
4. Escalate to CSA
```

### [[FILL: Service-Specific Runbook]]

[[FILL: Add runbook steps for the most common failure modes specific to this service's domain and tech stack.]]

```
1. [[FILL]]
2. [[FILL]]
```

---

## Post-Incident Actions Tracking

All follow-up actions from post-mortems are tracked as GitHub Issues with the label `post-mortem-action` and assigned to a named owner with a due date.
