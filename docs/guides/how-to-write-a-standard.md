# How to Write a Standard

**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

---

## Before You Write Anything

A standard must solve a real problem that has already occurred or is a predictable failure mode. Standards are not aspirational — they codify decisions already validated in practice.

Ask:
1. Has this problem actually bitten a JANUS service, or is it clearly inevitable?
2. Is there one correct answer, or are multiple approaches legitimately valid?
3. Will this be stable for at least a year, or is the technology changing too fast?

If the answer to any of these is uncertain, write a proposal issue (RFC pre-proposal) before writing the standard document.

---

## Standard Document Header

Every standard must begin with this header block:

```markdown
# [Standard Title]

**Suite Version:** [version this standard was added or last modified]
**Status:** Active
**Binding Level:** Mandatory | Mandatory-if-applicable | Recommended
**Applies To:** [Which services or contexts this standard applies to]
**Owner:** [Role — not a person name]
**Last Reviewed:** YYYY-MM-DD
```

---

## Required Sections

### 1. Purpose (required)

One paragraph. What problem does this standard solve? Why does the JANUS ecosystem need a uniform answer to this problem?

### 2. Requirements (required)

The core of the standard. State requirements as obligations:

- **Must / Must not** — Mandatory requirements
- **Should / Should not** — Recommended requirements
- **May** — Permitted but not required

Use numbered lists for ordered requirements. Use bullet lists for unordered requirements.

Do not say "it is recommended that..." — say "Should." Do not say "it is mandatory that..." — say "Must."

### 3. Rationale (required)

Why was this specific approach chosen? What alternatives were considered and why were they rejected? This section is the most important for long-term adoption — engineers who understand *why* follow standards willingly.

### 4. Examples (strongly recommended)

Concrete, working examples of compliant and non-compliant usage. Examples are more effective than prose for technical standards.

```markdown
**Compliant:**
[code or config example]

**Non-compliant:**
[code or config example with annotation explaining why it violates the standard]
```

### 5. Exceptions (if applicable)

If a Mandatory requirement has legitimate exceptions, document them explicitly. "No exceptions" is also a valid statement.

### 6. Compliance Check (if automatable)

How does `validate-compliance.sh` detect violations of this standard? If the check is implemented, reference the specific check. If it is not yet automated, state: "Not yet automated — human review required."

---

## Length and Depth

A standard should be:
- Long enough to be unambiguous
- Short enough to be read in one sitting

If a standard requires more than 1000 words, consider whether it is actually two standards that should be separate documents.

Avoid padding. Each sentence should add information that changes how a reader would implement the standard.

---

## What Does Not Belong in a Standard

- Implementation walkthroughs (put those in guides)
- History of past decisions (put that in ADRs)
- Service-specific context (put that in the service's docs/)
- Aspirational goals without concrete requirements

---

## Filing the RFC

Once the draft is complete:

1. Open an issue using `.github/ISSUE_TEMPLATE/rfc-standard-change.md`
2. Attach the draft standard as a linked document or paste it in the issue
3. 14-day comment period begins from the date the issue is opened
4. JAC disposition follows

See `docs/governance/rfc-process.md` for the full RFC lifecycle.

---

## Where Standards Live

Standards are placed in the appropriate subdirectory of `standards/`:

| Category | Directory |
|---|---|
| Architecture decisions | `standards/architecture/` |
| Engineering practices | `standards/engineering/` |
| API design | `standards/api/` |
| Security | `standards/security/` |
| Testing | `standards/testing/` |
| Operations | `standards/operations/` |
| Documentation | `standards/documentation/` |
| Database | `standards/database/` |
| AI collaboration | `standards/ai-collaboration/` |

After the standard is accepted, add it to `standards/INDEX.md` and bump the suite version.
