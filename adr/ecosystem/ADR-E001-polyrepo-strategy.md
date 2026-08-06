# ADR-E001: Polyrepo Strategy

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect
**Services Impacted:** All
**Migration Lead Time Required:** Immediate (applies at ecosystem inception)
**Grace Period:** N/A

---

## Context

The JANUS ecosystem consists of multiple independent systems: JANUS, ATLAS, VENUS, NARCOS, AURUS, CRONOS, GCS, and HERA. Each system has a distinct domain, its own data model, its own deployment lifecycle, and potentially its own team.

A fundamental structural decision must be made before any system is built: will the ecosystem live in one repository (monorepo) or in independent repositories (polyrepo)?

This decision determines how code is organized, how teams work, how CI/CD is configured, and how inter-service contracts are managed.

---

## Options Considered

### Option A: Monorepo

A single repository containing all JANUS services.

**Pros:**
- Atomic cross-service refactoring (rename a type used everywhere in one PR)
- Shared tooling configuration with zero duplication
- Simple dependency management within the ecosystem (workspace: protocol)
- Unified CI pipeline visibility

**Cons:**
- Single CI/CD pipeline becomes complex as services multiply
- Branch protection and merge governance must accommodate all teams in one place
- A change in one service's tests or CI can block merges across the entire ecosystem
- Repository permissions cannot be scoped per service — everyone can see everything
- Services with different deployment cadences are forced to coordinate in a shared branching model
- At scale, monorepo tooling (nx, turborepo) introduces its own complexity and learning curve

### Option B: Polyrepo

Each JANUS system has its own independent repository.

**Pros:**
- Each service's repository, CI/CD, branching strategy, and deployment lifecycle is fully autonomous
- Teams can move at their own speed without blocking or being blocked by other services
- Repository permissions are naturally scoped per service
- The blast radius of a bad commit is contained to one service
- Each service can independently decide its release cadence, versioning strategy, and deployment topology
- Service ownership is unambiguous

**Cons:**
- Cross-service refactoring requires coordinated PRs across multiple repositories
- Shared tooling and standards must be actively distributed (the problem `janus-engineering` solves)
- Dependency on another JANUS service must be managed as a published contract, not a direct import
- Discovery of all services requires a registry

---

## Decision

**Polyrepo strategy.** Each JANUS system is an independent repository.

The primary driver is domain isolation and team autonomy. JANUS systems are not a single application that happens to have multiple modules. They are distinct systems that serve different domains, operate on different data, and will evolve at different rates. Forcing them into a single repository imposes coordination overhead that does not benefit the product.

The disadvantages of polyrepo (shared tooling distribution, cross-service contract management) are solved by:
- `janus-engineering` — the canonical source of all shared standards and tooling
- Explicit API contracts between services, versioned independently
- A service registry (`services/registry.yaml`) that provides ecosystem discovery

The disadvantages of monorepo at the scale of independent systems (governance complexity, CI blast radius, permission scope) are structural and grow worse with scale. The polyrepo disadvantages are solvable with process and tooling.

---

## Consequences

**Positive:**
- Every service team operates with full autonomy over their repository, branching model, and deployment cadence
- Repository permissions are cleanly scoped — a service's code is accessible only to those who need it
- A failure in one service's CI does not block any other service
- Services can be created, archived, or replaced without affecting the rest of the ecosystem

**Negative / Trade-offs:**
- Cross-cutting refactors (e.g., renaming a domain concept used in multiple services) require coordinated work across repositories
- Shared standards must be actively maintained and consumed via `janus-engineering`
- Contract changes between services require explicit coordination and consumer notification

**Risks:**
- Services may drift from JANUS standards without a compliance mechanism — mitigated by `scripts/validate-compliance.sh` and CI integration
- Cross-service contracts may be changed unilaterally — mitigated by the consumer-driven contract testing standard

**Migration path:**
This is a founding decision. All future JANUS services are created as independent repositories following this decision.
