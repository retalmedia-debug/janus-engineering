# ADR-E009: JANUS Platform, Intelligence Domain Ownership, and Canonical System Sequence

**Date:** 2026-08-19
**Status:** Accepted
**Decider:** JANUS Principal Architect (Mr. Don)
**Consulted:** JANUS Architecture Council
**Supersedes:** ADR-E007 — Canonical Service Implementation Sequence
**Superseded by:** _(none)_

---

## Context

The JANUS ecosystem has evolved beyond the assumptions recorded in ADR-E007.

ADR-E007 correctly established the need for a canonical implementation sequence,
but several assumptions are now obsolete:

1. GCS was provisionally described as a Ground Control System and platform control plane.
2. JANUS Platform itself was not explicitly modeled as Position 0.
3. Several intelligence systems had undefined or speculative domains.
4. CRAT and NARCOS were assigned sequence positions that no longer reflect the approved ecosystem plan.
5.he boundary between platform responsibilities and intelligence-system responsibilities was not explicit.

The ecosystem now has ten defined intelligence systems operating under one JANUS Platform.

This ADR establishes the authoritative platform boundary, intelligence-system domains,
canonical implementation sequence, and ownership rules.

---

## Decision

## 1. JANUS Platform is Position 0

JANUS Platform is the ecosystem platform layer.

It is not an eleventh intelligence system and is not part of the numbered
implementation sequence of the ten intelligence systems.

JANUS Platform occupies:

**Position 0 — Platform Layer**

Primary responsibilities include:

- Global authentication entry point
- Global member identity and profile
- Global roles and access policy
- System availability and access control
- Canonical system registry
- Global application shell and navigation
- Global settings and appearance
- Ecosystem routing and system handoff contracts
- Governance and orchestration of the ecosystem

JANUS Platform must not absorb the domain logic, domain databases, workflows,
or intelligence responsibilities of the ten systems.

Each intelligence system remains independently owned, implemented, deployed,
and governed according to JANUS engineering standards.

---

## 2. All Ten Systems Are Intelligence Systems

The ten numbered JANUS systems form the intelligence layer of the ecosystem.

Each system owns one primary intelligence domain.

The canonical domain map is:

| Position | System | Repository | Intelligence Domain |
|---|---|---|---|
| 1 | ATLAS | `atlas-v1` | General Intelligence |
| 2 | GCS | `gcs-v1` | Strategy Intelligence |
| 3 | VENUS | `venus-v1` | Operations Intelligence |
| 4 | APOLLO | `apollo-v1` | Media Intelligence |
| 5 | HERMES | `hermes-v1` | Content Scheduling & Publishing Intelligence |
| 6 | CRONOS | `cronos-v1` | Managed Meta Insights Intelligence |
| 7 | NARCOS | `narcos-v1` | Sales Intelligence |
| 8 | HERA | `hera-v1` | Human Resources Intelligence |
| 9 | AURUS | `aurus-v1` | Financial Intelligence |
| 10 | CRAT | `crat-v1` | Reporting Intelligence |

This table is authoritative for domain ownership and implementation sequence.

---

## 3. ATLAS — General Intelligence

ATLAS owns the General Intelligence domain.

Its scope includes:

- Intelligence acquisition
- External intelligence ingestion
- Evidence preservation
- Structured intelligence
- Intelligence analysis
- Findings
- Recommendations
- Geospatial intelligence
- Open-source and approved external-source intelligence

Geo Intelligence is therefore a major capability inside the broader
ATLAS General Intelligence domain rather than the complete definition of ATLAS.

ATLAS may acquire intelligence about external organizations,
locations, competitors, markets, public digital properties,
and other approved intellence sources.

ATLAS does not own:

- Operations management
- Strategy creation
- Media production
- Content publishing
- Managed Meta performance insights
- Sales management
- Human resources
- Financial management
- Report generation

Those domains remain owned by their corresponding JANUS intelligence systems.

---

## 4. GCS — Strategy Intelligence

GCS owns Strategy Intelligence.

Its responsibility is the creation, development, organization,
evaluation, refinement, and evolution of institutional strategies.

GCS may consume intelligence from other JANUS systems
and transform relevant intelligence into:

- Strategic models
- Strategic options
- Strategic plans
- Strategic recommendations
- Strategic priorities
- Strategic scenarios
- Strategy revisions and development cycles

GCS is not the JANUS control plane.

The previous interpretation of GCS as "Ground Control System"
or as a platform-layer control plane is retired by this ADR.

Platform governance, identity, access, registry,
navigation, and ecystem orchestration belong to JANUS Platform.

---

## 5. VENUS — Operations Intelligence

VENUS owns Operations Intelligence.

Its responsibility is the intelligence and management layer
for day-to-day organizational operations.

Its domain includes:

- Operational workflows
- Execution visibility
- Task and process state
- Operational performance
- Operational coordination
- Operational management intelligence
- Process monitoring
- Operational exceptions and bottlenecks

VENUS owns operational truth within its domain.

VENUS does not own global JANUS orchestration,
which remains a JANUS Platform responsibility.

---

## 6. APOLLO — Media Intelligence

APOLLO owns Media Intelligence.

Its domain includes intelligence and workflows associated with:

- Media assets
- Media production
- Media activities
- Media analysis
- Media libraries
- Media classification
- Media-related workflows
- Approved media intelligence capabilities

APOLLO owns the media-domain intelligence lifecycle.

Detailed APOLLO subdom may evolve inside the service,
but must not expand into another system's primary domain
without an approved governance change.

---

## 7. HERMES — Content Scheduling & Publishing Intelligence

HERMES owns Content Scheduling & Publishing Intelligence.

Its responsibilities include:

- Content calendars
- Publication planning
- Scheduling
- Publishing execution
- Publication state
- Delivery of approved content to supported channels
- Publishing history
- Publishing workflow intelligence

HERMES owns when, where, and how approved content
is scheduled and published.

HERMES does not own:

- The broader Operations Intelligence domain of VENUS
- Media Intelligence owned by APOLLO
- Managed Meta performance insights owned by CRONOS

---

## 8. CRONOS — Managed Meta Insights Intelligence

CRONOS owns intelligence derived from Meta properties
that the organization manages directly for its clients.

Its scope includes acquisition, normalization, storage,
comparison, and analysis of performance insights from mad:

- Facebook Pages
- Instagram accounts
- Other approved Meta-managed properties

Its intelligence may include:

- Reach
- Impressions
- Engagement
- Followers
- Audience metrics
- Content performance
- Page performance
- Account performance
- Managed Meta reporting metrics
- Historical performance trends

CRONOS is not the general external-intelligence collector.

Intelligence gathered from public or external properties
that the organization does not directly manage belongs to ATLAS,
unless another JANUS system has explicit domain ownership.

This separation prevents overlap between:

ATLAS:
External and general intelligence

CRONOS:
First-party managed Meta performance intelligence

---

## 9. NARCOS — Sales Intelligence

NARCOS owns Sales Intelligence.

Its responsibilities include:

- Leads
- Prospects
- Opportunities
- Sales pipelines
- Sales activities
- Sales stages
- Conversion intelligence
- Commercial performance
- Sales forecasting
- Sales targets
- Sales performance analysis

NARCOS is the Single Source of Truth for sales-domain intelligence.

Other JANUS systems may consume sales intelligence,
but must not create competing authoritative sales records.

---

## 10. HERA — Human Resources Intelligence

HERA owns Human Resources Intelligence.

Its responsibilities include:

- Workforce information
- Employee records
- Organizational people intelligence
- Roles and positions
ng
- Employee lifecycle intelligence
- HR operations
- Workforce performance intelligence
- Approved HR analytics
- Human-resources planning

HERA is the Single Source of Truth for human-resources-domain intelligence.

JANUS Platform may own global authentication identity
and ecosystem access permissions,
but this does not make JANUS Platform the owner
of HR records or workforce intelligence.

Authentication identity and HR identity are separate concerns.

---

## 11. AURUS — Financial Intelligence

AURUS owns Financial Intelligence.

Its responsibilities include:

- Financial records
- Revenue intelligence
- Cost intelligence
- Expense intelligence
- Cash-flow intelligence
- Financial performance
- Financial analysis
- Financial planning
- Budget intelligence
- Profitability intelligence
- Approved financial forecasting

AURUS is the Single Source of Truth for financial-domain intelligence.

Other JANUS systems may consume financial facts through approved contracts,
but financial authority remains with AUS.

---

## 12. CRAT — Reporting Intelligence

CRAT owns Reporting Intelligence.

Its responsibility is the preparation, composition,
generation, rendering, packaging, distribution,
and lifecycle management of reports across the JANUS ecosystem.

Its responsibilities include:

- Report composition
- Report templates
- Report generation
- Report rendering
- Report packaging
- Report versions
- Report export
- Report presentation structures
- Report lifecycle management
- Cross-system report assembly

CRAT owns the report artifact and the reporting process.

CRAT does not become the owner
of the source intelligence presented inside a report.

General intelligence remains owned by ATLAS.
Strategy intelligence remains owned by GCS.
Operations intelligence remains owned by VENUS.
Media intelligence remains owned by APOLLO.
Publishing intelligence remains owned by HERMES.
Managed Meta insights remain owned by CRONOS.
Sales intelligence remains owned by NARCOS.
HR intelligence remains owned by HERA.
Financial intelligence remains owned by AURUS.

CRAT consumes those facts through defined references,
APIs, events, contracts,
or other approved integration mechanisms.

CRAT must not create competing authoritative copies
of another system's source data.

---

## 13. Canonical Implementation Sequence

The approved JANUS architecture consists of:

- One platform layer
- Ten intelligence systems

JANUS Platform occupies Position 0.

The ten intelligence systems retain the following canonical implementation sequence:

| Position | System | Repository | Primary Intelligence Domain |
|---|---|---|---|
| 1 | ATLAS | `atlas-v1` | General Intelligence |
| 2 | GCS | `gcs-v1` | Strategy Intelligence |
| 3 | VENUS | `venus-v1` | Operations Intelligence |
| 4 | APOLLO | `apollo-v1` | Media Intelligence |
| 5 | HERMES | `hermes-v1` | Content Scheduling & Publishing Intelligence |
| 6 | CRONOS | `cronos-v1` | Managed Meta Insights Intelligence |
| 7 | NARCOS | `narcos-v1` | Sales Intelligence |
| 8 | HERA | `hera-v1` | Human Resources Intelligence |
| 9 | AURUS | `aurus-v1` | Financial Intelligence |
| 10 | CRAT | `crat-v1` | Reporting Intelligence |

JANUS Platform is not System 11.

It exists above the ten intelligence systems
as the shared ecosystem platform layer.

This sequence supersedes the implementation sequence defined in ADR-E007.

---

## 14. Single Source of Truth

Every JANUS intelligence domain must have exactly one authoritative owner.

The authoritative ownership model is:

- ATLAS owns General Intelligence.
- GCS owns Strategy Intelligence.
- VENUS owns Operations Intelligence.
- APOLLO owns Media Intelligence.
- HERMES owns Content Scheduling & Publishing Intelligence.
- CRONOS owns Managed Meta Insights Intelligence.
- NARCOS owns Sales Intelligence.
- HERA owns Human Resources Intelligence.
- AURUS owns Financial Intelligence.
- CRAT owns Reporting Intelligence.

JANUS Platform owns platform-level concerns,
not business-domain intelligence.

JANUS Platform is authoritative for:

- Global authentication entry
- Global member identity and profile
- Global ecosystem roles and permissions
- System availability
- Canonical system registry
- Global navigation and shell
- Platform settings
- Ecosystem routing and handoff contracts

A system may consume intelligence from another system,
but must not create a competing authoritative source
for the same intelligence domain.

---

## 15. Cross-System Consumption

Cross-system intelligence consumption must occur
through explicit and governed integration contracts.

Approved mechanisms may include:

- REST APIs
- Versioned internal APIs
- Events
- Webhooks
- Message contracts
- Reference identifiers
- Approved read models
- Other formally governed mechanisms

Direct cross-system database reads are prohibited
unless explicitly approved by an ecosystem ADR.

A consuming system must preserve provenance
to the authoritative source system.

Examples include:

ATLAS intelligence -> GCS strategy development

CRONOS insights -> GCS strategy development

NARCOS sales intelligence -> GCS strategy development

AURUS financial intelligence -> GCS strategy development

ATLAS findings -> CRAT report generation

VENUS operations intelligence -> CRAT report generation

CRONOS insights -> CRAT report generation

NARCOS sales intelligence -> CRAT report generation

HERA HR intelligence -> CRAT report generation

AURUS financial intelligence -> CRAT report generation

The receiving system may own a new artifact
created inside its own domain.

For example:

GCS owns a strategy derived from ATLAS intelligence.

CRAT owns a report containing AURUS financial facts.

However:

GCS does not become the owner of ATLAS source intelligence.

CRAT does not become the owner of AURUS financial facts.

---

## 16. Separation of Responsibilities

A JANUS system must not expand
into another system's primary intelligence domain
merely because doing so is technically convenient.

When a capability crosses a domain boundary:

1. The source system retains ownership
   of its authoritative intelligence.

2. The consuming system accesses that intelligence
   through a defined integration contract.

3. Derived artifacts belong to the consuming system
   only within its own domain.

4. Competing authoritative copies are prohibited
   unless explicitly approved by ecosystem ADR.

5. Shared technical infrastructure
   does not imply shared domain ownership.

6. JANUS Platform orchestration
   does not imply ownership
   of the intelligence being orchestrated.

---

## 17. Critical Domain Boundaries

### ATLAS vs CRONOS

ATLAS owns external and general intelligence.

CRONOS owns performance intelligence
from Meta properties directly managed
by the organization for its clients.

A public Facebook or Instagram property
being investigated as an external intelligence source
belongs to ATLAS.

A client Facebook Page or Instagram account
actively managed by the organization,
where official Meta Insights are collected,
belongs to CRONOS for performance intelligence.

### APOLLO vs HERMES

APOLLO owns Media Intelligence.

HERMES owns scheduling and publishing intelligence.

APOLLO may manage, process, or analyze media assets.

HERMES owns the publication schedule,
publishing execution,
and publication lifecycle of approved content.

### VENUS vs JANUS Platform

VENUS owns business Operations Intelligence.

JANUS Platform owns ecosystem orchestration.

Operational workflows inside the business
do not become JANUS Platform responsibilities.

Platform routing, access control,
system availability, and system handoff
do not become VENUS responsibilities.

### CRAT vs Source Systems

CRAT owns reports.

CRAT does not own
the underlying intelligence contained in reports.

Every material report fact
must remain traceable
to its authoritative source system.

---

## 18. JANUS Platform and Intelligence-System Relationship

JANUS Platform is the shared platform layer for the ecosystem.

Its role is to provide the common environment through which
authorized members discover, access, enter, and move between
the ten intelligence systems.

The architectural relationship is:

JANUS Platform — Position 0

Platform responsibilities:
- Authentication entry
- Member identity
- Global roles and access
- System registry
- System availability
- Global shell
- Navigation
- Settings
- Routing
- System handoff
- Ecosystem governance and orchestration

Intelligence systems:
- ATLAS — General Intelligence
- GCS — Strategy Intelligence
- VENUS — Operations Intelligence
- APOLLO — Media Intelligencentent Scheduling & Publishing Intelligence
- CRONOS — Managed Meta Insights Intelligence
- NARCOS — Sales Intelligence
- HERA — Human Resources Intelligence
- AURUS — Financial Intelligence
- CRAT — Reporting Intelligence

JANUS Platform provides access to the systems.

It does not merge those systems into one codebase,
one domain model, or one authoritative database.

Each system remains independently deployable
and retains ownership of its domain logic and intelligence.

---

## 19. Repository and Deployment Boundary

The JANUS ecosystem follows the polyrepo strategy established by ADR-E001.

The platform and intelligence systems therefore remain separate repositories.

The approved repository model is:

- JANUS Platform -> `janus-platform`
- ATLAS -> `atlas-v1`
- GCS -> `gcs-v1`
- VENUS -> `venus-v1`
- APOLLO -> `apollo-v1`
- HERMES -> `hermes-v1`
- CRONOS -> `cronos-v1`
- NARCOS -> `narcos-v1`
- HERA -> `hera-v1`
- AURUS -> `aurus-v1`
- CRAT -> `crat-v1`

A unified user experience does not reqorepo.

Systems may appear under one user-facing ecosystem
while remaining separately implemented and deployed.

JANUS Platform may route or hand users into a system,
but must not embed a system by copying its application code
into the platform repository.

---

## 20. Identity and Access Boundary

JANUS Platform owns ecosystem-level identity and access concerns.

This includes:

- Authentication entry
- Global member identity
- Member profile
- Global ecosystem role
- System availability
- System access permission
- Global account settings

Individual intelligence systems may own
domain-specific permissions and memberships
required to operate inside their own domain.

For example:

JANUS Platform may determine
whether a member is allowed to enter ATLAS.

ATLAS may then determine
which ATLAS workspace, project, or intelligence capability
that member may access.

Global identity ownership
does not eliminate domain-level authorization.

Domain-level authorization
must not become a competing global identity system.

---

## 21. Data Ownership Boundary

JANUS Platform must not become
a universal storage location for intelligence-system data.

Platform-owned data is limited to platform concerns,
such as:

- Member identity metadata
- Platform preferences
- Global access configuration
- System registry metadata
- System availability state
- Ecosystem-level settings

Intelligence data remains owned
by the relevant intelligence system.

Cross-system intelligence must be consumed by reference,
contract, event, or approved integration mechanism.

This maintains Single Source of Truth
and prevents domain ownership from collapsing
into a shared database architecture.

---

## 22. Consequences

### Positive Consequences

This decision establishes:

- A clear Position 0 for JANUS Platform
- Ten clearly defined intelligence systems
- Explicit domain ownership for every system
- A corrected canonical implementation sequence
- A corrected definition of GCS
- Clear separation between platform orchestration and business operations
- Clear separation between external intelligence and managed Meta insights
- Clear distinction between report ownership and source-data ownership
- A stable Single Source of Truth model
- A stable foundation for future cross-system integrations

The ecosystem now has an explicit answer
to the question:

"Which system owns this capability or intelligence?"

### Trade-offs

This architecture requires:

- More explicit integration contracts
- Stronger cross-system API governance
- Careful provenance when intelligence moves between systems
- Independent repository and deployment management
- Domain discipline when adding new features

Some functionality that could technically be implemented
inside one application may instead require
a cross-system integration.

This additional engineering cost is accepted
in exchange for clear ownership,
maintainability, scalability, and governance.

---

## 23. Migration Required

After ADR-E009 is accepted,
the following governance migration is required:

1. Mark ADR-E007 as superseded by ADR-E009.

2. Update the ecosystem ADR index.

3. Update `services/registry.yaml`
   with the canonical ten-system sequence
   and authoritative intelligence domains.

4. Register JANUS Platform separately
   as Position 0 platform infrastructure,
   not as System 11.

5. Update
   `docs/governance/ecosystem-service-roadmap.md`.

6. Update
   `docs/ecosystem-map.md`.

7. Correct active documentation
   that defines GCS as Ground Control System
   or platform control plane.

8. Correct active documentation
   containing the old CRAT and NARCOS positions.

9. Add supersession notices
   to historical documents where appropriate
   rather than rewriting historical records.

10. Bootstrap the `janus-platform` repository
    according to JANUS Engineering Standards.

11. Ensure future service repositories
    inherit the domain boundaries defined by ADR-E009.

12. Define future cross-system contracts
    before allowing direct runtime dependencies
    between intelligence systems.

---

## 24. Governance Effect

Upon acceptance,
ADR-E009 becomes the authoritative ecosystem decision
for:

- JANUS Platform identity
- Position 0
- Intelligence-system domain ownership
- Canonical implementation sequence
- Single Source of Truth boundaries
- Platform-versus-system responsibility boundaries

ADR-E007 remains in the repository
as a historical Architecture Decision Record,
but is superseded by ADR-E009
wherever the decisions conflict.

Historical documents are not deleted
or rewritten to conceal previous architectural assumptions.

Active governance sources must reference
the current architecture defined here.

---

## 25. Authoritative Current-State Sources

After migration is complete,
the authoritative current-state sources are:

1. ADR-E009
2. `services/registry.yaml`
3. `docs/governance/ecosystem-service-roadmap.md`
4. `docs/ecosystem-map.md`

If a historical document conflicts
with these sources,
the current-state sources take precedence.

---

## 26. Acceptance Criteria

ADR-E009 may move from Proposed to Accepted when:

1. The document passes structural review.

2. The canonical ten-system order is confirmed as:

   01 ATLAS
   02 GCS
   03 VENUS
   04 APOLLO
   05 HERMES
   06 CRONOS
   07 NARCOS
   08 HERA
   09 AURUS
   10 CRAT

3. JANUS Platform is explicitly represented as Position 0
   and not as an eleventh intelligence system.

4. GCS is defined as Strategy Intelligence
   and not as Ground Control System.

5. Domain ownership is defined
   for all ten intelligence systems.

6. Single Source of Truth rules are explicit.

7. Cross-system direct database access
   is prohibited unless separately approved by ADR.

8. Migration targets are identified.

9. The Principal Architect approves the decision.

10. The governance propagation patch
    is validated before merge into `main`.
