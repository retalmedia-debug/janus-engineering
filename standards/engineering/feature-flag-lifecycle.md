# Feature Flag Lifecycle

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Feature flags allow incomplete or experimental features to exist in the codebase without affecting users who should not see them. Used correctly, they enable safe incremental deployment. Used incorrectly, they become permanent conditional complexity that no one dares to remove.

This standard defines how JANUS services create, manage, activate, and retire feature flags.

---

## When to Use a Feature Flag

Use a feature flag when:
- A large feature needs to be deployed incrementally before it is complete
- A high-risk change needs to be enabled gradually (canary rollout)
- A feature needs to be disabled quickly if problems arise without a code deployment
- A feature should be available in some environments but not others during development

Do not use a feature flag when:
- The feature will be complete and deployed in a single release
- The "flag" is actually an environment-specific configuration value
- The flag would exist indefinitely as a way to avoid completing the feature

---

## Flag Naming Convention

```
{{SERVICE_PREFIX}}_FEATURE_{{FEATURE_NAME}}_ENABLED
```

Examples:
- `ATLAS_FEATURE_GEOFENCE_ALERTS_ENABLED`
- `VENUS_FEATURE_REPORT_EXPORT_ENABLED`

Rules:
- `SCREAMING_SNAKE_CASE` always
- Boolean only — `true` or `false` (as string environment variable)
- The name describes what is enabled, not what is disabled
- The `_ENABLED` suffix is always present

---

## Flag Implementation

Feature flags are environment variable-based. Each service's configuration management document defines the exact implementation.

```typescript
const isFeatureEnabled = process.env.{{SERVICE_PREFIX}}_FEATURE_{{NAME}}_ENABLED === 'true'
```

Feature flags are **never** hardcoded as `true` or `false` in source code. A hardcoded `true` is not a flag — it is dead code. A hardcoded `false` is never-executed code.

---

## Flag Registration

Every feature flag is:
1. Documented in `.env.example` with a comment describing the feature and the current default
2. Listed in the service's `docs/operations/configuration-management.md` under Feature Flags
3. Given a creation date and expected retirement date at creation time

```bash
# .env.example
# Enables the geofence alert notification system
# Default: false — enable when notification infrastructure is complete
# Created: 2026-08-06 | Retire by: 2026-11-01
ATLAS_FEATURE_GEOFENCE_ALERTS_ENABLED=false
```

---

## Flag Lifecycle

```
Created (default: off)
    ↓ Feature implemented behind flag
Enabled in Development
    ↓ Testing passes
Enabled in Staging
    ↓ Validation passes
Enabled in Production (gradual if high-risk)
    ↓ Stable for 30 days at 100%
RETIRED — remove flag and dead code path
```

---

## Retirement Rule

A feature flag must be retired when:
- It has been at `true` in all environments for **30 consecutive days**, or
- The feature it guards has been removed from the roadmap entirely

At retirement:
1. Remove the conditional code — keep the "enabled" path, delete the "disabled" path
2. Remove the environment variable from `.env.example` and all environment configurations
3. Remove the entry from the configuration management document
4. Close the tracking issue with the retirement commit reference

**No feature flag older than 3 months at a stable value is acceptable.** A flag that has been `true` in production for 3 months is no longer a flag — it is dead conditional code that creates confusion.

The CSA reviews the flag registry in the quarterly maintenance review and initiates retirement for any flag that has passed its retirement date.

---

## What Feature Flags Are Not

- Not a substitute for completing features before deploying them (technical debt that disables features is debt, not flagging)
- Not a way to create per-customer feature differentiation (that is a product configuration problem, not a feature flag)
- Not permanent configuration (anything permanent should be a named configuration value, not a feature flag)
