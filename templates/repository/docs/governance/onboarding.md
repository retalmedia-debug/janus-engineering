<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/governance/onboarding.md -->

# Onboarding Guide

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## Before You Begin

Read in this order before touching any code:

1. `docs/governance/repository-governance.md` — authority and decision model
2. `docs/architecture/engineering-principles.md` — how we think
3. `docs/governance/development-workflow.md` — how we work
4. `docs/governance/definition-of-done.md` — what done means

---

## Prerequisites

| Tool | Version | Install |
|---|---|---|
| Node.js | 20 LTS | https://nodejs.org or `nvm` |
| pnpm | 9+ | `npm install -g pnpm` |
| Git | 2.40+ | System or https://git-scm.com |
| [[FILL: e.g., Supabase CLI]] | [[FILL: version]] | [[FILL: install command]] |
| [[FILL: e.g., Docker]] | [[FILL: version]] | [[FILL: install command]] |

---

## Environment Setup

### 1. Clone the repository

```bash
git clone git@github.com:janus/{{SERVICE_REPO}}.git
cd {{SERVICE_REPO}}
```

### 2. Install dependencies

```bash
pnpm install
```

### 3. Set up environment variables

```bash
cp .env.example .env.local
```

Open `.env.local` and fill in the required values. See `.env.example` for descriptions of each variable.

### 4. [[FILL: Start local services]]

```bash
# Example for Supabase:
# supabase start
# Then update .env.local with the local service URLs from the supabase start output
```

### 5. Run the application locally

```bash
[[FILL: pnpm dev or pnpm start]]
```

---

## First Run Verification

```bash
pnpm lint       # Should pass with no errors
pnpm tsc        # Should pass with no errors
pnpm test       # Should pass — all tests green
```

---

## Your First PR

1. Pick up a `good-first-issue` labelled issue
2. Create a branch from `develop`
3. Follow `docs/governance/development-workflow.md`
4. Open a draft PR early for feedback if needed
5. Complete the Definition of Done checklist before requesting review

---

## Who to Ask

| Question | Contact |
|---|---|
| Architecture decisions | {{SERVICE_CSA}} |
| Governance / standards | JANUS Principal Architect |
| [[FILL: domain-specific questions]] | [[FILL: name]] |
| Blocked or stuck | {{SERVICE_CSA}} via [[FILL: Slack channel or email]] |

---

## Service-Specific Notes

[[FILL: Add any service-specific setup complexity, common gotchas, or things that aren't obvious from the standard process. If none, remove this section.]]
