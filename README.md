# Apps Team — Claude Setup Template

A shared, layered Claude Code setup so every Apps project follows the same structure and we can
share skills, commands, hooks and rules across projects and developers.

Read `.claude/SETUP.md` first — it explains how the four layers fit together and what loads when.

## What's in here

```
CLAUDE.md                       # Always-on quick reference (FILL IN per project)
.claude/
├── SETUP.md                    # How the whole setup works (read this first)
├── settings.local.json         # Registers the SessionStart hook (use as-is)
├── hooks/
│   └── validate-claude-setup.sh# Drift detector (use as-is)
├── rules/
│   ├── approach.md             # ✅ ships ready — stack-agnostic, use as-is
│   ├── zero-tolerance.md       # FILL IN — your hard non-negotiables
│   ├── code-style-rules.md     # FILL IN
│   ├── error-handling-rules.md # FILL IN
│   ├── legacy-forbidden.md     # FILL IN
│   ├── viewmodel-rules.md      # FILL IN globs + content (path-scoped)
│   ├── service-rules.md        # FILL IN
│   ├── repository-rules.md     # FILL IN
│   ├── route-rules.md          # FILL IN
│   ├── ui-rules.md             # FILL IN
│   └── test-rules.md           # FILL IN
└── skills/
    └── check-rules/SKILL.md    # Validator with readable report (use as-is)
docs/claude/
├── README.md                   # Human index of guides
├── architecture.md             # FILL IN or delete
├── state-management.md         # FILL IN or delete
├── testing.md                  # FILL IN or delete
├── code-style.md               # FILL IN or delete
└── common-violations.md        # FILL IN or delete
```

## Ships ready (don't touch)
- `.claude/rules/approach.md`
- `.claude/hooks/validate-claude-setup.sh`
- `.claude/skills/check-rules/SKILL.md`
- `.claude/settings.local.json`
- The folder structure and layering itself

## Fill in per project
1. **`CLAUDE.md`** — replace every `<!-- PLACEHOLDER -->`: project name, zero-tolerance list,
   commands, quick patterns, architecture, checklists, guides index.
2. **Unconditional rules** — `zero-tolerance`, `code-style-rules`, `error-handling-rules`,
   `legacy-forbidden` for your stack.
3. **Path-scoped rules** — adjust each `paths:` glob to your real folders (cover singular AND plural),
   replace the `<!-- ext -->` extension placeholder, then fill the content.
4. **Guides** — keep the `docs/claude/` guides you need, write them, delete the rest and remove
   them from the index in `CLAUDE.md` and `docs/claude/README.md`.

## Verify
After filling in, run `/check-rules` (or `bash .claude/hooks/validate-claude-setup.sh`).
It warns about: stale `globs:` keys, `paths:` globs that match zero files, and guides indexed in
`CLAUDE.md` but missing from `docs/claude/`. A clean run means the wiring is correct.

## Team decisions to make once
- **Tracked vs untracked:** is `.claude/`, `CLAUDE.md` and `docs/claude/` committed to each repo, or
  shared by handing the folders over? Pick one convention for all Apps projects.
- **Shared vs per-project skills:** which commands live here as the shared baseline, and which are
  project-specific. Keep the shared ones identical across repos so they're interchangeable.
- **Extension & layer names:** if a project's architecture doesn't match the view-model/service/
  repository layering, rename the path-scoped rules to match its real layers.
