---
paths:
  - "**/test/**/*.dart"
  - "**/tests/**/*.dart"
---
# Test Rules

*Path-scoped — loads only when you open a file matching the `paths:` globs above.*

## ⚠️ First, adapt this file to YOUR architecture

This filename and its globs assume one common layering. Your project may differ — that's expected.
- If you have this layer under a different name, **rename this file** (e.g. `cubit-rules.md`,
  `notifier-rules.md`, `controller-rules.md`) and update the title.
- If you don't have this layer at all, **delete this file**.
- Edit the `paths:` globs above to match where these files actually live. The key MUST stay
  `paths:` (a YAML list) — Claude Code silently ignores `globs:`.
- Keep singular and plural lines only if your codebase uses both; otherwise delete one.
- After editing, run `/check-rules` — it warns if a glob matches zero files.

## What goes in this file

Rules for tests: what to test at which layer, structure and naming, the mocking approach, and what
NOT to test.

## FILL IN — describe the rules for this layer

> - Which layers get thorough coverage vs light coverage (depends on where your logic lives).
> - Test naming/structure convention.
> - How dependencies are mocked/faked; the rule against real network/disk in unit tests.
> - What not to test (generated code, framework internals).

## Your rules below

