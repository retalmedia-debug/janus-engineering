<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/security/security-baseline.md -->

# Security Baseline

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS security standard: `standards/security/security-baseline.md` in `janus-engineering`

---

## JANUS Security Requirements Applied

All requirements from `standards/security/security-baseline.md` apply to this service. This document records how they are implemented here and adds service-specific controls.

---

## Authentication

| Requirement | Implementation |
|---|---|
| JWT-based authentication | [[FILL: Library/mechanism — e.g., Supabase Auth, custom JWT middleware]] |
| Access token lifetime | 1 hour (JANUS standard) |
| Refresh token lifetime | 7 days (JANUS standard) |
| Token storage | [[FILL: httpOnly cookie / server-side session — no localStorage]] |
| Password minimum | 12 characters (JANUS standard) |
| MFA for admin | [[FILL: Implemented / Not applicable — explain]] |

---

## Authorization

| Requirement | Implementation |
|---|---|
| Authorization enforcement layer | [[FILL: e.g., Row Level Security on Supabase / middleware / policy engine]] |
| Resource ownership verification | [[FILL: How is it verified that a user can access the specific resource?]] |
| Admin vs. user role separation | [[FILL: How are roles defined and enforced?]] |

---

## Secret Management

| Secret | Storage | Rotation Frequency |
|---|---|---|
| Database credentials | [[FILL: CI secrets / Secret manager]] | [[FILL: e.g., 90 days]] |
| [[FILL: API key for external service]] | [[FILL]] | [[FILL]] |
| JWT signing secret | [[FILL]] | [[FILL: e.g., 30 days]] |

No secrets are committed to the repository. Secrets are injected at runtime via environment variables.

---

## Input Validation

| Input Surface | Validation Approach |
|---|---|
| HTTP request bodies | [[FILL: e.g., Zod schema validation at route handler entry]] |
| Query parameters | [[FILL]] |
| Path parameters | [[FILL]] |
| File uploads (if applicable) | [[FILL: Type allowlist, size limit, content scanning]] |

---

## Service-Specific Security Controls

[[FILL: Document any security controls specific to this service's domain. Examples:
- Rate limiting configuration
- IP allowlisting
- Specific data sensitivity handling
- Third-party security integrations
If none, remove this section.]]

---

## Production Launch Security Checklist

Complete before first production deployment. See the full checklist in `standards/security/security-baseline.md` (15 items). Service-specific additions:

- [ ] [[FILL: Any service-specific pre-launch security item]]

---

## Security Incident Response

See `docs/governance/escalation-matrix.md` for incident contacts.
Process: `standards/security/security-baseline.md` → Incident Response section.
