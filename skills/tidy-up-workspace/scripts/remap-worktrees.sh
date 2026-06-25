#!/usr/bin/env bash
# remap-worktrees.sh <old-root> <new-root> [--apply]
#
# Repair worktree links after moving a tree (e.g. ~/Workspace/old -> .../new).
# Walks every surviving admin dir under .../new/<repo>/.git/worktrees/<id>/ and
# rewrites the two pointer files so internal AND external worktrees resolve.
# DRY-RUN by default; pass --apply to write. Never touches HEAD/index/locked or
# any working-tree file.
#
#   <old-root>/<new-root>: FULL absolute paths (trailing slash) — the old and new
#   locations of the moved tree, e.g.
#     /Users/me/Workspace/old/   /Users/me/Workspace/new/
#   new-root must exist (it's scanned for repos); old-root is the literal prefix
#   substituted in each stale registered path.
set -euo pipefail
old="${1:?old-root, full abs path with trailing slash (e.g. /Users/me/Workspace/old/)}"
new="${2:?new-root, full abs path with trailing slash (e.g. /Users/me/Workspace/new/)}"
apply=""; [ "${3:-}" = "--apply" ] && apply=1

newbase="${new%/}"
[ -d "$newbase" ] || { echo "new-root does not exist: $newbase" >&2; exit 1; }

changed=0; ext=0; dead=0
for repo in "$newbase"/*/; do
  [ -d "$repo/.git/worktrees" ] || continue
  for admin in "$repo".git/worktrees/*/; do
    [ -f "$admin/gitdir" ] || continue
    oldwt="$(sed 's|/\.git$||' "$admin/gitdir")"     # registered worktree path
    newwt="${oldwt/$old/$new}"                        # remap if it was in-tree
    id="$(basename "$admin")"
    if [ -d "$newwt" ]; then
      want_gitdir="$newwt/.git"
      want_dotgit="gitdir: ${admin%/}"
      cur_gitdir="$(cat "$admin/gitdir")"
      cur_dotgit="$(cat "$newwt/.git" 2>/dev/null || true)"
      if [ "$cur_gitdir" = "$want_gitdir" ] && [ "$cur_dotgit" = "$want_dotgit" ]; then
        continue   # already correct
      fi
      [ "$oldwt" = "$newwt" ] && ext=$((ext+1)) || changed=$((changed+1))
      echo "FIX  $id"
      echo "       admin/gitdir : $cur_gitdir  ->  $want_gitdir"
      echo "       worktree/.git: ${cur_dotgit:-<missing>}  ->  $want_dotgit"
      if [ -n "$apply" ]; then
        printf '%s\n' "$want_gitdir" > "$admin/gitdir"
        printf '%s\n' "$want_dotgit" > "$newwt/.git"
      fi
    else
      dead=$((dead+1))
      echo "DEAD $id -> $newwt (not on disk; 'git worktree prune' will drop it)"
    fi
  done
done

echo
echo "internal-remapped:$changed  external-confirmed:$ext  dead:$dead"
[ -n "$apply" ] || echo "(dry-run — re-run with --apply to write, then 'git worktree prune' per repo)"
