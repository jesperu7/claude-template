---
paths:
  - "**/routes/**/*.dart"
  - "**/route/**/*.dart"
---
# Routing / Navigation Rules

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

Rules for navigation — however your project routes (GoRouter, Navigator 2.0, auto_route, a custom
router). Adjust globs to where route definitions live.

## FILL IN — describe the rules for this layer

> - How a route/destination is defined in your router.
> - Naming conventions for paths and route names.
> - Parameter conventions (path vs query; required vs optional).
> - Any navigation helpers the team standardizes on.

## Your rules below

