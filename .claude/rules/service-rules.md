---
paths:
  - "**/services/**/*.dart"
  - "**/service/**/*.dart"
---
# Service Layer Rules

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

Rules for services — the units that wrap a single external concern (one API, one local store, one
platform capability). Rename/delete if your project structures this differently.

## FILL IN — describe the rules for this layer

> - The single-responsibility expectation for a service.
> - What a service may depend on, and how it receives those dependencies (your DI approach).
> - How external I/O is done and how failures are reported (consistent with `error-handling-rules.md`).
> - What must NOT appear in a service (UI, business rules).

## Your rules below

