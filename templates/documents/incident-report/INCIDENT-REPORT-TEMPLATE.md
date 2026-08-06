<!-- Open this as a GitHub Issue during an active incident. -->
<!-- Policy: docs/governance/incident-management-policy.md in janus-engineering -->
<!-- Post-incident: file a Post-Mortem using templates/documents/post-mortem/POST-MORTEM-TEMPLATE.md -->

# [P0/P1] [Service]: Brief Incident Description

**Severity:** P0 | P1 | P2 | P3
**Service:** [Service Name]
**Status:** 🔴 ACTIVE | 🟡 INVESTIGATING | 🟢 MONITORING | ✅ RESOLVED
**Incident Commander:** [Name]
**Declared:** YYYY-MM-DD HH:MM UTC

---

## Current Status

[Update this section in real time during the incident. Most recent update at the top.]

**[HH:MM UTC]** — [Status update]
**[HH:MM UTC]** — [Previous update]

---

## Impact

**What is failing:** [What service or feature is unavailable or degraded]
**User impact:** [Who is affected and how — estimate count if possible]
**Severity justification:** [Why this is classified P0 / P1 / P2 / P3]

---

## Initial Hypothesis

[What is the suspected root cause? This will be wrong — update as investigation proceeds. Fill in as soon as a hypothesis exists.]

---

## Diagnostic Steps Taken

[Log of what has been checked, what was found, and what it ruled in or out.]

- `[HH:MM]` Checked `/health` endpoint — [result]
- `[HH:MM]` Reviewed last 50 error logs — [finding]
- `[HH:MM]` [Other step] — [finding]

---

## Actions Taken

[Log of changes made during the incident. Include who made the change and when.]

- `[HH:MM]` [Name] — [Action taken, e.g., "Restarted service instance"]
- `[HH:MM]` [Name] — [Rollback deployed to v1.2.3]

---

## Communication Log

| Time (UTC) | Channel | Message |
|---|---|---|
| HH:MM | [Slack / Email / etc.] | [Summary of what was communicated] |

---

## Resolution

**Resolved at:** YYYY-MM-DD HH:MM UTC
**Total duration:** [N hours N minutes]
**Resolution summary:** [What was done to resolve the incident]
**All-clear confirmed by:** [Name]

---

## Next Steps

- [ ] Post-mortem scheduled for: YYYY-MM-DD
- [ ] Runbook updated (if needed)
- [ ] Alert thresholds reviewed (if detection was slow)
- [ ] Stakeholders notified of resolution
