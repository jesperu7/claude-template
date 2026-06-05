# Claude Setup — How This Project's AI Tooling Works

A map of every piece of the Claude Code setup in this repo and how they fit together.
This is the **Apps team standard layout** — every project follows the same structure so skills,
commands, hooks and rules can be shared across projects and developers.

> **Decide as a team whether these folders are tracked in git or shared manually.**
> This file is plain documentation — it is **not** auto-loaded and costs no context.

---

## The big picture — four layers + supporting tooling

```
ALWAYS IN CONTEXT          CLAUDE.md  +  unconditional rules  +  auto-memory index
  (every session)                │
                                 │  load when you open a matching file
ON FILE OPEN               path-scoped rules (.claude/rules/ with `paths:`)
                                 │
                                 │  Claude reads them when relevant / told to
ON DEMAND                  docs/claude/ guides  +  auto-memory topic files
                                 │
                                 │  you type /name
ON INVOKE                  /code-review · /check-rules · /read
```

Plus a **SessionStart hook** that warns if any of this drifts.

### What loads when

| Source | When it enters context | Survives `/compact`? |
|---|---|---|
| `CLAUDE.md` (root) | Every session, in full | ✅ re-injected |
| Unconditional rules (no `paths:`) | Every session | ✅ re-injected |
| Path-scoped rules (`paths:`) | When you open a matching file | ❌ reloads on next match |
| `docs/claude/*.md` guides | Only when Claude reads them | ❌ |
| Auto-memory index | Every session (first part) | ✅ |
| `/code-review`, `/check-rules`, `/read` | When invoked | n/a |

---

## Layer 1 — `CLAUDE.md` (root)

The always-on quick reference. Loaded in full every session and re-injected after `/compact`, so it holds the things that must apply on every turn: the zero-tolerance non-negotiables, quick commands, the mandatory workflow, an architecture summary, per-artifact checklists, and a `DETAILED GUIDES` index pointing at the `docs/claude/` deep-dives.

**Keep it lean** — everything here costs context every session. Detailed material belongs in a scoped rule or an on-demand guide.

---

## Layer 2 — `.claude/rules/`

Topic-scoped instructions. **The loading mechanism is the frontmatter key:**

- **No frontmatter** → loads **unconditionally** every session (same priority as `CLAUDE.md`, re-injected after `/compact`).
- **`paths:` frontmatter** (a YAML list of globs) → loads **only when Claude opens a file matching a glob**.

> ⚠️ The key must be **`paths:`** (Claude Code format), a YAML list — **not** `globs:` (the Cursor format). A `globs:` key is silently ignored, which makes a rule load unconditionally instead of scoped. The hook + `/check-rules` guard against this regressing.

### Unconditional (always-on)
Rules that apply everywhere: the full zero-tolerance list, code style, error handling, forbidden areas, and the general working approach.

### Path-scoped (load only in matching dirs)
One rule file per architectural area (view-models, services, repositories, routes, UI, tests).
Cover **singular and plural** directory names if your codebase mixes both — globs match path segments literally.

---

## Layer 3 — `docs/claude/`

Long-form "how/why" guides. **Not auto-loaded** — read on demand. `CLAUDE.md`'s `DETAILED GUIDES` index points at them so Claude knows they exist and can open the relevant one before substantial work. `README.md` is the human-facing index.

---

## The hook — drift detection (`SessionStart`)

`.claude/hooks/validate-claude-setup.sh`, registered as a `SessionStart` hook in `.claude/settings.local.json`. Runs once per session and **warns via a `systemMessage`** — non-blocking, silent when healthy.

It flags three ways the setup can silently break:
1. A rule `paths:` glob that matches **zero files** (folder renamed/moved → rule never loads).
2. A rule still using the stale **`globs:`** key.
3. A guide referenced in `CLAUDE.md`'s `DETAILED GUIDES` index that's **missing** from `docs/claude/`.

---

## Skills & commands

Invoked by typing `/name`.

| Command | File | What it does |
|---|---|---|
| `/code-review [base]` | `.claude/commands/code-review.md` | Review pipeline: applies unconditional rules **plus** path-scoped rules matching the changed files. Tailor the reviewer stages to your stack. |
| `/check-rules` | `.claude/skills/check-rules/SKILL.md` | On-demand run of the validator with a readable report. |
| `/read` | `.claude/commands/read.md` | Reads all instruction + documentation `.md` to refresh full context. |

---

## Maintenance & gotchas

- **Adding a rule:** drop a `.md` in `.claude/rules/`. Universal? No frontmatter. Area-specific? Add `paths:` as a YAML list of globs (cover singular *and* plural dir names). Run `/check-rules` to confirm the globs match real files.
- **Renaming a folder** can orphan a rule's glob silently — the SessionStart hook / `/check-rules` will warn.
- **Adding a guide:** put it in `docs/claude/`, add a line to `CLAUDE.md`'s `DETAILED GUIDES` index (or it'll show as an orphan).
- **Keep `CLAUDE.md` short**; push detail into a scoped rule or an on-demand guide.
- **Verify the whole setup anytime:** run `/check-rules`.

---

## Adopting this template in a new project

1. Copy the whole structure in.
2. Fill in `CLAUDE.md`, following the `FILL IN:` prompts (Flutter tooling is pre-set; architecture/state/DI are yours to describe).
3. Fill the unconditional rule files (`zero-tolerance`, `code-style`, `error-handling`, `legacy-forbidden`) for your stack.
4. Rename/adjust the path-scoped rule globs to match your folder layout, then run `/check-rules`.
5. Write the `docs/claude/` guides you actually need; delete the rest and remove them from the index.
6. `approach.md`, the hook, `/check-rules`, `/read` and `settings.local.json` work as-is — leave them alone.
