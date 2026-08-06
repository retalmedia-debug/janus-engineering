<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/engineering/naming-conventions.md -->

# Naming Conventions

**Suite Version:** {{JANUS_SUITE_VERSION}}
**Status:** Active
**Owner:** {{SERVICE_CSA}}
**Last Reviewed:** [[FILL: YYYY-MM-DD]]

---

## General Rules

- Names must be intention-revealing — a reader should not need to open the file or function body to understand what it does
- No abbreviations unless universally understood (`id`, `url`, `api`, `db`, `config`)
- No single-letter variables outside loop counters and math functions
- No generic names: `data`, `info`, `result`, `temp`, `obj`, `arr`

---

## TypeScript Naming

| Construct | Convention | Example |
|---|---|---|
| Variables and functions | `camelCase` | `getUserById`, `eventCount` |
| Classes | `PascalCase` | `UserRepository`, `AuthService` |
| Interfaces | `PascalCase`, no `I` prefix | `UserProfile`, `EventPayload` |
| Type aliases | `PascalCase` | `UserId`, `Timestamp` |
| Enums | `PascalCase` enum, `SCREAMING_SNAKE_CASE` values | `enum Status { ACTIVE, DELETED }` |
| Constants | `SCREAMING_SNAKE_CASE` | `MAX_RETRY_COUNT`, `DEFAULT_PAGE_SIZE` |
| Private class members | `camelCase` (no underscore prefix) | `this.userId` |
| Generics | Descriptive names preferred | `<TEntity>`, `<TResponse>` |

---

## File Naming

| Category | Convention | Example |
|---|---|---|
| Source files | `kebab-case.ts` | `user-repository.ts` |
| Test files | `kebab-case.test.ts` | `user-repository.test.ts` |
| Type files | `kebab-case.types.ts` | `user.types.ts` |
| Config files | `kebab-case.config.ts` | `database.config.ts` |
| Constants files | `kebab-case.constants.ts` | `http-status.constants.ts` |

---

## API Naming

| Element | Convention | Example |
|---|---|---|
| URL paths | `kebab-case`, plural nouns | `/api/v1/user-profiles` |
| Query parameters | `camelCase` | `?pageSize=20&sortBy=createdAt` |
| JSON fields | `camelCase` | `{ "createdAt": "...", "userId": "..." }` |
| Error codes | `SCREAMING_SNAKE_CASE` | `RESOURCE_NOT_FOUND`, `VALIDATION_FAILED` |

---

## Database Naming

| Element | Convention | Example |
|---|---|---|
| Tables | `snake_case`, plural | `user_profiles`, `audit_events` |
| Columns | `snake_case` | `created_at`, `user_id` |
| Indexes | `idx_table_column(s)` | `idx_events_user_id` |
| Foreign keys | `fk_table_referenced_table` | `fk_events_users` |
| Constraints | `chk_table_description` | `chk_events_status_valid` |

---

## {{SERVICE_NAME}} Domain Terminology

[[FILL: Define the domain-specific terms used in code for this service. Consistent naming prevents the proliferation of synonyms. Example: if the domain calls them "incidents" but earlier code called them "events," document the canonical term here.]]

| Domain Term | Code Name | Notes |
|---|---|---|
| [[FILL]] | [[FILL]] | [[FILL]] |
