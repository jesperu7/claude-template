# Working Approach

*Unconditional rule — applies every session. This file is stack-agnostic and works as-is.*

## Research before proposing
- Before suggesting an approach, look up how the codebase already does it. Grep 2-3 real examples and read them.
- Never guess an API, a type, or a file's contents — open it and check.
- If something is ambiguous, find the answer in the code before asking.

## Minimal and correct
- Implement exactly what was asked — no more, no less.
- When the user says "A and B, not C" → do ONLY A and B. Don't add C "to be helpful".
- Don't add speculative abstractions, options, or edge-case handling that wasn't requested.
- Don't simplify with hacks or workarounds either. The right solution fits the existing architecture and addresses the root cause.

## Use direct tools
- Prefer reading and editing files directly over describing what could be done.
- Run the analyzer/tests yourself rather than telling the user to.
- Verify your change actually works before reporting it done.

## No filler
- Skip preamble, restating the question, and summaries of what you're about to do.
- Don't pad answers with caveats or apologies.
- When you finish a task, say what changed in a sentence or two — don't narrate every step.

## Check before final answer
- Re-read every line you changed before saying you're done.
- Confirm it follows the zero-tolerance rules and the patterns from your grep examples.
- If you changed something, make sure analysis/format/tests pass.
