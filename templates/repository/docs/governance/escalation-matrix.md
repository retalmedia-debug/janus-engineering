<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/escalation-matrix.md -->

# Escalation Matrix

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Escalation Categories

### Production Incident (P0 — Service Down or Data Loss)

| Step | Action | Who | Timeline |
|---|---|---|---|
| 1 | Declare incident, open incident channel | First responder | Immediate |
| 2 | Notify CSA | First responder | < 5 minutes |
| 3 | CSA notifies Principal Architect | CSA | < 15 minutes |
| 4 | Communication to stakeholders | CSA | < 30 minutes |
| 5 | Post-mortem scheduled | CSA | Within 48 hours |

### Critical Bug (P1 — Major Functionality Broken)

| Step | Action | Who | Timeline |
|---|---|---|---|
| 1 | Open P1 issue with `[P1]` label | Reporter | Immediate |
| 2 | CSA assigns to engineer | CSA | < 2 hours |
| 3 | Fix deployed | Assignee | < 24 hours |

### Governance Dispute

| Scenario | First Escalation | Second Escalation |
|---|---|---|
| Standards interpretation | CSA → Principal Architect | JAC disposition |
| Waiver denial | CSA re-evaluates → Principal Architect | JAC vote |
| ADR disagreement | Team discussion → CSA decision | If blocked: RFC to JAC |

### Security Incident

Immediately notify:
1. {{SERVICE_CSA}}
2. JANUS Security Lead
3. JANUS Principal Architect

Do not post details in Slack. Use a private incident channel.

---

## Service Contacts

| Role | Name | Contact |
|---|---|---|
| Chief Software Architect | {{SERVICE_CSA}} | [[FILL: email or Slack handle]] |
| Technical Lead | [[FILL]] | [[FILL]] |
| JANUS Principal Architect | [[FILL]] | [[FILL]] |
| Security Lead | [[FILL]] | [[FILL]] |
| On-call rotation | [[FILL: PagerDuty / Opsgenie / etc.]] | [[FILL: link]] |

---

## Out-of-Hours Escalation

[[FILL: Describe the on-call rotation or out-of-hours contact protocol. If none, state "{{SERVICE_NAME}} does not currently have an on-call rotation. P0 incidents should be escalated via [method]."]]
