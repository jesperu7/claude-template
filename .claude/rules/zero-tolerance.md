# Zero Tolerance Rules

*Unconditional rule — loads every session, re-injected after `/compact`. This is the canonical enforced list; `CLAUDE.md` only teases the top items.*

## What goes in this file

Your project's hard non-negotiables — things that are NEVER acceptable in new code. For each, write
three lines: what's forbidden, the correct alternative, and a one-line reason. Aim for 6–10. If
everything is zero-tolerance, nothing is — keep it to rules you'd block a PR over.

Think about: unsafe language features the team has banned, patterns you're migrating away from,
things that have caused real incidents, and whatever a reviewer always flags.

## Format to follow

```
### ❌ <short rule name>
**Never:** <what's forbidden>
**Instead:** <the correct pattern>
**Why:** <one line>
```

## Common across Flutter projects (keep the ones that apply)

### ❌ No force-unwrap (`!`)
**Never:** `value!`
**Instead:** null-safe handling (nullable types, Dart 3 patterns, `??`).
**Why:** force-unwrap crashes at runtime instead of failing safely.

### ❌ No `print()`
**Never:** `print('debug')`
**Instead:** the project's logger.
**Why:** `print` leaks to production and can't be filtered.

### ❌ No non-exhaustive enum handling
**Never:** `if/else` chains or `default:` over an enum.
**Instead:** an exhaustive `switch` so new cases force a compile error.
**Why:** silent fall-through when the enum grows.

## Project-specific — FILL IN

> These depend on YOUR architecture / state management / DI. Write the ones that apply, e.g.:
> - your DI rule (e.g. "no global service locator in new code → <your DI approach>")
> - your layering rule (e.g. "no business logic in <your UI layer> → <your logic layer>")
> - your forbidden module (covered in detail in `legacy-forbidden.md`, summarize here)

## Your rules below

