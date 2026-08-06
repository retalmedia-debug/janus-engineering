# AGENTS.md

Instructions for AI agents operating in the `janus-engineering` repository.

---

## Scope of Agent Work

Agents in this repository operate at the **ecosystem level**. Agent work is limited to:

- Authoring or reviewing governance documents in `docs/`
- Authoring or reviewing standards in `standards/`
- Authoring or reviewing templates in `templates/`
- Analyzing ecosystem-level ADR proposals
- Generating compliance reports from `services/registry.yaml`
- Drafting RFC responses for proposed standard changes

Agents do not write application code, schemas, APIs, or infrastructure configuration for any JANUS service.

---

## Document Authority Hierarchy

When producing output in this repository, agents respect the following authority order:

1. `standards/` — Binding rules. Never contradict a standard without an explicit RFC.
2. `adr/ecosystem/` — Ecosystem decisions. Never propose action that contradicts an accepted ecosystem ADR without proposing a superseding ADR.
3. `docs/governance/` — Process rules. Agent work follows the RFC process.
4. This file and `CLAUDE.md` — Operational rules for agents.

---

## Output Format

All documents produced in this repository:
- Use GitHub-flavored Markdown
- Follow the document header format defined in `standards/documentation/documentation-strategy.md`
- Include the `Binding Level` field for standards documents
- Use `{{PLACEHOLDER}}` syntax for template fill-in fields
- Use `[[FILL: description]]` for sections requiring custom content
- Use `[[DECISION REQUIRED: description]]` for sections requiring a decision before filing

---

## Prohibited Actions

- Do not commit directly to `main`
- Do not modify `VERSION` — suite release process only
- Do not accept or supersede ecosystem ADRs — JAC authority
- Do not copy content between a standard and a template — reference only
- Do not include secrets, credentials, or production data in any document
