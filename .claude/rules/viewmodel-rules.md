---
paths:
  - "**/view_models/**/*.dart"
  - "**/view_model/**/*.dart"
---
# Presentation / State-Holder Rules

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

Rules for the layer that holds UI state and reacts to user actions — whatever your project calls it
(ViewModel, Cubit/Bloc, Notifier, Controller, Store).

## FILL IN — describe the rules for this layer

> - What this layer extends/implements in your project (the base class or contract).
> - What it MAY hold (UI state, view events) and what it must NOT (business logic, data access, navigation).
> - How it exposes state to the UI and how the UI observes it (your state-management approach).
> - How it receives dependencies (your DI approach).
> - Naming conventions and where these files live.

## Your rules below

