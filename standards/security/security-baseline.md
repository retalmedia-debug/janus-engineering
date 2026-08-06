# Security Baseline

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Security is a property of every decision in the development process, not a feature added at the end. This standard defines the minimum security requirements for all JANUS services. Services may exceed these requirements; they may not fall below them.

---

## Authentication

- All API endpoints require authentication unless explicitly documented as public
- JWT tokens are verified as the first operation before any business logic executes
- Access token maximum lifetime: 1 hour
- Refresh token maximum lifetime: 7 days
- JWTs are never stored in `localStorage` — use `HttpOnly` cookies or in-memory storage
- No service rolls its own JWT implementation — use the authentication platform decided by ADR
- Minimum password length: 12 characters (when password auth is used)
- MFA is required for all admin and operational accounts

---

## Authorization

- Authorization is enforced at the data layer, not only the API layer
- Users never supply their own user ID in request bodies — the authenticated identity is derived from the JWT
- The service role (or equivalent privileged credential) is never exposed client-side
- Rate limiting is applied before production launch — no exceptions
- No user can access another user's data without an explicit sharing or delegation model documented in an ADR

---

## Secret Management

No secret of any kind appears in source code, configuration files, environment example files, commit messages, PR descriptions, or log output.

The `.env.example` file documents the variable names and descriptions only — never real values.

**Rotation schedule:**

| Secret type | Rotation frequency |
|---|---|
| Database passwords | Quarterly |
| API keys (third-party) | Quarterly or on personnel change |
| JWT signing keys | Annually or on suspected compromise |
| Service-to-service tokens | Quarterly |
| Infrastructure credentials | Quarterly |

Rotations are zero-downtime. The rotation procedure is documented and tested before being needed.

---

## Input Validation

- All input from external sources (users, external APIs, webhooks) is validated at the service boundary
- No SQL interpolation — parameterized queries only
- Coordinate values are validated against valid ranges before processing:
  - Longitude: -180 to 180
  - Latitude: -90 to 90
- All JSON input is validated against a schema before use
- File uploads (if applicable) are validated for type, size, and content before storage

---

## Data Protection

- Data is encrypted at rest using the platform's default encryption (AES-256 or equivalent)
- All data in transit uses HTTPS with minimum TLS 1.2 (TLS 1.3 preferred)
- Data minimization: do not store data that is not needed for the service's operation
- PII classification is completed before any table receives production data
- No raw sensitive data appears in log output

---

## Dependency Security

- All dependencies are scanned for known CVEs in CI
- Critical and High severity CVEs are addressed within the windows defined in `standards/engineering/dependency-governance.md`
- Dependency scanning runs on every PR and every night on `main`

---

## Infrastructure Security

- The database is not directly accessible from the public internet
- Production database access is restricted to authorized engineers only
- Any direct production database access is logged and audited
- No standing production database access — access is request-based with a defined scope and duration
- Supabase service role keys are available only in server-side environments, never in client-side code

---

## Security Testing

- SAST (Static Application Security Testing) runs in CI on every PR
- Dependency vulnerability scanning runs in CI on every PR
- Before production launch, a security review covers: authentication flows, authorization model, secret handling, input validation, and data exposure
- Post-production: quarterly security scans of the production surface

---

## Incident Response

When a security incident is suspected or confirmed:
1. Notify the CSA immediately — do not wait for confirmation
2. Preserve evidence — do not delete, rotate, or alter anything before scope is understood
3. Isolate the affected system if the risk is active
4. Rotate all potentially compromised secrets only after the scope is understood (premature rotation destroys evidence)
5. Conduct a post-mortem within 72 hours of resolution

A security incident is never "resolved" without a post-mortem. Post-mortems are stored in `docs/operations/post-mortems/`.

---

## Production Launch Security Checklist

Before any JANUS service reaches production:

- [ ] Authentication is implemented and tested
- [ ] Authorization is enforced at the data layer
- [ ] All tables have RLS policies enabled and tested
- [ ] No secrets are in source code or committed files
- [ ] Rate limiting is configured
- [ ] Input validation is applied at all service boundaries
- [ ] All API endpoints require authentication (or are explicitly documented as public)
- [ ] Dependency CVE scan passes with no Critical or High open issues
- [ ] SAST scan passes with no Critical or High open findings
- [ ] TLS is enforced on all endpoints
- [ ] Database is not publicly accessible
- [ ] Service role keys are server-side only
- [ ] Logging does not emit PII or secrets
- [ ] The threat model has been reviewed against the implemented system
- [ ] MFA is enabled on all production operational accounts
