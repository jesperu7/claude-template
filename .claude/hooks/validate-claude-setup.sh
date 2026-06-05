#!/usr/bin/env bash
# validate-claude-setup.sh
# SessionStart drift detector for the Claude setup.
# Non-blocking: prints findings, always exits 0 so it never blocks a session.
# Flags three silent-breakage modes:
#   1. A rule `paths:` glob that matches ZERO files (folder renamed/moved → rule never loads)
#   2. A rule using the stale `globs:` key (Cursor format, silently ignored by Claude Code)
#   3. A guide referenced in CLAUDE.md's DETAILED GUIDES index that is missing from docs/claude/
# Guides present but NOT indexed are reported as info, not a failure.

set -uo pipefail

# Resolve repo root from this script's location (.claude/hooks/ -> repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RULES_DIR="$ROOT/.claude/rules"
GUIDES_DIR="$ROOT/docs/claude"
CLAUDE_MD="$ROOT/CLAUDE.md"

problems=()
infos=()

# --- Check rule files ---
if [[ -d "$RULES_DIR" ]]; then
  for rule in "$RULES_DIR"/*.md; do
    [[ -e "$rule" ]] || continue
    name="$(basename "$rule")"

    # 2. Stale `globs:` key
    if head -n 20 "$rule" | grep -qE '^\s*globs\s*:'; then
      problems+=("RULE '$name' uses the stale 'globs:' key — Claude Code ignores it. Rename to 'paths:'.")
    fi

    # 1. paths: globs that match zero files
    # Extract glob list items under a paths: frontmatter key
    in_paths=0
    while IFS= read -r line; do
      if [[ "$line" =~ ^[[:space:]]*paths[[:space:]]*: ]]; then in_paths=1; continue; fi
      if [[ $in_paths -eq 1 ]]; then
        if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*(.+)$ ]]; then
          glob="${BASH_REMATCH[1]}"
          glob="${glob%\"}"; glob="${glob#\"}"; glob="${glob%\'}"; glob="${glob#\'}"
          # Skip globs that still contain a placeholder comment or extension placeholder
          if [[ "$glob" == *"<!--"* || "$glob" == *"-->"* || "$glob" == "--"* ]]; then continue; fi
          matches="$(cd "$ROOT" && find . -path "./$glob" 2>/dev/null | head -n 1)"
          if [[ -z "$matches" ]]; then
            # find can't expand ** the same way as shell globs; fall back to a softer check
            base_dir="$(echo "$glob" | sed -E 's#\*\*?/.*##')"
            if [[ -n "$base_dir" && ! -d "$ROOT/$base_dir" ]]; then
              problems+=("RULE '$name' glob '$glob' matches zero files (folder missing?). Rule will never load.")
            fi
          fi
        elif [[ "$line" =~ ^[^[:space:]] || "$line" =~ ^---[[:space:]]*$ ]]; then
          in_paths=0
        fi
      fi
    done < "$rule"
  done
fi

# --- Check guides index ---
if [[ -f "$CLAUDE_MD" && -d "$GUIDES_DIR" ]]; then
  # Guides referenced in CLAUDE.md's DETAILED GUIDES section only (so prose elsewhere
  # in the file that mentions a .md file isn't mistaken for a guide reference).
  guides_section="$(awk 'BEGIN{p=0} /DETAILED GUIDES/{p=1} p{print}' "$CLAUDE_MD")"
  referenced="$(printf '%s' "$guides_section" | grep -oE '`[a-zA-Z0-9_-]+\.md`' | tr -d '`' | sort -u)"
  for g in $referenced; do
    # only care about guide-style names, skip rules/config files
    case "$g" in
      CLAUDE.md|README.md|SETUP.md|settings.local.json) continue;;
    esac
    if [[ ! -f "$GUIDES_DIR/$g" ]]; then
      # Only flag if it looks like a guide (exists nowhere as a rule either)
      if [[ ! -f "$RULES_DIR/$g" ]]; then
        problems+=("GUIDE '$g' is indexed in CLAUDE.md but missing from docs/claude/.")
      fi
    fi
  done

  # Guides present but not indexed → info only
  for guide in "$GUIDES_DIR"/*.md; do
    [[ -e "$guide" ]] || continue
    gname="$(basename "$guide")"
    case "$gname" in README.md) continue;; esac
    if ! grep -q "\`$gname\`" "$CLAUDE_MD"; then
      infos+=("Guide '$gname' exists in docs/claude/ but isn't in CLAUDE.md's index (orphan).")
    fi
  done
fi

# --- Emit a single systemMessage (JSON) so it shows non-intrusively ---
if [[ ${#problems[@]} -gt 0 || ${#infos[@]} -gt 0 ]]; then
  msg="Claude setup check:"
  for p in "${problems[@]}"; do msg+=$'\n  ⚠️  '"$p"; done
  for i in "${infos[@]}"; do msg+=$'\n  ℹ️  '"$i"; done
  # Escape for JSON
  esc="$(printf '%s' "$msg" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))' 2>/dev/null || printf '"%s"' "$(printf '%s' "$msg" | tr '\n' ' ')")"
  printf '{"systemMessage": %s}\n' "$esc"
fi

exit 0
