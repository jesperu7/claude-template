# Getting Started — Adopting the Claude Setup in Your Project

This guide takes you from an existing project with **no Claude setup** to a fully working one,
step by step. It assumes you have **Claude Code already installed and logged in**, but assumes you
have **never set up rules, skills, or agent tooling before**. No prior experience needed.

Set aside about **60–90 minutes** for a first project. Most of that is you writing down things you
already know about your codebase — the structure does the rest.

---

## Part 0 — What is this, in plain terms?

Claude Code is an AI assistant that reads and writes code in your project. Out of the box it knows
nothing about *your* conventions — your architecture, your naming, the patterns you've banned. It
will guess, and its guesses won't match your team.

This template fixes that by giving Claude a set of **instruction files** it reads automatically.
Think of it as onboarding documentation, except the new hire is the AI and it reads the docs every
single time it works.

There are four kinds of files, and the only thing that matters at the start is *when each one is
read*:

| Folder / file | What it is | When Claude reads it |
|---|---|---|
| `CLAUDE.md` | The always-on cheat sheet | Every session, automatically |
| `.claude/rules/` | Detailed rules, one file per topic | Some always, some only when you open a matching file |
| `docs/claude/` | Long explanations ("why") | Only when needed |
| `.claude/commands/` & `.claude/skills/` | Things you trigger by typing `/name` | When you invoke them |

Plus one helper: a **hook** (`.claude/hooks/validate-claude-setup.sh`) that runs automatically and
warns you if the setup ever breaks. You don't have to understand it to use it.

> You do **not** need to read every file in the template before starting. Follow the steps below in
> order and you'll touch each file exactly when you need to.

---

## Part 1 — Copy the template into your project

1. Download/clone the template folder (`claude-template`).
2. Copy these into the **root of your project** (the top folder, where your `README` or build file
   lives):
   - the file `CLAUDE.md`
   - the folder `.claude/`
   - the folder `docs/claude/`  *(if you already have a `docs/` folder, just put the `claude/` subfolder inside it)*
3. Don't copy `GETTING-STARTED.md` or the template's own `README.md` into your project — those are
   instructions for *you*, not for Claude.

Your project should now contain:

```
your-project/
├── CLAUDE.md
├── .claude/
│   ├── SETUP.md
│   ├── settings.local.json
│   ├── commands/   (code-review.md, read.md)
│   ├── hooks/      (validate-claude-setup.sh)
│   ├── rules/      (11 files)
│   └── skills/     (check-rules/SKILL.md)
└── docs/claude/
    ├── README.md, claude-setup.html
    └── 5 guide files
```

> **Decide now: tracked or untracked?** Will these files be committed to git (so the whole team
> shares them) or kept local? For a shared team standard, **commit them**. If you'd rather keep them
> out of git, add them to `.gitignore`. Either works — just pick one and tell your team.

At this point nothing is filled in yet. The files contain a description of what goes in them plus a
worked example. You'll replace the examples next.

---

## Part 2 — Fill in the files (the main work)

Work through these in order. **Every fillable file follows the same shape:** a "What goes in this
file" description, then `FILL IN:` prompts telling you what to write and what to consider, then a
"Your content below" marker. Your job is to read the description, answer the prompts for your
project, and write your version where indicated.

> **The project is Flutter/Dart, so the tooling is already set** — commands like `dart analyze`,
> `flutter test`, and `dart format` are filled in for you. What's left as prompts is the stuff that
> genuinely differs **between Flutter projects**: your architecture, your state management, and your
> dependency injection. Those are written as `FILL IN:` notes rather than guessed-at examples,
> because there's no single right answer — Bloc, Riverpod, Provider, MVVM, clean architecture, a
> service locator vs constructor injection, etc. are all valid and the setup shouldn't push you toward one.

### Step 2.1 — `CLAUDE.md` (the most important file)

Open `CLAUDE.md` and replace each section, following the `FILL IN:` notes:

- **Project name** at the top.
- **CORE PRINCIPLES / SOLUTION QUALITY** — project-agnostic; keep as-is.
- **ZERO TOLERANCE RULES** — your 6–10 most critical "never do this" rules. A few common-to-Flutter
  ones are pre-filled; add your project-specific ones (DI rule, layering rule, forbidden module).
  (The full version goes in Step 2.3; here it's just the short always-visible reminder.)
- **QUICK COMMANDS / PRE-COMMIT** — Flutter commands are filled in; just confirm your `dart format`
  line length and add any project-specific commands (codegen, build_runner, melos…).
- **QUICK PATTERNS** — the most project-specific section. Write 5–15 lines of the idioms developers
  reach for daily in *this* project: how DI is done, how state is declared/observed, your result/error
  type. The `FILL IN:` note lists exactly what to cover.
- **ARCHITECTURE / CHECKLISTS** — your layer diagram (the prompt shows several formats to pick from)
  and short checklists named after your building blocks.

Leave the `DETAILED GUIDES` index at the bottom (you'll trim it in Step 2.5).

> **Keep it short.** Everything in `CLAUDE.md` is re-read every session. If a section needs paragraphs
> of explanation, it belongs in a rule or a guide, not here.

### Step 2.2 — The stack-agnostic file you can skip

`.claude/rules/approach.md` ships ready to use and is not stack-specific. Skim it, but you don't need
to change anything.

### Step 2.3 — The always-on rules (`.claude/rules/`, no frontmatter)

These four load every session. Open each, read the description, answer the `FILL IN:` prompts, and write yours:

- **`zero-tolerance.md`** — the full version of your hard rules (the `CLAUDE.md` list was the summary).
- **`code-style-rules.md`** — naming, file organization, imports, formatting.
- **`error-handling-rules.md`** — how errors are represented, shown to users, and logged.
- **`legacy-forbidden.md`** — code Claude must never touch. *No legacy yet? Keep the file and write
  "none currently" — the slot should exist for later.*

### Step 2.4 — The path-scoped rules (`.claude/rules/`, with `paths:`)

These only load when Claude opens a file in a matching folder — so a routing rule doesn't waste
context while you're editing tests. There are six: `viewmodel-rules`, `service-rules`,
`repository-rules`, `route-rules`, `ui-rules`, `test-rules`.

For **each one** you must do two things:

**(a) Fix the frontmatter at the very top.** It looks like this:
```yaml
---
paths:
  - "**/view_models/**/*.dart"
  - "**/view_model/**/*.dart"
---
```
- Change the folder names to match **where these files actually live in your project**.
- Change `.dart` to your file extension.
- If your project only uses one spelling (e.g. only `services/`, never `service/`), delete the extra line.
- The key must stay `paths:` — never rename it to `globs:` (Claude Code ignores `globs:` silently).

**(b) Fill the body** — follow the `FILL IN:` prompts to describe the rules for that layer.

> **Your architecture is different?** That's fine — this template is only a scaffold. If you don't
> have "ViewModels" or "Repositories", rename these files to your real layers (e.g.
> `controller-rules.md`, `component-rules.md`) and set their globs accordingly. Delete any layer you
> don't have. The *structure* (some always-on rules + some path-scoped rules) is what matters, not
> these exact names.

### Step 2.5 — The guides (`docs/claude/`)

These are the long "why" explanations, read only when relevant. The template ships five starters:
`architecture`, `state-management`, `testing`, `code-style`, `common-violations`.

- Keep the ones useful for your project and write them, following the `FILL IN:` prompts in each.
- **Delete the ones you don't need** — and when you delete one, remove its line from **two places**:
  the `DETAILED GUIDES` index in `CLAUDE.md`, and the table in `docs/claude/README.md`. (If you
  forget, the hook in Part 4 will remind you.)

You can also leave the guides for later — they're the least urgent part. The rules do the heavy lifting.

### Step 2.6 — The things you don't touch

These ship ready and need no editing: `approach.md`, the hook
(`.claude/hooks/validate-claude-setup.sh`), `.claude/skills/check-rules/`,
`.claude/commands/read.md`, and `.claude/settings.local.json`. One exception: in
`.claude/commands/code-review.md`, fill in the one line for your analyze/lint command.

---

## Part 3 — Turn on the safety-check hook

The hook is what warns you when the setup drifts (a renamed folder, a typo in the frontmatter, a
deleted guide). It's already wired up in `.claude/settings.local.json`. To make sure it can run:

1. Make the script executable. In a terminal, from your project root:
   ```bash
   chmod +x .claude/hooks/validate-claude-setup.sh
   ```
2. That's it. It runs automatically at the start of each Claude session and stays silent unless
   something's wrong.

> The hook is non-blocking — it can only *warn*, never stop you. If it ever errors out, it won't
> break your session.

---

## Part 4 — Verify it works

This is the satisfying part — you get to confirm everything is wired correctly.

### Check 1 — Run the validator

In a terminal from your project root:
```bash
bash .claude/hooks/validate-claude-setup.sh
```
- **No output** = everything is healthy. 
- If it prints warnings, read them — each one tells you the fix. The three things it catches:
  - A `paths:` glob pointing at a folder that doesn't exist → fix the folder name in that rule's frontmatter.
  - A rule still using `globs:` instead of `paths:` → rename the key.
  - A guide listed in `CLAUDE.md` but missing from `docs/claude/` (or vice-versa) → add it or remove it from the index.

Fix any warnings and run it again until it's silent.

### Check 2 — Ask Claude to confirm what it loaded

Start a Claude Code session in your project and type:
```
/read
```
This makes Claude read every instruction file and report back what it found — how many rules, which
guides exist, and anything that looks contradictory. If the summary matches what you wrote, the
wiring is correct.

### Check 3 — A real task

Ask Claude to do something small and real, e.g. *"add a new <component> following our conventions."*
Watch whether it:
- greps for existing examples first (the mandatory workflow),
- follows your naming and architecture,
- avoids your zero-tolerance items.

If it does something off-convention, that usually means a rule was vague — tighten the wording in
the relevant rule file. **This is normal.** The setup improves over the first week as you notice gaps.

### Check 4 — Try the reviewer

On a branch with some changes, type:
```
/code-review
```
It checks your diff against your rules and reports issues by severity. (You may want to tailor the
review steps in `.claude/commands/code-review.md` to your stack later.)

---

## Part 5 — Living with it

A few habits that keep the setup healthy:

- **When Claude gets something wrong the same way twice**, add a line to the relevant rule file (or to
  `common-violations.md`). The setup is meant to grow from real experience.
- **When you rename a folder**, the hook will warn you that a rule's glob no longer matches. Update
  the glob.
- **When you add a new guide**, add it to the `DETAILED GUIDES` index in `CLAUDE.md`.
- **Keep `CLAUDE.md` short.** If it's getting long, move detail into a scoped rule or a guide.
- **Run `/check-rules` anytime** you want a readable health report (same checks as the hook, on demand).

---

## Quick reference — the whole adoption in one screen

1. Copy `CLAUDE.md`, `.claude/`, `docs/claude/` into your project root.
2. Decide tracked vs untracked in git.
3. Fill `CLAUDE.md` (answer the `FILL IN:` prompts; Flutter tooling is already set).
4. Leave `approach.md` alone.
5. Fill the 4 always-on rules: `zero-tolerance`, `code-style-rules`, `error-handling-rules`, `legacy-forbidden`.
6. For each of the 6 path-scoped rules: fix the `paths:` frontmatter, then fill the body. Rename/delete to match your architecture.
7. Keep/write the guides you need in `docs/claude/`; delete the rest from both indexes.
8. Fill the one analyze-command line in `code-review.md`.
9. `chmod +x .claude/hooks/validate-claude-setup.sh`.
10. Verify: run the validator, then `/read`, then a real task, then `/code-review`.

You're set. Everything else is refinement over time.
