#!/usr/bin/env sh
# install.sh — activate THIS repo's authored skills for the local agents.
#
# Why a script at all (consumers don't need one — see README.md):
#   This is an *authoring* checkout, so edits should be live. The skills.sh CLI
#   installs by COPYING, so a local edit stays invisible until `skills update`.
#   Symlinks keep this repo itself the single source of truth — edit a SKILL.md
#   here and every agent sees it immediately.
#
# Linking model:
#   * Each skill is linked into the shared hub  ~/.agents/skills/<name>, which
#     "universal" agents (Codex, Cursor, Gemini, ...) read directly.
#   * Claude Code reads its own dir, so it also gets
#     ~/.claude/skills/<name> -> ../../.agents/skills/<name>, matching the
#     per-skill symlink convention already used there.
#
# Idempotent and safe to re-run. Additive only: it never deletes anything and
# never clobbers a non-symlink (e.g. a skills.sh-managed copy already in the
# hub). If you rename or remove a skill, delete its stale symlink by hand.
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
src="${repo_dir}/skills"
hub="${HOME}/.agents/skills"

# Agent dirs that follow the per-skill symlink convention (Claude today).
# Each entry must be of the form ~/.<agent>/skills so the relative link
# ../../.agents/skills/<name> resolves correctly. Universal agents need no
# entry here — they read the hub directly.
symlink_agent_dirs="${HOME}/.claude/skills"

mkdir -p "$hub"

linked=0
skipped=0
for s in "$src"/*/; do
    [ -f "${s}SKILL.md" ] || continue   # only real skills
    name=$(basename "$s")
    target="${s%/}"                     # absolute path to the skill dir
    hub_link="${hub}/${name}"

    if [ -e "$hub_link" ] && [ ! -L "$hub_link" ]; then
        printf 'skip  %-30s (non-symlink in hub — not clobbering a CLI copy)\n' "$name"
        skipped=$((skipped + 1))
        continue
    fi
    if [ -L "$hub_link" ] && [ "$(readlink "$hub_link")" != "$target" ]; then
        printf 'skip  %-30s (hub link already points elsewhere)\n' "$name"
        skipped=$((skipped + 1))
        continue
    fi

    ln -sfn "$target" "$hub_link"
    linked=$((linked + 1))

    for adir in $symlink_agent_dirs; do
        [ -d "$adir" ] || continue
        a="${adir}/${name}"
        if [ -e "$a" ] && [ ! -L "$a" ]; then
            printf 'skip  %-30s (non-symlink in %s)\n' "$name" "$adir"
            continue
        fi
        ln -sfn "../../.agents/skills/${name}" "$a"
    done
done

printf 'agent-skills: linked %d skill(s), skipped %d  (hub: %s)\n' "$linked" "$skipped" "$hub"
