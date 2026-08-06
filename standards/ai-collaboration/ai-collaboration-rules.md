# AI Collaboration Rules

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Core Principle

AI tools are implementation assistants. They are not architects, decision-makers, reviewers, or authorities. The distinction matters because accountability is a human property. When AI-generated code ships, the human who reviewed and approved it is accountable for it — not the tool.

---

## Approved AI Tools

| Tool | Role | Authorized Scope |
|---|---|---|
| Claude Code | CSA's implementation assistant (service and ecosystem level) | Drafting governance, ADRs, code, migrations, documentation, CI configuration, analysis |
| Cursor | In-editor code completion and refactoring | Code completion, inline refactoring, test generation within open files |
| ChatGPT / equivalent | External research and brainstorming | Research, ideation, learning — not production artifacts |

No other AI tool is authorized for use in JANUS development without an ADR documenting the tool, its scope, and the oversight model.

---

## What AI Tools Cannot Do

AI tools — regardless of capability — do not:

- **Approve pull requests** — PR approval is a human responsibility. It cannot be delegated.
- **Create or accept ADRs** — Architectural decisions are made by humans. AI tools draft; humans decide.
- **Modify governance documents** — Governance documents derive their authority from human ratification. AI-drafted governance that has not been reviewed and ratified by the CSA is not governance.
- **Make architectural decisions** — The question of what to build and how to structure it is answered by the CSA, informed by AI analysis.
- **Commit to shared branches** — AI tools do not commit on behalf of engineers. Engineers commit.
- **Deploy to any environment** — Deployment is authorized by humans. AI tools do not trigger deployments.
- **Access production systems** — AI tools do not connect to production databases, APIs, or infrastructure.

---

## Universal Rules

These rules apply to every AI tool, in every context, without exception:

1. **No unreviewed AI output is committed.** Every AI-generated line of code, documentation, or configuration is reviewed by the engineer before it enters the codebase. "The AI generated it" is not a substitute for understanding it.

2. **No secrets in AI prompts.** API keys, database passwords, JWTs, credentials, production data, and PII are never included in prompts sent to any AI tool. This applies even to Claude Code sessions — secrets are in environment variables, not in conversation context.

3. **No architectural decisions from AI.** AI tools analyze and propose. Humans decide and commit. The moment an engineer says "the AI decided this," the governance model has failed.

4. **Security-sensitive output is independently verified.** Code that handles authentication, authorization, cryptography, or secret management — generated or suggested by any AI tool — is reviewed by the CSA before merging. "AI-generated" is not a mitigating factor in a security review; it is a reason for additional scrutiny.

5. **JANUS documentation takes precedence over AI suggestions.** When Claude Code or any AI tool suggests something that conflicts with the standards in `janus-engineering` or the service's governance documents, the documentation wins. The tool is updated with the correct constraint, not the documentation updated to match the tool's suggestion.

6. **Prompt quality is the engineer's responsibility.** A vague prompt produces vague output. An engineer who accepts vague output is responsible for the result. Engineers are accountable for the quality of the prompts they write and the outputs they accept.

---

## Documenting AI Contributions

When a significant portion of a PR was AI-assisted:
- The PR description notes this: "Drafted with Claude Code assistance; reviewed and modified by engineer."
- The commit message may include `Co-Authored-By: Claude Sonnet 4.x <noreply@anthropic.com>`
- There is no stigma in AI assistance; there is only accountability for what ships

---

## AI in the Architectural Order

| Phase | AI can assist with | Human must own |
|---|---|---|
| Vision | Researching comparable systems, drafting initial vision document | The vision itself |
| Governance | Drafting all governance documents | Review, ratification, all decisions |
| Architecture | Drafting ADRs, analyzing options | Accepting ADRs, making decisions |
| Documentation | Drafting all documents | Accuracy review, approval |
| Specification | Identifying edge cases, drafting acceptance criteria | Defining requirements, accepting criteria |
| Database | Drafting schema documents, drafting migrations | Schema review, migration approval |
| API | Drafting OpenAPI specs, drafting error catalogs | Contract decisions, approval |
| Implementation | Writing code, writing tests, writing CI configuration | Code review, PR approval, merge |
| Testing | Writing test cases, analyzing coverage gaps | Test strategy decisions, coverage thresholds |
| Deployment | Drafting deployment configuration | Deployment authorization |
| Automation | Drafting automation workflows | Workflow approval, monitoring setup |
| Optimization | Analyzing performance data, proposing optimizations | Performance baseline decisions, approving optimizations |

---

## Managing AI Tool Drift

AI tools update frequently. A tool's suggestions may drift from the JANUS standards without notice.

When an AI tool consistently suggests patterns that conflict with JANUS standards:
1. Update the tool's instruction file (`CLAUDE.md`, `.cursor/rules/`) to explicitly prohibit the conflicting pattern
2. Document the update in the PR description
3. If the conflicting pattern represents a better approach than the current standard, open an RFC via janus-engineering

The tool adapts to the standards. The standards do not adapt to the tool.

---

## AI-Caused Incident Response

If a defect introduced by AI-generated code reaches production:
- The incident is handled identically to any other production incident
- The post-mortem includes an analysis of how the AI-generated code passed review
- The review process is updated to prevent the same gap
- The tool's instruction file is updated if the AI tool's suggestion pattern contributed to the defect

The root cause analysis focuses on the review process, not on the AI tool. The AI tool did what it does. The review process is what failed.
