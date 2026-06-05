# Error Handling Rules

*Unconditional rule — loads every session.*

## What goes in this file

How errors are represented, propagated, surfaced to the user, and logged in THIS project — so Claude
matches the codebase instead of inventing its own pattern. The right answers depend on your
architecture and chosen libraries, so this is mostly FILL IN.

## FILL IN — describe your project's approach to each

> - **Result vs throw:** do fallible operations return a result/either type, or throw typed
>   exceptions? Name the exact type and show how callers handle both success and failure.
> - **Exception structure:** is there a sealed/typed exception hierarchy? What may throw, what must not?
> - **Crossing layers:** how errors move from data/service layer up to the UI without leaking raw details.
> - **User-facing errors:** how an error becomes a localized, user-readable message; whether
>   backend-provided messages pass through unchanged.
> - **Logging:** which logger to use (never `print`), and the rule that no personal data is logged.

## Your rules below

