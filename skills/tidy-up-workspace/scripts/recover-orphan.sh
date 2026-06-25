#!/usr/bin/env bash
# recover-orphan.sh <main-repo> <worktree-dir> <branch> [--apply]
#
# Re-register a worktree whose admin metadata was lost (e.g. pruned) but whose
# working dir is still on disk. Recreates .git/worktrees/<id>/ and re-points the
# worktree's .git file, then rebuilds the index from HEAD. Never modifies any
# working-tree file, so uncommitted changes are preserved and reappear as the
# real diff. DRY-RUN by default; pass --apply to write.
set -euo pipefail
main="${1:?main repo path}"
wt="${2:?worktree dir path}"
branch="${3:?branch name}"
apply=""; [ "${4:-}" = "--apply" ] && apply=1

[ -d "$main/.git" ] || { echo "not a main repo: $main" >&2; exit 1; }
[ -d "$wt" ]        || { echo "worktree dir missing: $wt" >&2; exit 1; }
git -C "$main" rev-parse --verify "refs/heads/$branch" >/dev/null 2>&1 \
  || { echo "branch '$branch' not found in $main" >&2; exit 1; }

# reuse the id from the stale .git backlink if present, else derive from dir name
if [ -f "$wt/.git" ]; then
  id="$(basename "$(sed 's/^gitdir: //' "$wt/.git")")"
else
  id="$(basename "$wt")"
fi
admin="$main/.git/worktrees/$id"

echo "main   : $main"
echo "wt     : $wt"
echo "branch : $branch  ($(git -C "$main" rev-parse --short "$branch"))"
echo "id     : $id"
echo "admin  : $admin"
if [ -n "$apply" ]; then
  mkdir -p "$admin"
  printf '../..\n'                    > "$admin/commondir"
  printf '%s/.git\n' "$wt"            > "$admin/gitdir"
  printf 'ref: refs/heads/%s\n' "$branch" > "$admin/HEAD"
  printf 'gitdir: %s\n' "$admin"      > "$wt/.git"
  git -C "$wt" read-tree HEAD
  echo "recovered. status:"
  git -C "$wt" status -s | sed 's/^/   /'
else
  echo "(dry-run — re-run with --apply to write)"
fi
