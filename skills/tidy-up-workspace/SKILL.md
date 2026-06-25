---
name: tidy-up-workspace
description: "Safely reorganize the ~/Workspace tree — move or rename category/repo directories and relocate, consolidate, or repair git worktrees without breaking their links or losing uncommitted work. Use when tidying or migrating ~/Workspace, renaming/moving a repo or category dir that has worktrees, when worktrees are scattered across inconsistent conventions, when git worktree links broke after a manual move, when worktrees vanished after an over-eager `git worktree prune`, or to enforce the ~/Workspace/<category>/<repo>-worktrees/<branch> convention. Covers read-only survey, atomic move, ordered repair (externals → internals → prune last), orphan recovery, and verification."
---

# Tidy up Workspace

Reorganize `~/Workspace` — move/rename category and repo dirs, relocate and
consolidate git worktrees, repair links after a move — **without breaking
worktree links or losing uncommitted work.**

Moving a git repo that has worktrees is *not* a plain `mv`: worktrees store
**absolute paths** in their `.git` files, so a naive move silently breaks every
link, and the obvious fix (`git worktree repair`) does **not** cover the common
case. This skill encodes the safe sequence learned the hard way.

## The convention

Manual worktrees live at:

```
~/Workspace/<category>/<repo>-worktrees/<branch>
```

One sibling `-worktrees/` dir per repo, mirroring the branch name (slashes
allowed, e.g. `feat/foo`). **Never** scatter them as flat `<repo>-<ticket>`
siblings or a shared top-level `worktrees/`. Tool-managed worktrees keep their
own roots (e.g. `~/conductor/workspaces/<repo>/…`, `~/.codex/worktrees/…`) —
leave them there; repair in place, never relocate.

## Golden rules (do not skip)

1. **Survey read-only first.** Map every entry, list each repo's worktrees,
   record dirty/unpushed/locked state *before* touching anything. You compare
   against this at the end.
2. **`git worktree prune` is the footgun.** It deletes admin metadata for any
   worktree whose registered path is currently missing — which is *every*
   internal worktree right after a move, *before* repair. **Always repair
   internals before prune.** Prune only ever runs last.
3. **Prune never deletes working dirs.** It removes only `.git/worktrees/<id>/`
   metadata — files and uncommitted changes stay on disk, so over-pruning is
   always recoverable. (See orphan recovery in the playbook.)
4. **`git worktree repair <path>` can't fix a moved-together tree.** It follows
   the worktree's `.git` backlink to validate it; when both main and worktree
   moved, that backlink points to a gone path and repair errors out. Fix
   internal worktrees by rewriting the two pointer files directly (playbook).
5. **A same-filesystem `mv` preserves everything**, including uncommitted
   changes — verify same device first, and rename atomically.
6. **Commit/push only when asked.** Migration touches metadata, not history.

## Workflow

1. **Survey** — `scripts/survey.sh ~/Workspace` (read-only). Classify each
   entry (main repo = `.git` dir, worktree = `.git` file, plain dir),
   `git worktree list` per repo, and flag dirty/unpushed/locked. Identify each
   worktree as **internal** (under the tree being moved), **external**
   (tool-managed, elsewhere), or **dead** (path already gone).
2. **Decide** — confirm the target layout and how far to go (move + repair only,
   vs. also consolidate existing worktrees into the convention). For anything
   irreversible on active repos, confirm with the user first.
3. **Move** — atomic same-filesystem rename (`rmdir` the empty target if it
   exists, then `mv`).
4. **Repair, in order** — externals → internals → prune. Use
   `scripts/remap-worktrees.sh <old-root> <new-root>` (dry-run by default,
   `--apply` to execute). For worktrees whose admin metadata was already lost,
   use `scripts/recover-orphan.sh`.
5. **Verify** — re-run the survey: no missing dirs, dirty/unpushed counts match
   the pre-move snapshot **exactly**, externals re-pointed, locks preserved.

The full command-level recipe, the orphan-recovery procedure, and the
verification checklist are in **[references/playbook.md](references/playbook.md)** —
read it before applying any change.
