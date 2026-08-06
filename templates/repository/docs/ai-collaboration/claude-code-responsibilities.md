<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/ai-collaboration/claude-code-responsibilities.md -->

# Claude Code Responsibilities

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

JANUS AI collaboration standard: `standards/ai-collaboration/ai-collaboration-rules.md` in `janus-engineering`
Human responsibilities: `standards/ai-collaboration/human-responsibilities.md` in `janus-engineering`

---

## Scope in {{SERVICE_NAME}}

Claude Code assists with implementation work in `{{SERVICE_REPO}}`. The scope below is specific to this service.

---

## Authorized Activities in This Service

| Activity | Authorized? | Notes |
|---|---|---|
| Writing implementation code within approved architecture | Yes | Must pass lint + type check |
| Writing unit and integration tests | Yes | Must follow `docs/testing/testing-strategy.md` |
| Writing documentation for completed features | Yes | Documentation only — no future-state speculation |
| Suggesting refactors | Yes | Propose only; human approves |
| Identifying technical debt | Yes | Must open a GitHub Issue |
| [[FILL: Service-specific activity]] | [[FILL: Yes/No]] | [[FILL: Notes]] |

---

## Prohibited Activities in This Service

- Modifying any file in `docs/architecture/adr/` (ADRs are human-only)
- Modifying `docs/governance/` without explicit instruction
- Adding or removing dependencies
- Modifying `tsconfig.json`, `eslint.config.js`, or `.janus-compliance.yaml`
- Committing directly to `main` or `develop`
- Reading, generating, or storing production data
- [[FILL: Any service-specific prohibitions]]

---

## Service-Specific Rules for Claude Code

[[FILL: Rules specific to this service's domain that Claude Code must follow. Examples:
- "Never generate or suggest database migration files without a human-authored migration template"
- "All API endpoint implementations must include OpenAPI JSDoc annotations"
- "Do not generate seed data for the production database"
If none, remove this section.]]

---

## Output Quality Requirements

Before presenting any code:
1. It passes `pnpm lint` (no errors)
2. It passes `pnpm tsc --noEmit` (no type errors)
3. It includes tests if it introduces new logic
4. It does not use `any`, `as`, or `!` without a comment explaining why

---

## Handoff Protocol

When Claude Code completes a task, state:
- What was implemented
- What assumptions were made (flag with `<!-- ASSUMPTION: -->` in code)
- What tests cover the change
- What requires human review before the PR is opened
