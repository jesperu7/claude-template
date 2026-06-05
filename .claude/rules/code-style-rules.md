# Code Style Rules

*Unconditional rule — loads every session.*

## What goes in this file

The conventions Claude should follow mechanically: naming, file organization, imports, formatting.
Only decided team conventions, not personal preference. If your linter/formatter already enforces
something, state it briefly and point at the config rather than re-explaining it.

## Common across Flutter/Dart projects (confirm these match your team)

### Naming
- Files: `snake_case.dart`. Types: `PascalCase`. Members/variables: `camelCase`. Private members: leading `_`.
- Booleans read as a question: `isLoading`, `hasError`.

### Formatting
- Run `dart format` on changed files only — never on `*.g.dart` or the whole project at once.
- FILL IN: your line length (the team's `-l` value).

## FILL IN — project specifics

> - File organization: one public class per file? section/region ordering? where helpers live?
> - Imports: ordering, package-vs-relative, whether barrel files are used, any forbidden imports.
> - Anything your architecture implies about where files of each kind live.

## Your rules below

