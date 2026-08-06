<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/data-privacy.md -->

# Data Privacy

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Data Classification Framework

| Class | Definition | Examples |
|---|---|---|
| **Public** | Intentionally public; no sensitivity | Published documentation, public API schemas |
| **Internal** | Not public but not sensitive | System logs (no PII), configuration |
| **Confidential** | Sensitive business or operational data | User data, access logs, API keys |
| **Restricted** | Highest sensitivity; strict controls | Credentials, PII, government-classified data |

---

## Data Entities in {{SERVICE_NAME}}

[[FILL: List the data entities this service owns or processes. For each, identify its classification and where it is stored.]]

| Entity | Classification | Storage | Notes |
|---|---|---|---|
| [[FILL: e.g., User profile]] | [[FILL: Confidential]] | [[FILL: Supabase users table]] | [[FILL: Contains PII]] |
| [[FILL]] | | | |

---

## PII Handling Rules

1. PII must never appear in logs (use `requestId` for tracing, never user identifiers)
2. PII must never be sent to third-party analytics or monitoring tools without explicit consent and DPA
3. PII at rest must be encrypted
4. PII in transit must be TLS 1.2 minimum
5. PII must be deletable on user request (right to erasure)

---

## Data Retention

| Data Type | Retention Period | Delete Mechanism |
|---|---|---|
| [[FILL: Application logs]] | [[FILL: 30 days]] | [[FILL: Automated log rotation]] |
| [[FILL: User data]] | [[FILL: Duration of account + 30 days]] | [[FILL: Soft delete + purge job]] |
| [[FILL: Audit logs]] | [[FILL: 1 year]] | [[FILL: Archival after 90 days]] |

---

## Third-Party Data Sharing

[[FILL: List any third-party services that receive data from this service. For each: what data, why, and what agreement governs it.]]

| Service | Data Shared | Purpose | Agreement |
|---|---|---|---|
| [[FILL]] | [[FILL]] | [[FILL]] | [[FILL: DPA / ToS]] |

If no third-party data sharing: state explicitly "{{SERVICE_NAME}} does not share data with third-party services."

---

## Incident Response

If a data breach or unauthorized access is suspected:

1. Immediately notify {{SERVICE_CSA}}
2. CSA notifies JANUS Principal Architect and Security Lead within 1 hour
3. Follow `docs/security/security-baseline.md` incident response procedure
4. Document the incident timeline and impact
5. Regulatory notification requirements: [[FILL: GDPR 72-hour rule if applicable, or "not applicable"]]
