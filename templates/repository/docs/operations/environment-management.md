<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/operations/environment-management.md -->

# Environment Management

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Environments

| Environment | Purpose | URL | Access | Deploy Trigger |
|---|---|---|---|---|
| `local` | Developer workstation | `http://localhost:[[FILL: port]]` | Developer only | Manual |
| `staging` | Integration testing, pre-release validation | [[FILL: staging URL or TBD]] | Internal team | Merge to `develop` |
| `production` | Live service | [[FILL: production URL or TBD]] | [[FILL: Public / Restricted]] | Tagged release |

---

## Environment Isolation Rules

- `production` data never appears in `local` or `staging`
- `staging` has its own isolated database — never shares with `production`
- Environment variables differ per environment — config is never copied between environments
- `staging` mimics `production` configuration as closely as possible (same feature flags, same limits)

---

## Local Development Setup

Prerequisites and setup steps: `docs/governance/onboarding.md`

Local services required:

| Service | How to Run | Notes |
|---|---|---|
| [[FILL: Database]] | [[FILL: supabase start]] | [[FILL: Runs on localhost:54321]] |
| [[FILL: Other service]] | [[FILL]] | [[FILL]] |

---

## Staging Environment

**Owner:** {{SERVICE_CSA}}
**Reset policy:** [[FILL: Seeded weekly / Reset per release / Never reset — explain]]
**Data:** Synthetic test data only — no production data

Staging is the integration gate before production. All releases must pass in staging before the production tag is created.

---

## Production Environment

**Owner:** {{SERVICE_CSA}}
**Platform:** [[FILL: Vercel / Supabase / AWS / etc.]]
**Region:** [[FILL: e.g., us-east-1]]
**Redundancy:** [[FILL: Single instance / Multi-region / etc.]]

Access to production is restricted to:
- {{SERVICE_CSA}}
- [[FILL: other named roles with production access]]

Production access is audited. Use of production access must be logged in the incident or change management system.

---

## Environment-Specific Feature Flags

[[FILL: If feature flags differ by environment, document the configuration here. If none, remove this section.]]

---

## Disaster Recovery

**Recovery Time Objective (RTO):** [[FILL: e.g., 4 hours]]
**Recovery Point Objective (RPO):** [[FILL: e.g., 1 hour]]
**Backup schedule:** [[FILL: e.g., Supabase automated backups daily]]
**Restore procedure:** [[FILL: Link to runbook or describe steps]]
