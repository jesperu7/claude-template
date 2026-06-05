---
name: check-rules
description: Validate the Claude setup — run the drift detector and report in a readable form. Explicit-only.
disable-model-invocation: true
---
# /check-rules

Run the setup validator and present the results clearly.

## Steps
1. Run: `bash .claude/hooks/validate-claude-setup.sh`
2. Parse its output (it emits a `systemMessage` JSON when there are findings, nothing when healthy).
3. Report:
   - ✅ "Setup healthy" if there were no findings.
   - ⚠️ List each problem (stale `globs:` key, zero-match `paths:` glob, missing indexed guide).
   - ℹ️ List each info item (guide present but not indexed).
4. For each problem, state the one-line fix (rename `globs:`→`paths:`, fix the glob, add/remove the guide from the index).

Do not change any files automatically — report only, then ask before fixing.
