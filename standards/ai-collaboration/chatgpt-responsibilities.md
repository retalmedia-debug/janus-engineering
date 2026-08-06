# ChatGPT Responsibilities

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Role Definition

ChatGPT (and equivalent general-purpose AI interfaces — Gemini, Perplexity, etc.) operates in an **external, exploratory** role. It is used for research, ideation, and analysis in contexts where an engineer is thinking through a problem, not yet producing production artifacts.

ChatGPT output is raw research material — useful input into human thinking, not a direct source of production artifacts.

---

## Authorized Activities

### Research and Discovery

- Research technology options before committing to an ADR
- Explore domain concepts before specification work begins
- Research security best practices and known vulnerability patterns in a domain
- Understand unfamiliar third-party API behaviors at a conceptual level

### Ideation and Brainstorming

- Brainstorm feature design approaches
- Explore edge cases for a feature before specification is written
- Understand trade-offs between architecture options
- Generate initial naming, structure, or pattern ideas

### Learning and Explanation

- Explain unfamiliar concepts, error messages, or language features
- Explain database internals or query behavior conceptually
- Understand how a new technology or protocol works

---

## What ChatGPT Output Is Not

ChatGPT output is categorically not:

- **A source of truth for API documentation** — APIs change; ChatGPT's training data has a cutoff. Always verify against current official documentation.
- **A source of security decisions** — ChatGPT may produce outdated or incorrect security advice. Security decisions are reviewed by the CSA against current standards.
- **A production artifact** — ChatGPT-generated code, schemas, or configurations are not pasted directly into the codebase.
- **A replacement for JANUS standards** — When ChatGPT suggests an approach that conflicts with a JANUS standard, the standard governs.

---

## The Transfer Rule

When ChatGPT's output is useful and the engineer wants to incorporate it into the codebase, the transfer follows one path:

```
ChatGPT Output
    ↓ engineer reads, evaluates, and understands
Human Understanding
    ↓ engineer implements from their own understanding
Codebase Contribution
```

The engineer does not copy-paste. The engineer reads and understands the output, then writes the implementation — or uses Claude Code with full codebase context to implement it correctly.

This rule exists because ChatGPT operates without knowledge of the service's specific architecture, naming conventions, security requirements, or active standards. An implementation that looks correct in isolation may violate multiple standards in context.

---

## Data Security in ChatGPT Prompts

ChatGPT prompts are sent to an external AI service over the internet. The following must never appear in a ChatGPT prompt:

- Any secret, API key, or credential
- Any production database content
- Any user PII (names, email addresses, phone numbers)
- Any sensitive domain data
- Proprietary business logic or strategy that is competitively sensitive
- Service architecture details that are confidential

When prompting ChatGPT with code examples, use generalized or anonymized examples — not verbatim production code.

---

## Verification Requirement

When ChatGPT provides a specific technical fact (a specific API method, a specific SQL syntax, a specific algorithm behavior), that fact is verified against the authoritative source before use.

ChatGPT is known to produce confidently incorrect technical details. This is a characteristic of the technology, not a failure of a specific model. No technical fact from ChatGPT is used without verification if it affects production behavior.

---

## No Formal Integration

ChatGPT and equivalent external AI services have no formal integration with any JANUS service repository — no API calls from CI, no plugin access to the codebase, no webhook connections.

These tools operate exclusively through the browser-based interface and the engineer's own knowledge transfer.

If a formal AI integration is desired for research or analysis within a service, it is evaluated through the standard dependency governance and ADR process — not assumed by default.
