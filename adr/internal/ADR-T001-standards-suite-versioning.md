# ADR-T001: Standards Suite Versioned as a Whole

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect

---

## Context

`janus-engineering` will evolve over time. Standards will be added, amended, and deprecated. Services need a way to declare which version of the standards they are compliant with — and the compliance check needs to know what version of the standards to enforce.

Two versioning strategies exist: version each standard independently, or version the suite as a whole.

---

## Options Considered

### Option A: Per-Standard Versioning

Each document in `standards/` has its own version (e.g., `git-strategy.md` at v1.2.0, `security-baseline.md` at v2.1.0).

**Pros:**
- Precise — a service can state exactly which version of each standard it follows
- Standards can evolve independently

**Cons:**
- Services declare compliance with a matrix of versions: `git-strategy@1.2.0, security-baseline@2.1.0, ...`
- The compliance check must track the version of each standard independently
- Combinatorial complexity grows with each new standard
- No coherent "state of the ecosystem at a point in time" — services are a patchwork of different standard versions

### Option B: Suite Versioning

The entire `standards/` collection is versioned as a single suite using SemVer on the repository. Services declare `janus-engineering@1.2.0` compliance.

**Pros:**
- Simple compliance declaration: one version number per service
- A suite version is a coherent snapshot — all standards at that version are known and mutually compatible
- The compliance check only needs to know one version number
- Releases are meaningful events — `janus-engineering@2.0.0` announces ecosystem-wide changes
- git tags make historic versions browsable

**Cons:**
- A PATCH change to one standard bumps the suite version — services receive a notification even if the change is irrelevant to them
- Services cannot selectively adopt one new standard without adopting all changes in that release

---

## Decision

**Suite versioning.** `janus-engineering` is versioned as a whole via annotated git tags.

The PATCH bump for irrelevant changes is acceptable. Services are not required to upgrade on every PATCH. Grace periods allow services to upgrade on their own schedule within a window.

The benefit of a coherent, time-stamped snapshot of the entire standards suite — where a service can declare "we follow janus-engineering@1.2.0" and that statement is unambiguous — outweighs the minor cost of PATCH bumps for irrelevant changes.

---

## Consequences

**Positive:**
- `services/registry.yaml` stores one version number per service
- `validate-compliance.sh` validates against one version
- Ecosystem-wide state at any point in time is observable by looking at git history

**Negative / Trade-offs:**
- Adding any new standard or template triggers a MINOR bump that notifies all services
- Services must understand that not every notification requires action (PATCH bumps rarely do)

**Implementation:**
- Suite version lives in `VERSION` file at repository root
- Suite releases are tagged: `git tag -a v1.0.0 -m "Release v1.0.0: Initial ecosystem foundation"`
- The `CHANGELOG.md` documents what changed in each release
- Services reference the suite version in `.janus-compliance.yaml` as `janus_engineering_suite_version`
