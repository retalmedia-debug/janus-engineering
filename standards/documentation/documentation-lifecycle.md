# Documentation Lifecycle

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Document States

Every document in `docs/` is in exactly one state at any time:

| State | Meaning |
|---|---|
| `Draft` | Being authored. Not yet authoritative. Not linked in the INDEX. |
| `Active` | Authoritative. In effect. Referenced in the INDEX. |
| `Under Review` | Active but currently being assessed for revision. Remains authoritative during review. |
| `Deprecated` | Superseded by another document or no longer applicable. Marked with deprecation notice. Not removed. |

---

## Document Versioning

Documents use semantic versioning in their header:

| Bump | When |
|---|---|
| PATCH | Typo fixes, clarifications, formatting corrections |
| MINOR | New sections added, existing sections expanded |
| MAJOR | Fundamental change to the document's guidance — the behavior it governs changes significantly |

The version in the header reflects the document's version, not the suite version.

MAJOR version bumps require the document to enter `Under Review` state before the change is accepted, except for emergency corrections.

---

## Lifecycle Stages

### Stage 1 — Creation

A document enters the lifecycle as `Draft`.
- Created in a `docs/*` PR
- Has a tentative owner assigned in the header
- Is not referenced in `docs/INDEX.md` until it reaches `Active`

### Stage 2 — Review

Before a document transitions to `Active`:
- Content is reviewed by the CSA (for service-level documents) or JAC (for ecosystem-level documents)
- All `[[FILL:]]` and `[[DECISION REQUIRED:]]` markers are resolved
- The `Status` header is updated to `Active`
- The document is added to `docs/INDEX.md`

### Stage 3 — Active Maintenance

While `Active`, the document is maintained by its owner:
- Updated in the same PR as any code change that makes the document inaccurate
- Reviewed on the quarterly documentation accuracy cadence
- Version is incremented on any change (PATCH for minor corrections, MINOR or MAJOR for substantive changes)
- `Last Reviewed` date is updated on each review pass

### Stage 4 — Under Review

When a document needs significant revision:
- `Status` changes to `Under Review`
- A GitHub Issue is opened tracking the review
- The document remains authoritative during the review — it governs behavior until the new version is accepted
- Review completes within 30 days

### Stage 5 — Deprecation

When a document is superseded or no longer applies:
- `Status` changes to `Deprecated`
- A deprecation notice is added at the top of the document:
  ```markdown
  > **Deprecated:** This document has been superseded by [Replacement Document](link).
  > It is retained for historical reference. Do not use it as current guidance.
  ```
- The document is removed from the primary INDEX but preserved in a `Deprecated` section
- The replacement document references this one in its history

### Stage 6 — Removal

Deprecated documents are retained for at least 6 months before removal. Removal:
- Requires CSA approval
- Is done via a dedicated PR with a description explaining the removal
- The document's git history preserves its content — removal from `main` does not erase history

---

## Broken Link Policy

A broken internal link (a link to a document that has been moved or removed) is a documentation bug. On discovery:
- Fix the link in the document where it appears
- If the target document was removed without a replacement, add a note explaining the absence

Broken links are tracked as P3 technical debt items. They are resolved in the next quarterly documentation review if not addressed immediately.

---

## Ownership Transitions

When a document owner changes:
- The CSA assigns a new owner within 5 business days
- The new owner updates the `Owner` field in the document header
- The new owner reviews the document for accuracy before accepting ownership
- A PATCH version bump records the ownership transition

A document without an owner is assigned to the CSA automatically. The CSA does not permanently own documents — reassignment is initiated immediately.
