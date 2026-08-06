# Standards Amendment Policy

**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## Purpose

This policy governs how existing JANUS Engineering Standards are amended, deprecated, or removed. It is distinct from the RFC Process (which governs how new standards are proposed) — amendments follow a more constrained process because existing services are already bound by the current standard.

---

## Types of Changes

### PATCH Amendment

A non-breaking clarification or correction to an existing standard.

**Qualifies as PATCH:**
- Fixing a typo or grammatical error
- Clarifying ambiguous language without changing the requirement
- Adding an example that illustrates an existing rule
- Correcting a factual error (e.g., wrong HTTP status code in an example)

**Process:** PR to `main` with CSA approval. No RFC required. No grace period. Suite version bumped as PATCH.

---

### MINOR Amendment

Adding a new requirement that does not break existing compliant implementations.

**Qualifies as MINOR:**
- Adding a new Recommended requirement
- Adding a new Mandatory-if-applicable requirement for a new scenario
- Adding a new optional configuration option
- Adding a new section that does not affect existing requirements

**Process:** RFC required. 14-day comment period. JAC disposition. Grace period: 60 days. Suite version bumped as MINOR.

---

### MAJOR Amendment

Changing an existing requirement in a way that requires existing compliant services to change their implementation.

**Qualifies as MAJOR:**
- Changing a requirement from Recommended to Mandatory
- Changing an existing Mandatory requirement
- Removing a previously allowed option
- Changing a naming convention, format, or structure requirement

**Process:** RFC required. 14-day minimum comment period (JAC may extend to 28 days for high-impact changes). JAC disposition requires Principal Architect approval. Grace period: 90 days. Suite version bumped as MAJOR.

---

## Standard Deprecation

A standard may be deprecated when it is superseded by a new standard, the technology it governs is retired, or it is absorbed into another standard.

**Deprecation Process:**

1. Author a replacement standard (or identify the absorbing standard) via RFC
2. Once the replacement is accepted, the old standard is marked `Deprecated` and a `Superseded by:` note added
3. The deprecated standard is not removed — it remains visible with its deprecated status
4. Services still using the deprecated standard have the MAJOR grace period (90 days) to migrate

**Deprecated standards are never deleted** — they are part of the immutable historical record of decisions.

---

## Emergency Amendment

For critical security-related amendments that cannot wait for the standard RFC timeline:

1. Principal Architect may declare an Emergency Amendment
2. Minimum comment period: 48 hours (not 14 days)
3. JAC approval by async vote (majority required)
4. Grace period: 30 days maximum
5. A post-emergency RFC must be filed within 14 days to ratify or revise the emergency amendment

Emergency Amendments are used sparingly. Overuse triggers a governance review.

---

## Amendment Traceability

Every amendment to a standard is:

1. Documented in the `CHANGELOG.md` of `janus-engineering` under the suite version it was included in
2. Traceable to the RFC or PR that introduced it
3. Reflected in a MINOR or MAJOR suite version bump (PATCH amendments do not require service notification)

Services receiving a MINOR or MAJOR suite version notification can trace back to the specific standard amendments in the CHANGELOG.
