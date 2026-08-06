# ADR-E007: Canonical Service Implementation Sequence

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect (Mr. Don)
**Consulted:** JANUS Architecture Council (founding session)
**Supersedes:** _(none)_
**Superseded by:** _(none — filled in if this ADR is later superseded)_

---

## Context

The JANUS ecosystem consists of 10 planned services. As a polyrepo ecosystem (ADR-E001), each service is built, deployed, and maintained independently. However, some services depend on capabilities provided by other services — infrastructure readiness, validated standards patterns, integration contracts. Without a defined implementation sequence:

- Services could be built in an order that creates unsatisfied dependencies
- Engineering standards would not be validated by real service usage before subsequent services inherit them
- The team would not know which service to work on next

The Principal Architect must establish the canonical sequence as a governance artifact — not inferred from business priority, but from engineering dependency logic.

---

## Options Considered

### Option A: Unordered — Services built by business priority

Services are built in whatever order product management determines is most valuable at any given time.

**Pros:**
- Maximum flexibility for business prioritization

**Cons:**
- Services may be built before their infrastructure dependencies are operational
- Standards validated by ATLAS may not propagate to services that are already built
- No clear guidance for the engineering team on "what's next"

### Option B: Partial ordering — Only hard dependencies are sequenced

Only services with explicit integration dependencies are ordered. Services without declared dependencies may be built in any order.

**Pros:**
- Less rigid; allows business priority to influence order

**Cons:**
- Platform-layer services (GCS) may not be ready when intelligence services need them
- "No declared dependency" does not mean "no real dependency" — dependencies emerge during implementation

### Option C: Total ordering — All services assigned a fixed sequence position

All 10 services are assigned a fixed position in the implementation sequence based on engineering judgment about platform readiness and integration dependencies.

**Pros:**
- Clear guidance for the team
- Platform-layer services are built before dependent services
- Standards are proven against earlier services before later services inherit them
- "What comes next?" is never ambiguous

**Cons:**
- Reduces business prioritization flexibility
- May feel arbitrary for services whose dependencies are not yet defined

---

## Decision

**Option C: Total ordering — All services assigned a fixed sequence position.**

The canonical implementation sequence is:

| Position | Service | Repository |
|---|---|---|
| 1 | ATLAS | `atlas-v1` |
| 2 | GCS | `gcs-v1` |
| 3 | VENUS | `venus-v1` |
| 4 | APOLLO | `apollo-v1` |
| 5 | HERMES | `hermes-v1` |
| 6 | CRONOS | `cronos-v1` |
| 7 | CRAT | `crat-v1` |
| 8 | HERA | `hera-v1` |
| 9 | AURUS | `aurus-v1` |
| 10 | NARCOS | `narcos-v1` |

**Why this order:**

- **ATLAS first** because it validates all JANUS Engineering Standards in a real production service. No standard is considered mature until ATLAS has consumed it.
- **GCS second** because it provides the platform-layer control plane that intelligence domain services (positions 3–10) may depend on. GCS must be operational before its consumers begin implementation.
- **VENUS third** because it is the second intelligence domain and completes the initial platform proof-of-concept. If the polyrepo pattern and standards work for ATLAS and VENUS, they are validated.
- **APOLLO (4), HERMES (5), CRONOS (6)** represent progressively more complex domains that build on the proven platform.
- **CRAT (7), HERA (8), AURUS (9), NARCOS (10)** represent the most integration-dependent domains. Their positions reflect that they require the full platform stack to be mature before their domain can be meaningfully defined and implemented.

---

## Consequences

**Positive:**
- The team always knows which service is next
- Platform dependencies are satisfied before dependent services begin
- Standards accumulate real validation with each service
- A gate between services forces knowledge transfer and standards improvements

**Negative / Trade-offs:**
- Business priorities cannot override the sequence without a formal ADR amendment
- The sequence reflects current engineering judgment; future domain briefs may reveal that some services belong in a different position

**Risks:**
- Positions 4–10 have not yet had their domains defined. If domain definition reveals that, e.g., NARCOS should be at position 5, an ADR amendment will be required.

**Amendment process:**
Any change to this sequence requires a new ADR with JAC super-majority approval (2/3 of all voting members). The amendment must document why the new sequence is correct and what migration is required for any services already underway.
