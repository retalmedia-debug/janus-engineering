# Refactoring Policy

**Suite Version:** 1.0.0
**Binding Level:** Mandatory
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

---

## Definition

Refactoring is the disciplined restructuring of existing code without changing its observable behavior. The operational test: if the tests pass before and pass after without modification, it is refactoring. If the tests must change, behavior changed.

This definition matters because it determines what rules apply. Refactoring is not an excuse to make behavior changes without appropriate review. Refactoring that requires test changes is not refactoring — it is development.

---

## Types of Refactoring

### Type 1 — Inline Refactoring

Structural improvements made to code as part of a feature or fix PR, where the refactoring is directly related to the change being made.

**Rules:**
- The refactoring is within the same module being changed for another reason
- Does not significantly increase the PR size beyond the limits in the service's PR rules
- Mentioned explicitly in the PR description

**Approval:** Same as the containing PR.

### Type 2 — Dedicated Refactoring PR

A PR whose only purpose is refactoring, not feature addition or bug fixing.

**Rules:**
- No behavior changes — all existing tests pass without modification
- All tests that were passing before remain passing after
- The PR description explains what structural improvement is being made and why
- Does not introduce new features or fix bugs (these deserve their own PRs)

**Approval:** Engineer + one peer review.

### Type 3 — Planned Refactoring Initiative

Large-scale structural improvements spanning multiple files, modules, or architectural layers.

**Rules:**
- CSA approval before beginning
- An implementation plan is documented before any code is changed
- Each PR in the initiative leaves the codebase in a working, deployable state
- Progress is tracked as GitHub Issues
- Initiative has a defined scope and completion criteria

**Approval:** CSA approval for the initiative; standard PR approval for each PR.

---

## When Refactoring Is Not Permitted

- **During a feature freeze** — No refactoring within 48 hours of a planned release unless it is blocking the release
- **During active incident response** — No refactoring while an incident is ongoing
- **Speculative refactoring** — "I might want to add X later, so I'm restructuring now" is not refactoring; it is premature design
- **Cosmetic refactoring** — Changes that only reflect personal style preferences, with no functional or structural benefit, require no PR and should not be made

---

## Strangler Pattern for Large Replacements

When an entire module or system needs to be replaced, the Strangler Fig pattern is required:

1. New implementation is built alongside the old one
2. New implementation is gradually expanded to handle more cases
3. Old implementation is progressively restricted to fewer cases
4. Old implementation is completely removed when the new one handles all cases

Neither the old nor the new implementation is ever in a broken state during this transition. Transition PRs must each leave the system deployable.

---

## Quality Gates for All Refactoring

Before a refactoring PR is merged:
- [ ] All tests pass without modification to test assertions (test structure may change; test behavior may not)
- [ ] Coverage does not decrease
- [ ] Linting passes
- [ ] TypeScript compiles without error
- [ ] No new `any` types introduced
- [ ] Performance-critical paths have not regressed (benchmarks, if applicable)

---

## Refactoring vs. Rewriting

Refactoring preserves behavior. Rewriting replaces behavior with a new implementation.

A rewrite may be the right answer. But a rewrite is not refactoring — it is a development initiative that follows the Architectural Order, requires specification, and carries the risk profile of new development.

When the impulse is to "refactor" by rewriting from scratch, consider:
- Is the existing implementation understood well enough to know what behavior to preserve?
- Are there tests that define the existing behavior?
- If not, writing the tests first and then refactoring is safer than rewriting
