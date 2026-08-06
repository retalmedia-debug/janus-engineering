<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/security/threat-model.md -->

# Threat Model

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Draft
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Scope

This threat model covers the {{SERVICE_NAME}} service. It was produced using the STRIDE methodology.

**In scope:** [[FILL: What attack surfaces and data flows are modeled?]]
**Out of scope:** [[FILL: What is explicitly excluded? E.g., "Infrastructure provider security (AWS/Supabase), physical security"]]

---

## Assets

| Asset | Classification | Why It's Valuable to an Attacker |
|---|---|---|
| [[FILL: e.g., User credentials]] | Restricted | [[FILL: Can be used to impersonate users]] |
| [[FILL: e.g., Domain data]] | Confidential | [[FILL: Competitive intelligence value]] |
| [[FILL]] | | |

---

## Trust Boundaries

[[FILL: Describe the trust boundaries in this system. Where do untrusted inputs enter? What is trusted by design?]]

```
[Internet] → (TLS) → [API Gateway] → [{{SERVICE_NAME}} API] → [Database]
                                                ↑
                                          [Internal JANUS services]
```

---

## Threat Analysis (STRIDE)

For each significant threat, document:

| ID | Category | Threat | Asset | Likelihood | Impact | Mitigation | Status |
|---|---|---|---|---|---|---|---|
| T001 | Spoofing | [[FILL: Attacker forges authentication token]] | [[FILL: User sessions]] | [[FILL: Low/Med/High]] | [[FILL: High]] | [[FILL: JWT signature verification; short token lifetime]] | [[FILL: Mitigated]] |
| T002 | Tampering | [[FILL: Attacker modifies request payload]] | [[FILL: Domain data]] | | | [[FILL: Input validation with Zod; signed requests]] | |
| T003 | Repudiation | [[FILL: User denies performing an action]] | [[FILL: Audit log]] | | | [[FILL: Structured audit logging with requestId; immutable log store]] | |
| T004 | Information Disclosure | [[FILL: Error messages expose internals]] | [[FILL: System architecture]] | | | [[FILL: Error envelope standardization; never expose stack traces in production]] | |
| T005 | Denial of Service | [[FILL: Flood API with requests]] | [[FILL: Service availability]] | | | [[FILL: Rate limiting; API Gateway throttling]] | |
| T006 | Elevation of Privilege | [[FILL: User accesses another user's data]] | [[FILL: User data]] | | | [[FILL: Row Level Security; data-layer authorization checks]] | |

---

## Open Threats

[[FILL: List any threats that are identified but not yet mitigated. Each open threat requires a GitHub Issue with a security label.]]

| Threat ID | Issue | Target Date |
|---|---|---|
| [[FILL]] | [[FILL: #issue-number]] | [[FILL: YYYY-MM-DD]] |

---

## Review Schedule

This threat model is reviewed:
- Before the first production deployment
- When a new external integration is added
- When a significant architectural change is made
- Annually at minimum
