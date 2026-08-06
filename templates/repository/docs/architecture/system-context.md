<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/system-context.md -->

# System Context

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

C4 Level 1: System Context diagram for {{SERVICE_NAME}}.

---

## Context Diagram

[[FILL: Replace the placeholder diagram below with one that accurately represents the system context. Users → System → Dependencies pattern.]]

```
                    ┌─────────────────────────────────────┐
                    │                                     │
  [[FILL: User]]    │          {{SERVICE_NAME}}           │    [[FILL: External Service]]
  [[FILL: role]] ──►│     [[FILL: brief description]]     │──► [[FILL: what it calls]]
                    │                                     │
                    └─────────────────────────────────────┘
                                      │
                                      │
                                      ▼
                          [[FILL: Dependency Service]]
                          [[FILL: e.g., Supabase, ATLAS]]
```

---

## Users / Actors

| Actor | Description | How They Interact |
|---|---|---|
| [[FILL: e.g., Platform Operator]] | [[FILL: who they are]] | [[FILL: how they use the system]] |
| [[FILL]] | | |

---

## External Systems

| System | Type | Purpose | Owner |
|---|---|---|---|
| [[FILL: e.g., Supabase]] | [[FILL: Managed DB]] | [[FILL: Primary data store]] | [[FILL: Platform team / Supabase Inc.]] |
| [[FILL]] | | | |

---

## JANUS Services Interacted With

| Service | Direction | Purpose |
|---|---|---|
| [[FILL: e.g., ATLAS]] | [[FILL: Outbound / Inbound]] | [[FILL: what is exchanged]] |

If no JANUS service integrations exist yet: "{{SERVICE_NAME}} currently operates independently within the JANUS ecosystem. No active service-to-service integrations."

---

## Deployment Context

| Environment | Access | Purpose |
|---|---|---|
| `local` | Developer workstation | Development and testing |
| `staging` | [[FILL: Internal only / Restricted]] | Integration testing and pre-release validation |
| `production` | [[FILL: Public / Restricted]] | Live service |

Full environment detail: `docs/operations/environment-management.md`
