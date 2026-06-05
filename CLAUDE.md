# <PROJECT NAME> — Claude Quick Reference

> **This file is always loaded in full, every session**, and re-injected after `/compact`.
> Keep it lean — everything here costs context on every turn. Detailed material belongs in a scoped
> rule (`.claude/rules/`) or an on-demand guide (`docs/claude/`).
> See `.claude/SETUP.md` for how the whole setup fits together, and `GETTING-STARTED.md` to fill this in.
>
> **HOW TO FILL THIS IN:** the project is Flutter/Dart, so the commands and code-fence language are
> already set. The parts that differ per project — architecture, state management, DI — are written
> as `FILL IN:` prompts describing what to put there and what to consider. Replace each prompt with
> your project's reality. Sections marked `<…>` are placeholders.

# CORE PRINCIPLES

# Always think instead of reducing quality
# Always check every line before giving a final answer
# Don't make assumptions, look up the actual code implementation
# When user says "A and B, not C" → implement ONLY A and B, never add C

# SOLUTION QUALITY
- Find the **best** solution that is also the **simplest and most elegant** — aligned with the architecture and requirements
- Don't simplify for simplicity's sake (hacks, workarounds) and don't over-engineer (unnecessary abstractions, excessive edge case handling)
- The right solution addresses the root cause, fits the existing architecture, and results in clean readable code
- Before proposing any approach: **grep 2-3 existing examples** of the same pattern in the codebase — this is not optional

> CORE PRINCIPLES and SOLUTION QUALITY are project-agnostic — keep them as-is. Everything below is tailored per project.

# ZERO TOLERANCE RULES

Full enforced list → `.claude/rules/zero-tolerance.md` (loads every session, re-injected after `/compact`).
Area-specific rules load from their path-scoped rule file when you open a matching file.

The non-negotiables, always in view:
> FILL IN: your 6–10 hardest "never do this" rules, one line each, as `❌ <forbidden> → <correct alternative>`.
> Pick the ones you'd block a PR over. Some are common across Flutter projects (below); add/remove for yours.
❌ no `!` / force unwrap → nullable types + exhaustive handling
❌ no `print()` → use the project's logger
❌ no `if/else` / `default` over an enum → exhaustive `switch`
> FILL IN: project-specific ones, e.g. your DI rule, your "no business logic in X layer" rule, your forbidden module.

# QUICK COMMANDS

```bash
dart analyze lib/<module>/ --fatal-infos      # Before changes (scoped to what you're touching)
dart analyze --fatal-infos                    # After changes (full project)
flutter test path/to/test.dart                # Run a test
dart format -l <N> <file1> <file2>            # Format ONLY changed files — never *.g.dart, never all of lib/
```
> FILL IN: confirm your line length (`-l`) and add any project-specific commands (codegen, build_runner, melos, etc.).

# PRE-COMMIT CHECKS

```bash
dart analyze --fatal-infos                    # unused imports, dead code
dart format -l <N> <changed files only>
```
Manual review items are the ZERO TOLERANCE list above.

# QUICK PATTERNS

> FILL IN: 5–15 lines of the idioms developers reach for daily IN THIS PROJECT, so Claude copies the
> right ones instead of guessing. This is the most project-specific section — it depends on your
> architecture, state management, and DI choices. Cover whichever of these apply:
>   - **Dependency injection:** how a class receives its dependencies, and how they're resolved/registered
>     (constructor injection, a service locator, a provider/scope, an injected widget, etc.).
>   - **State management:** how a unit of state is declared, updated, and observed by the UI
>     (your chosen approach — Bloc/Cubit, Riverpod, Provider/ChangeNotifier, signals, MobX, etc.).
>   - **Layer base classes / contracts:** what a ViewModel/Controller/Notifier extends or implements.
>   - **Error/result handling:** how fallible operations report success vs failure (a Result/Either type,
>     typed exceptions, etc.) — keep it consistent with `error-handling-rules.md`.
>   - **Null-safety idiom:** the team's preferred null-safe pattern (Dart 3 patterns, etc.).
>
> Show them as short real snippets from your codebase. Example of the *format* (not the *content*):
> ```dart
> // DI: <how this project does it>
> // State: <how this project declares/updates/observes state>
> // Result: <this project's success/failure type>
> ```

# MANDATORY WORKFLOW (For Claude)

**Before writing ANY code, complete these steps in order.**

## Step 1: GREP for examples
Find 2-3 similar real examples and read them before writing anything:
```bash
grep -r "<your ViewModel/Controller base>" lib/   # FILL IN: how you'd find existing units of this kind
grep -r "<your result/error type>" lib/           # FILL IN
```
> FILL IN: replace with grep patterns that surface real examples of your architecture's building blocks.

## Step 2: VERIFY against zero-tolerance rules
Check EVERY line of planned code against the rules above. Fix ALL violations, not just the main one.

## Step 3: IMPLEMENT
Write code following the grep examples + auto-loaded rules. Run scoped `dart analyze` while working.

## Step 4: ANALYZE & FORMAT
Run full `dart analyze --fatal-infos`, then `dart format` on changed files only. Review the relevant checklist below.

# ARCHITECTURE

> FILL IN: a one-line layer diagram for THIS project and one line on what belongs in each layer.
> Projects differ — yours might be layered, feature-first, clean architecture, MVVM, MVC, etc.
> Examples of the *format* (pick/adapt to your reality, don't keep all):
> ```
> VIEW → VIEWMODEL → DOMAIN → REPOSITORY → DATA SOURCE      (layered MVVM)
> UI → CUBIT/BLOC → REPOSITORY → SERVICE                    (Bloc)
> WIDGET → PROVIDER/NOTIFIER → REPOSITORY → SERVICE         (Riverpod/Provider)
> ```
> Then state, in one line, where business logic lives, where UI state lives, and how DI is done.

# CHECKLISTS

> FILL IN: short checklists for the artifacts your team builds most often. Name them after YOUR
> building blocks (ViewModel, Cubit, Notifier, Controller, Repository, Service, Route, Widget…).
> Keep each to a few bullets. One generic example:

## New <unit of state/logic>
- [ ] Lives in the correct layer; UI state and business logic are not mixed
- [ ] Dependencies received via your DI approach (not reached for globally, unless that's your standard)
- [ ] State is observed by the UI through your state-management approach
- [ ] No user-visible strings hardcoded — resolved via localization

## Before PR
- [ ] `dart analyze --fatal-infos` passes
- [ ] Format applied to modified files only
- [ ] Zero-tolerance checklist clean
- [ ] Manual testing complete

# DETAILED GUIDES (read on demand)

Deep-dive docs in `docs/claude/` — read the relevant one before substantial work in that area.
Keep this index in sync with the files that actually exist (the SessionStart hook warns if an
indexed guide is missing):
- `architecture.md` — layers, DI, where logic lives
- `state-management.md` — state & event patterns
- `testing.md` — test strategy
- `code-style.md` — naming, file organization rationale
- `common-violations.md` — anti-patterns checklist

Path-scoped rules in `.claude/rules/` load automatically when you open matching files; unconditional rules load every session.
