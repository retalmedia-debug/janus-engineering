<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/ai-collaboration/cursor-responsibilities.md -->

# Cursor Responsibilities

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS AI collaboration standard: `standards/ai-collaboration/ai-collaboration-rules.md` in `janus-engineering`

---

## Role of Cursor in {{SERVICE_NAME}}

Cursor is an in-editor AI assistant. It operates at the file and function level, not the architectural level. Its role is to accelerate implementation — not to design.

---

## Authorized Uses

- Autocomplete within an already-designed function or class
- Generating boilerplate from a clear pattern that already exists in the codebase
- Writing tests for functions that are already implemented
- Explaining existing code to the developer

---

## Prohibited Uses

- Generating new architectural patterns not already in the codebase
- Generating database migration files (use the approved migration template)
- Generating API endpoint handlers without a written spec
- Suggesting dependency additions
- Generating auth or security logic without human review and sign-off

---

## Cursor Rules for {{SERVICE_NAME}}

[[FILL: If this service uses a `.cursor/rules/` file, document the active rules here and explain the reasoning. If Cursor rules are not configured, remove this section.]]

---

## Code Review

All code that passes through Cursor is subject to the same code review requirements as manually written code. Cursor authorship does not change the review standard. Reviewers are not required to accept code that is correct but does not match the codebase style, even if AI-generated.

---

## Drift Management

If Cursor begins suggesting patterns that diverge from the established architecture (new folder structures, new error handling patterns, new config patterns), stop and discuss with the CSA. AI tool drift is a governance issue per the JANUS AI collaboration standard.
