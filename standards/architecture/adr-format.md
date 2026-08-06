# ADR Format

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

Architecture Decision Records (ADRs) are the mechanism by which significant decisions are made visible, reasoned about, and preserved. An ADR answers not just "what did we decide" but "what did we consider and why did we choose this." That context is what allows future engineers to evaluate whether a decision still applies.

This standard defines the format, lifecycle, numbering, and submission process for all ADRs in the JANUS ecosystem — both ecosystem-level ADRs in `janus-engineering` and service-level ADRs in individual service repositories.

---

## When to Write an ADR

Write an ADR when a decision:
- Has significant architectural implications (affects structure, scalability, security, or team workflow)
- Cannot be easily reversed without significant effort
- Has multiple reasonable options that were genuinely considered
- Would surprise a new team member if they encountered it without context
- Involves a new technology, framework, or dependency entering the ecosystem

Do not write an ADR for:
- Implementation choices within an already-decided technology (how to structure a function, what to name a variable)
- Decisions that are obvious given the established architecture
- Reversible choices that can be changed with a single PR

When in doubt, write the ADR. An unnecessary ADR costs one hour. A missing ADR for a consequential decision costs the entire team.

---

## ADR Numbering

**Ecosystem ADRs** (in `janus-engineering/adr/ecosystem/`): `ADR-E001`, `ADR-E002`, ... Sequential, never recycled.

**Internal ADRs** (in `janus-engineering/adr/internal/`): `ADR-T001`, `ADR-T002`, ... Sequential, never recycled.

**Service ADRs** (in `<service-repo>/docs/architecture/adr/`): `ADR-0001`, `ADR-0002`, ... Sequential per service, never recycled.

Numbers are never reused even if an ADR is rejected. A rejected ADR is preserved in its `Rejected` state to maintain the historical record.

---

## File Naming

```
ADR-E001-polyrepo-strategy.md          (ecosystem)
ADR-T001-standards-suite-versioning.md (internal)
ADR-0001-supabase-primary-backend.md   (service-level)
```

Format: `ADR-<NUMBER>-kebab-case-title.md`

The title in the filename is the short description of the decision, not the question. "supabase-primary-backend" not "should-we-use-supabase".

---

## ADR Document Format

```markdown
# ADR-XXXX: [Decision Title]

**Date:** YYYY-MM-DD
**Status:** [Proposed | Accepted | Deprecated | Superseded | Rejected]
**Decider:** [Name / Role]
**Consulted:** [Names / Roles]
**Supersedes:** [ADR-XXXX, if applicable]
**Superseded by:** [ADR-XXXX, if applicable]

---

## Context

[The situation that required a decision. Include:
- What problem are we solving?
- What constraints exist (technical, organizational, timeline)?
- What assumptions are we making?
- Why does this decision matter?]

---

## Options Considered

### Option A: [Name]

[Description of the option]

**Pros:**
- [Advantage]

**Cons:**
- [Disadvantage]

### Option B: [Name]

[Description of the option]

**Pros:**
- [Advantage]

**Cons:**
- [Disadvantage]

[Add as many options as were genuinely considered]

---

## Decision

[State the decision clearly and completely. "We will use X" is a decision. "We are leaning toward X" is not.]

[Explain why this option was chosen over the alternatives.]

---

## Consequences

**Positive:**
- [What this decision enables]

**Negative / Trade-offs:**
- [What this decision costs or forecloses]

**Risks:**
- [What could go wrong, and how we mitigate it]

**Migration path** (if replacing an existing approach):
- [How existing code or systems transition to this decision]
```

---

## ADR Lifecycle

```
Proposed → Accepted
         → Rejected

Accepted → Deprecated (decision is still in effect but will be phased out)
         → Superseded (a new ADR replaces this decision)
```

**Proposed:** The ADR has been drafted and is under review. It does not bind any decisions.

**Accepted:** The decision has been made by the authorized decider. It is now binding. Service-level ADRs require CSA acceptance. Ecosystem ADRs require JAC acceptance.

**Deprecated:** The decision is still in effect in existing systems but will not apply to new work. A migration plan exists.

**Superseded:** A new ADR (`Superseded by: ADR-XXXX`) has replaced this one. This ADR remains in place as historical record.

**Rejected:** The proposal was reviewed and declined. The ADR remains to explain what was considered and why it was not chosen.

---

## Immutability Rule

Accepted ADRs are immutable. The content of an accepted ADR may not be changed to reflect new understanding. If the decision changes, a new ADR is written that supersedes the original. The original is updated only to add `Status: Superseded` and `Superseded by: ADR-XXXX`.

This rule exists because ADRs are historical records. Editing an accepted ADR to reflect what we now wish we had decided destroys the value of the record.

---

## Submission Process for Service-Level ADRs

1. Create the file: `docs/architecture/adr/ADR-XXXX-title.md` with `Status: Proposed`
2. Submit a PR with the ADR as the only change
3. Tag the CSA for review
4. The CSA consults relevant engineers (named in `Consulted`)
5. The CSA updates `Status: Accepted` or `Status: Rejected` and merges
6. Update the ADR README index in `docs/architecture/adr/README.md`

For ecosystem ADRs, the RFC process defined in `janus-engineering/docs/governance/rfc-process.md` applies.

---

## Ecosystem ADR — Additional Required Fields

Ecosystem ADRs include two additional fields that service-level ADRs do not require:

```
**Services Impacted:** [All | ATLAS | list specific services]
**Migration Lead Time Required:** [Immediate | 30 days | 60 days | 90 days]
**Grace Period:** [Same as lead time — services have this long to comply]
```
