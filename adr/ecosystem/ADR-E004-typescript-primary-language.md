# ADR-E004: TypeScript as Primary Language

**Date:** 2026-08-06
**Status:** Accepted
**Decider:** JANUS Principal Architect
**Consulted:** ATLAS Chief Software Architect
**Services Impacted:** All services with web or API surfaces
**Migration Lead Time Required:** Immediate
**Grace Period:** N/A

---

## Context

JANUS services with web frontends, backend APIs, Edge Functions, and shared packages require a primary programming language for application code. Selecting a single primary language enables:
- Shared tooling configuration (ESLint, tsconfig, Prettier)
- Type-safe shared packages across the ecosystem
- A single code quality standard
- Engineers who move between services without a language context switch

This decision applies to application code surfaces — web apps, backend APIs, Edge Functions, and shared packages. Scripting, infrastructure configuration, and SQL are not in scope.

---

## Options Considered

### Option A: TypeScript

Typed superset of JavaScript.

**Pros:**
- Strict type safety catches an entire class of bugs at compile time
- Industry standard for Node.js backends and React frontends
- First-class Deno support for Supabase Edge Functions
- Rich ecosystem for web, API, and shared package development
- Type declarations allow shared types across packages with compile-time validation
- `@janus/tsconfig` and `@janus/eslint-config` can be published and shared across all services
- Engineers with JavaScript experience can adopt TypeScript incrementally

**Cons:**
- Build step required (TypeScript must be compiled to JavaScript)
- Type errors can be frustrating when TypeScript is applied to complex generic patterns
- `strict: true` requires more upfront type work than plain JavaScript

### Option B: Plain JavaScript

**Pros:**
- No compilation step
- Simpler tooling

**Cons:**
- No compile-time type safety — an entire class of bugs is only discoverable at runtime
- Shared packages cannot expose type information to consumers
- Code review cannot rely on types to verify contract compliance
- Inconsistent with industry direction for production Node.js applications

### Option C: Python (for backend services)

**Pros:**
- Strong data processing and ML ecosystem
- Familiar to data engineers

**Cons:**
- Introduces a second primary language for a frontend/API ecosystem
- No frontend support (React requires JavaScript/TypeScript)
- Engineers must context-switch between languages when moving between service layers
- Cannot share types between Python backend and TypeScript frontend — manual contract synchronization required

---

## Decision

**TypeScript** is the primary language for all JANUS services with web or API surfaces.

The decisive factors:
1. Type safety is not optional in a production system. The compile-time feedback that TypeScript provides eliminates a category of bugs (wrong field names, incorrect function signatures, null dereference) that plain JavaScript exposes only at runtime.
2. Shared types across the ecosystem (between packages, between services via published type packages) are possible only with TypeScript. Plain JavaScript cannot enforce contract compliance at development time.
3. Supabase Edge Functions run on Deno, which has first-class TypeScript support — the same language runs in both the web client and the backend API layer.
4. `@janus/tsconfig` and `@janus/eslint-config` can be maintained once and distributed to all services, creating a consistent baseline across the ecosystem without per-service configuration effort.

---

## Consequences

**Positive:**
- Compile-time type errors catch bugs before they reach production
- Shared type packages allow compile-time verification of inter-service contracts
- Single language for web, API, and shared packages — engineers move between service layers without language context switch
- `strict: true` enforced across all services via `@janus/tsconfig`

**Negative / Trade-offs:**
- TypeScript's build step adds complexity to CI/CD pipelines
- Complex generic types can be difficult to express and maintain
- `strict: true` requires initial investment in correctly typing code that would be ambiguous in plain JavaScript

**Risks:**
- TypeScript version incompatibilities between services — mitigated by the `@janus/tsconfig` package which declares the minimum TypeScript version as a peer dependency
- Engineers who are unfamiliar with TypeScript's type system may reach for `any` — mitigated by `@typescript-eslint/no-explicit-any: error` in `@janus/eslint-config`

**Scope:**
- This ADR covers: web apps, backend APIs, Edge Functions, shared npm packages
- This ADR does not cover: infrastructure-as-code, shell scripts, SQL, n8n workflows
- Services whose domain is primarily data processing or ML may extend this ADR via a service-level ADR

**Migration path:**
All new JANUS services use TypeScript from inception. `@janus/tsconfig` is adopted via `package.json` devDependency on first commit.
