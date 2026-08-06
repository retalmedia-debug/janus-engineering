# Engineering Principles

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

These principles are the foundation beneath every technical decision made in the JANUS ecosystem. They do not describe what to build. They describe how engineers must think when building anything.

Principles are not rules. Rules tell you what to do. Principles tell you how to think when the rules run out. When two correct-looking choices exist and no specific standard resolves the conflict, these principles do.

Every JANUS service extends these principles with domain-specific additions. No service-level principle may contradict a universal principle. Service-level principles narrow scope; they do not override.

---

## Principle 1 — Correctness Before Optimization

A system that is fast but wrong is worse than a system that is slow but correct. Optimization is a response to a measured problem, not a speculative investment.

**Applied:** Do not tune performance without a benchmark showing a real problem. Do not sacrifice type safety, RLS enforcement, data validation, or test coverage for speed of delivery. Premature optimization produces code that is both wrong and difficult to fix.

---

## Principle 2 — Explicit Over Implicit

Systems that rely on implicit behavior — framework magic, convention-over-configuration defaults, side effects of ordering — are systems that are understood only by the engineer who wrote them last week. Every behavior should be visible, nameable, and findable.

**Applied:** Prefer explicit return types over inference when the type is not obvious. Prefer explicit imports over barrel re-exports that obscure origin. Prefer explicit configuration over default-resolution chains. If you have to explain how something works to a reviewer, consider whether it could be explicit instead.

---

## Principle 3 — Design for Failure

Every external call fails. Every dependency is unavailable at some point. Every database query returns an unexpected result eventually. Systems designed to succeed under ideal conditions are systems that fail unpredictably under real ones.

**Applied:** Every external API call has a timeout. Every fallible operation has a defined failure path. Errors are typed, not swallowed. Timeouts are configured, not defaulted to infinity. The question is not "what happens when everything works" but "what does the user experience when this component is unavailable."

---

## Principle 4 — Boundaries Are Sacred

A system's value is determined not by what it does internally but by what its boundary promises. The boundary — the API contract, the event schema, the database interface — is the only thing other systems can depend on. Code inside the boundary can be refactored, replaced, or rewritten. The boundary must remain stable.

**Applied:** No service accesses another service's database directly. No service reads another service's internal data models. Integration happens through published contracts only. Changing an API contract is not a refactoring task — it is an architectural event requiring coordination with all consumers.

---

## Principle 5 — Observability by Default

A system that cannot be observed cannot be operated. Observability is not a feature added after launch; it is a property designed in from the first line of code. When an incident occurs at 3 AM, the logs, metrics, and traces tell the story. If they do not, the system was not designed for operation.

**Applied:** Every service emits structured logs in the format defined by `standards/operations/logging-standard.md`. Every error is logged with context. Every request produces a trace ID that appears in every related log entry. The question to ask when writing any code path: "If this fails silently at 3 AM, will I know?"

---

## Principle 6 — Security Is Not a Layer

Security is not a feature added at the end. It is not a separate team's responsibility. It is not a checkbox in the deployment pipeline. Security is a property of every decision — architectural, data model, API, dependency, and deployment decision — made throughout the development process.

**Applied:** Authentication is verified before any business logic executes. Authorization is enforced at the data layer, not only the API layer. Dependencies are evaluated for security risk before adoption. No sensitive data appears in logs. The question to ask when writing any code: "Who should not be able to do this, and does the code prevent them?"

---

## Principle 7 — Data Integrity Over Application Convenience

Data persists beyond the code that writes it. Application code changes; data remains. A schema decision that compromises data integrity for the convenience of the current application is a decision that forces every future engineer to work around a corrupted foundation.

**Applied:** Constraints are enforced at the database level, not only in application code. Foreign keys are defined and ON DELETE behavior is always explicit. NULL is used only when absence is a meaningful domain state, not as a convenient default. No data is stored in a format that loses information from the original source.

---

## Principle 8 — One Source of Truth

Every piece of data, every configuration value, every definition has exactly one authoritative location. Duplication creates divergence, and divergence creates bugs that are discovered in production.

**Applied:** Configuration values are never duplicated across environments — they are referenced from a single definition. Database schema documentation lives adjacent to the migration that creates it. A type defined in one place is imported, not redefined. When two representations of the same information exist, one must be derived from the other or the architecture is wrong.

---

## Principle 9 — Reversibility as a Design Constraint

The ability to undo a decision is as valuable as the decision itself, especially early in a system's life. Systems that cannot be rolled back, migrated, or reversed are systems that cannot be improved safely.

**Applied:** Database migrations are assessed for reversibility before they are written. API changes that cannot be reversed require a new API version. Feature flags allow features to be disabled without a deployment. Architecture decisions that foreclose future options are identified as such and require deliberate acceptance.

---

## Principle 10 — Simplicity Is Earned, Not Assumed

Simple systems are harder to build than complex ones. Simplicity is the result of understanding a problem so deeply that the essential shape becomes visible. It is not the default; it must be earned through iteration, understanding, and willingness to discard clever solutions.

**Applied:** Abstractions are created only when they eliminate real duplication, not speculative duplication. Patterns are adopted only when they solve a real problem present in the codebase. The right response to "this is complex" is to understand the problem better, not to reach for a framework. The measure of a design is not how sophisticated it looks but how little explanation it requires.

---

## Principle 11 — The Architectural Order Is Non-Negotiable

There is an ordering to decisions that reflects the actual dependencies between them. Vision must precede architecture. Architecture must precede data model. Data model must precede API. API must precede implementation. This order exists because later decisions constrain the solution space and earlier decisions define the problem space.

Skipping steps does not accelerate delivery — it produces rework. A data model designed without an architecture is redesigned when the architecture is clarified. An API designed without a data model is redesigned when the constraints of the data become apparent.

**Applied:** The Architectural Order defined in `standards/architecture/architectural-order.md` is the sequencing model for all JANUS services. No service begins implementation without completing the prior phases. No phase produces a final artifact until the preceding phase's artifacts are stable.

---

## Adding Domain-Specific Principles

Each JANUS service may add principles specific to its domain. Domain principles:

- Must not contradict any of the 11 universal principles above
- Must be specific to the service's domain, not general engineering advice
- Must include an "Applied:" section that shows how the principle operates in the service's specific context
- Are documented in the service's own `docs/architecture/engineering-principles.md`

The universal principles are owned by the JAC. Domain principles are owned by the service CSA.
