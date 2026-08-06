<!-- Copy this file to docs/[service]/post-mortems/YYYY-MM-DD-[title].md after an incident. -->
<!-- Post-mortem policy: docs/governance/incident-management-policy.md in janus-engineering -->

# Post-Mortem: [Incident Title]

**Service:** [Service Name]
**Incident Severity:** P0 | P1
**Incident ID:** [GitHub Issue link]
**Date of Incident:** YYYY-MM-DD
**Date of Post-Mortem:** YYYY-MM-DD
**Incident Commander:** [Name / Role]
**Participants:** [Names / Roles of everyone who participated in the post-mortem]
**Status:** Draft | Final

---

## Incident Summary

[One paragraph. What failed, how long it lasted, what the user impact was. No root cause here — just what happened from the outside.]

**Duration:** From [HH:MM UTC] to [HH:MM UTC] on YYYY-MM-DD ([N hours N minutes])
**Users affected:** [Estimate or measure]
**Revenue/business impact:** [Estimate if known; "unknown" is acceptable]

---

## Timeline

All times in UTC.

| Time | Event |
|---|---|
| HH:MM | [First signal of the problem — alert, user report, etc.] |
| HH:MM | [Incident declared] |
| HH:MM | [Initial hypothesis] |
| HH:MM | [Key diagnostic finding] |
| HH:MM | [Mitigation applied] |
| HH:MM | [Service recovered] |
| HH:MM | [All clear declared] |

---

## Root Cause

[A specific, technical description of the root cause. "Human error" is never a root cause — humans make errors; systems must tolerate them. The root cause is the condition that allowed the human error (or system failure) to cause the incident.

Apply the "5 Whys" to get to the systemic root cause:
- Why did X fail? Because Y
- Why did Y happen? Because Z
- Why did Z happen? ...

Continue until you reach something actionable — a process gap, a missing check, a design flaw.]

**Root cause statement:** [One sentence that completes: "The incident occurred because..."]

---

## Contributing Factors

[Other conditions that made the incident worse or harder to detect/resolve. These are not the root cause but are worth addressing.]

1. [Factor 1]
2. [Factor 2]

---

## Detection

**How was the incident detected?**
[ ] Monitoring alert
[ ] User report
[ ] Internal discovery
[ ] External reporter

**MTTD (Mean Time to Detect):** [Time from first signal to incident declared]

**Detection gap:** [Could this have been detected faster? What was missing or slow?]

---

## Response Analysis

**What went well:**

- [Something that worked as expected during the incident]
- [A runbook step that was effective]

**What could have been better:**

- [A gap in the response process]
- [A decision that was made with incomplete information]
- [A tool or resource that was not available when needed]

---

## Action Items

Each action item must have an owner and a due date. All items are tracked as GitHub issues with the `post-mortem-action` label.

| # | Action | Owner | Due Date | Issue |
|---|---|---|---|---|
| 1 | [Specific preventive action] | [Role or name] | YYYY-MM-DD | [#issue] |
| 2 | [Detection improvement] | [Role or name] | YYYY-MM-DD | [#issue] |
| 3 | [Runbook update] | [Role or name] | YYYY-MM-DD | [#issue] |

**Minimum required action items:**
- At least one item addressing the root cause (not just symptoms)
- At least one item improving detection if MTTD > 10 minutes
- Runbook update if the runbook was absent or incomplete

---

## Standards or Template Gaps

[Did this incident reveal a gap in JANUS Engineering Standards or templates?

If yes: File an RFC or open a GitHub Issue in `janus-engineering` and link it here.
If no: State "No ecosystem-level gaps identified."]

---

## Lessons Learned

[Key insights from this incident that would not be obvious from the action items alone. Future engineers and teams should learn from this without needing to re-read the full incident.]

1. [Lesson 1]
2. [Lesson 2]
