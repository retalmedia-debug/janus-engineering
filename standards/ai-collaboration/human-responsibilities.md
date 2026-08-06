# Human Responsibilities

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Purpose

As AI tools become increasingly capable at generating code, documentation, and architectural analysis, the question of what humans must own becomes more important, not less. This document defines the responsibilities that are permanently and unconditionally owned by humans across all JANUS services.

These responsibilities cannot be delegated to AI tools in any context, at any capability level, for any reason. They are not delegated because AI tools lack organizational context, ethical accountability, or the standing to make commitments on behalf of teams. They are not delegated because the consequences of errors in these areas extend beyond the technical and into the organizational.

---

## Non-Delegable Human Responsibilities

### 1. Strategic and Architectural Decisions

Choosing between architectural options, setting engineering principles, accepting or rejecting ADRs, deciding the technology stack, defining the long-term direction of a service.

Architectural decisions encode business priorities, risk tolerances, team capabilities, and organizational context that AI tools do not have full access to or accountability for. An AI analyzes options; a human with full organizational context decides which option is right.

**Examples:**
- Accepting or rejecting an ADR
- Deciding the scope of a service within the JANUS ecosystem
- Deciding which capabilities to build versus buy versus integrate
- Setting the release strategy and timeline

### 2. Security Decision-Making

Reviewing authentication and authorization implementations, evaluating the security implications of architectural decisions, determining whether a security vulnerability requires immediate action, and setting security baseline requirements.

Security mistakes are often subtle, context-dependent, and produce consequences that are not apparent until production exploitation. AI tools can identify common vulnerability patterns but cannot fully reason about the attack surface specific to a service's deployment context, threat model, and data sensitivity.

**Examples:**
- Approving any code that handles JWT validation, RLS policies, or credential management
- Deciding the incident response when a security issue is discovered
- Setting the data classification for new types of sensitive data
- Evaluating whether a dependency introduces an unacceptable security risk

### 3. Code Review and Approval

The act of reviewing a PR, assessing it as complete and correct, and approving and merging it.

Code review is the primary quality gate for the shared codebase. The reviewer accepts responsibility for the code they approve. AI tools assist in reviewing by flagging potential issues — they do not bear responsibility. Responsibility is a human concept.

**Examples:**
- All PR approvals and merges
- The final judgment on whether a PR satisfies the Definition of Done
- The decision to waive a quality gate for a specific PR

### 4. Production Operations Decisions

Deciding whether to deploy, when to roll back, how to respond to an incident, and what constitutes an acceptable service state.

Production operations affect real users. Decisions made during production incidents are time-pressured, high-consequence, and require judgment about acceptable risk that involves business context beyond the system's technical state.

**Examples:**
- Authorizing a production deployment
- Deciding to initiate a rollback
- Declaring an incident and initiating the incident response process
- Deciding to accept a known issue as a measured risk versus blocking the release

### 5. Requirements and Specifications

Defining what the system must do, who it serves, what constitutes correct behavior, and what the acceptance criteria are for a feature.

Requirements emerge from understanding of the business domain, user needs, and strategic goals. AI tools can help refine and clarify specifications, but the specification itself must originate from and be owned by a human with authority over the product direction.

**Examples:**
- Writing the acceptance criteria for a feature
- Deciding which edge cases are in scope
- Deciding what constitutes "done" for a milestone
- Defining the data model for a new domain entity

### 6. Governance and Policy

Creating, modifying, and ratifying governance documents, engineering principles, and standards.

Governance documents define the rules of the engineering system. Their authority derives from the humans who ratify them. An AI-drafted governance document that has not been reviewed and ratified by the CSA is a draft, not governance.

**Examples:**
- Approving any change to any document in `docs/governance/`
- Approving any change to the Engineering Principles
- Ratifying ADRs
- Granting exceptions to any documented rule
- RFC dispositions in the janus-engineering context

### 7. Human-to-Human Communication

Communicating status, risks, decisions, and concerns to teammates, stakeholders, and ecosystem partners.

Communication that affects people's understanding, decisions, or accountability must come from the human responsible for the subject matter. AI-drafted communication (a PR description, a release note) is acceptable and expected. AI-originated communication presented as coming from a human is not.

**Examples:**
- Communicating release decisions to stakeholders
- Communicating deprecation notices to JANUS ecosystem teams
- Escalating a risk or technical concern to leadership
- Conducting code review conversations with engineers

---

## The Accountability Chain

Every piece of work in a JANUS service has a human owner. When code is merged, a human approved it. When a decision is made, a human made it. When a deployment goes to production, a human authorized it.

AI tools extend human capability. They do not transfer human accountability.

If an AI tool generates code that contains a security vulnerability, the human who reviewed and approved that code is accountable for the vulnerability — not the tool. This accountability model is not punitive; it is the structural framework that ensures humans remain engaged and responsible in an AI-assisted development process.

---

## Annual Review

This document is reviewed annually to assess whether the boundaries defined here remain appropriate as AI tool capabilities evolve. Changes to this document require JAC approval at the ecosystem level and CSA approval at the service level. Changes that reduce human accountability require both JAC approval and documented rationale.

The annual review question: "Are there responsibilities listed here that AI tools now handle so reliably that human ownership is no longer necessary?" If the answer is yes for any responsibility, it requires an RFC, not a quiet update.
