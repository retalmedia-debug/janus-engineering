<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/AGENTS.md -->

# AGENTS.md — AI Agent Instructions for {{SERVICE_NAME}}

This file governs AI agent behavior in the `{{SERVICE_REPO}}` repository. All AI tools operating in this repository must follow these instructions.

For JANUS-wide AI collaboration rules, see:
- `standards/ai-collaboration/ai-collaboration-rules.md` in `janus-engineering`
- `standards/ai-collaboration/human-responsibilities.md` in `janus-engineering`

---

## Scope

{{SERVICE_NAME}} is a **[[FILL: describe the service domain in one line]]** service. AI agents operating here assist with implementation within that domain only.

---

## Document Authority

Follow the Architectural Order strictly:

1. `docs/governance/` — Highest authority. Never contradict.
2. `docs/architecture/` — Structural decisions. ADRs are immutable once Accepted.
3. `docs/engineering/` — Coding standards and conventions.
4. `docs/security/` — Security baseline. Non-negotiable.
5. `docs/testing/` — Testing strategy and coverage requirements.
6. All other `docs/` sections.

---

## What AI Agents Can Do

- Write implementation code within approved architecture
- Write tests that match the testing strategy
- Write documentation for completed implementation
- Suggest refactors within approved scope
- Identify technical debt for human review

---

## What AI Agents Cannot Do

- Make or change architectural decisions
- Add dependencies (research only; human approves)
- Modify ADRs
- Modify governance documents
- Commit to `main` or `develop` directly
- Deploy to any environment
- Access secrets, credentials, or production data
- Submit pull requests on behalf of a human

---

## Output Format Requirements

- All code must pass lint and type-check before presenting
- All generated tests must be deterministic
- Flag any assumption made about business logic with `<!-- ASSUMPTION: -->` comments
- Do not add `console.log` statements
- Do not use `any` in TypeScript without explicit justification

---

## Service-Specific Rules

[[FILL: Add any rules specific to this service's domain, tech stack, or team conventions. If none, remove this section.]]
