# TypeScript Baseline

**Classification:** [JES] JANUS Engineering Standard
**Suite Version:** 1.0.0
**Binding Level:** Mandatory-if-applicable
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06
**Ecosystem ADR:** [ADR-E004](../../adr/ecosystem/ADR-E004-typescript-primary-language.md)

Applies to: all JANUS services with TypeScript surfaces (web apps, backend APIs, Edge Functions, shared packages).

---

## Required `tsconfig.json` Structure

All TypeScript projects extend the JANUS base configuration:

```json
{
  "extends": "@janus/tsconfig/base.json",
  "compilerOptions": {
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

---

## The `@janus/tsconfig` Package

The canonical base configuration is published as `@janus/tsconfig`. Two variants:

**`base.json`** — For all TypeScript projects:
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "lib": ["ES2022"],
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "exactOptionalPropertyTypes": true,
    "noPropertyAccessFromIndexSignature": true,
    "forceConsistentCasingInFileNames": true,
    "skipLibCheck": false,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "resolveJsonModule": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "isolatedModules": true
  }
}
```

**`strict.json`** — For packages and security-critical code (extends base, adds stricter options):
```json
{
  "extends": "./base.json",
  "compilerOptions": {
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "alwaysStrict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "useUnknownInCatchVariables": true
  }
}
```

---

## Non-Negotiable Rules

**`strict: true` is always on.** No service may disable strict mode. No exception, no waiver. The cost of fixing strict-mode violations is always lower than the cost of the bugs they prevent.

**`any` is a last resort.** When `any` is necessary:
- It is accompanied by a comment explaining why the type cannot be expressed
- It is never used as a lazy escape from a complex type
- It is never used in function signatures that cross module boundaries
- Prefer `unknown` over `any` when the type is genuinely unknown

**Type assertions (`as`) require justification.**
```typescript
// Wrong
const user = data as User

// Correct
// We have validated the shape of `data` against the User schema above
const user = data as User
```

**Non-null assertions (`!`) require justification.**
```typescript
// Wrong
const name = user!.name

// Correct — user is guaranteed non-null by the authentication middleware
const name = user!.name
```

**No `@ts-ignore` or `@ts-nocheck`.** These suppress TypeScript's ability to protect you. If TypeScript is reporting an error, the error is real. Fix it.

**`skipLibCheck: false`.** Type errors in declaration files are real errors. They indicate a version mismatch or a package type quality issue.

---

## TypeScript Version

The minimum TypeScript version across all JANUS services is defined in `@janus/tsconfig/package.json` as a peer dependency. Services may use newer versions but not older.

TypeScript is never pinned to a patch version — the minor version is the minimum. Patch updates are applied automatically.

---

## Path Aliases

Services using path aliases configure them in both `tsconfig.json` and the bundler/runtime:

```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

Path aliases are documented in the service's `docs/architecture/repository-standards.md`. Engineers who are new to the service must be able to understand the alias map without guessing.

---

## Deno / Edge Function TypeScript

Services with Supabase Edge Functions use Deno's TypeScript environment. The base tsconfig principles apply, but the configuration is adapted for Deno:

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "deno.ns"],
    "strict": true,
    "noUncheckedIndexedAccess": true
  }
}
```

The Deno Edge Function tsconfig is maintained separately from the main application tsconfig.
