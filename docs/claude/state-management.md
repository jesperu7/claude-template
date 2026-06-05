# State Management Guide

*Read-on-demand guide. Not auto-loaded. Claude opens this before substantial work in this area.*

## What goes in this file

How state is modeled and flows through the app in THIS project: how a unit of state is declared,
updated, and observed by the UI — using whatever approach the project has chosen.

This is the "how & why" companion to the enforced rules. Where a rule in `.claude/rules/`
says *what* is required, this guide explains *why* and shows real examples from the codebase.
Link to the matching rule file for the enforced specifics.

## FILL IN — cover the following for your project

> - The approach in use (Bloc/Cubit, Riverpod, Provider/ChangeNotifier, signals, MobX, custom…).
> - How a unit of state is declared and made immutable/comparable.
> - How the UI subscribes and rebuilds.
> - How one-shot effects (navigation, dialogs, snackbars) are handled vs persistent state.

> Write this with real snippets from your codebase. Or delete this guide if you don't need it —
> then remove its line from the `DETAILED GUIDES` index in `CLAUDE.md` and the table in `README.md`.
