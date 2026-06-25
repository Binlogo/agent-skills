# Migration & repair playbook

Command-level recipe for `tidy-up-workspace`. Adapt paths/repo names to the case
at hand. Run the survey and understand the topology **before** applying anything.

## How git worktrees link (why this is fragile)

Each linked worktree has two pointer files that reference each other by
**absolute path**:

- worktree side — `<worktree>/.git` (a file): `gitdir: <main>/.git/worktrees/<id>`
- repo side — `<main>/.git/worktrees/<id>/gitdir`: `<worktree>/.git`

Plus the admin dir `<main>/.git/worktrees/<id>/` holds `HEAD`, `commondir`,
`index`, and (if locked) `locked`. Move either side and the absolute paths go
stale. Three situations, three fixes:

| Situation | What's stale | Fix |
|---|---|---|
| **External** worktree, only main moved | worktree's `.git` (back-pointer still valid) | `git worktree repair` (no-arg) from main |
| **Internal** worktree moved with the tree (admin survived) | both pointers | rewrite both pointer files directly |
| **Orphan** — admin dir lost (pruned) | admin gone, working dir intact | recreate admin + `read-tree` |

`git worktree repair <path>` validates by following the worktree's backlink, so
it **fails** on the internal case (backlink → gone old path). Don't rely on it
there.

## 1. Survey (read-only)

```sh
scripts/survey.sh ~/Workspace            # topology + per-repo worktree state
```

For each main repo, also capture the authoritative list and dirty/unpushed
state — this is your post-migration checklist:

```sh
git -C <repo> worktree list                       # paths + branches + locked/prunable
git -C <wt> status --porcelain | wc -l            # dirty count
git -C <wt> log --oneline @{u}.. | wc -l          # unpushed count (or NO-UPSTREAM)
```

Classify every worktree: **internal** (under the dir you're moving),
**external** (tool roots like `~/conductor/workspaces`, `~/.codex/worktrees`),
**dead** (registered path already missing), **locked** (intentional — prune
skips these; you still must repair their pointers).

## 2. Move (atomic)

```sh
# target must be empty; rmdir refuses otherwise (safety)
[ -z "$(ls -A ~/Workspace/<new> 2>/dev/null)" ] && rmdir ~/Workspace/<new>
# confirm same filesystem so mv is an atomic rename, not a copy
[ "$(stat -f %d ~/Workspace/<old>)" = "$(stat -f %d ~/Workspace)" ] || echo "CROSS-DEVICE — stop"
mv ~/Workspace/<old> ~/Workspace/<new>
```

## 3. Repair — externals → internals → prune (order is mandatory)

The robust, repair-command-independent method handles internals and externals
uniformly by rewriting pointer files per surviving admin dir:

Pass **full absolute paths** (trailing slash) for the old and new tree roots:

```sh
scripts/remap-worktrees.sh ~/Workspace/<old>/ ~/Workspace/<new>/            # dry-run
scripts/remap-worktrees.sh ~/Workspace/<old>/ ~/Workspace/<new>/ --apply
```

What it does, per `<main>/.git/worktrees/<id>/`:
1. read `gitdir` → old worktree path; remap `<old>`→`<new>`.
2. if the remapped path exists → rewrite `<admin>/gitdir` and `<worktree>/.git`
   to the new absolute paths (covers internal *and* external — external paths
   don't contain `<old>` so they map to themselves).
3. leave `HEAD`/`index`/`locked` untouched.

Then, and **only** then:

```sh
git -C <repo> worktree prune -v     # drops genuinely-dead registrations only
git -C <repo> worktree repair       # belt-and-suspenders for any external left
```

## 4. Orphan recovery (admin metadata already lost)

If a worktree was pruned (or its admin dir otherwise lost) but the working dir
is intact, recreate the admin entry. **This never touches working files**, so
uncommitted changes survive. Get `<branch>` from the pre-migration survey.

```sh
scripts/recover-orphan.sh <main-repo> <worktree-dir> <branch>
```

Equivalent by hand:

```sh
id=$(basename "$(sed 's/^gitdir: //' "<worktree>/.git")")   # or any fresh id
admin="<main>/.git/worktrees/$id"
git -C <main> rev-parse --verify "refs/heads/<branch>" >/dev/null || echo "branch missing — stop"
mkdir -p "$admin"
printf '../..\n'                       > "$admin/commondir"
printf '%s/.git\n' "<worktree>"        > "$admin/gitdir"
printf 'ref: refs/heads/<branch>\n'    > "$admin/HEAD"
printf 'gitdir: %s\n' "$admin"         > "<worktree>/.git"
git -C "<worktree>" read-tree HEAD     # rebuild index from HEAD; working tree untouched
git -C "<worktree>" status -s          # uncommitted changes reappear as the real diff
```

`read-tree HEAD` is essential: without an index, status would misreport every
file. It writes only the index, never the working tree.

## 5. Locked worktrees (admin survived, pointers stale)

Prune skips locked worktrees, so their admin dir is intact — only fix the two
pointers, and leave `HEAD`/`index`/`locked` alone:

```sh
id=$(basename "$(sed 's/^gitdir: //' "<worktree>/.git")")
admin="<main>/.git/worktrees/$id"
printf '%s/.git\n' "<worktree>" > "$admin/gitdir"
printf 'gitdir: %s\n' "$admin"  > "<worktree>/.git"
```

(`remap-worktrees.sh` already handles these — this is the manual form.)

## 6. Verify

```sh
# no path should fail to resolve
for repo in <repos…>; do
  git -C "$repo" worktree list --porcelain | awk '/^worktree /{print $2}' \
    | while read -r w; do [ -d "$w" ] || echo "MISSING: $w"; done
done
```

Then re-run the survey and confirm against the pre-migration snapshot:

- [ ] every real worktree resolves to its new path (no `MISSING`)
- [ ] dirty counts match the snapshot **exactly** (no lost uncommitted work)
- [ ] unpushed/NO-UPSTREAM branches unchanged
- [ ] external worktrees' `.git` now point into the new main location
- [ ] locked worktrees still locked
- [ ] only genuinely-dead registrations were pruned
- [ ] no stray hardcoded old paths in shell rc / tool configs (`grep` for the old dir)

## Consolidating existing worktrees into the convention (optional)

If asked to also fold scattered worktrees into `<repo>-worktrees/<branch>`, use
`git worktree move <old> <new>` per worktree **after** the tree is repaired and
healthy. Handle locked/dirty ones individually (`git worktree unlock` first if
intended). Leave tool-managed (external) worktrees in their own roots.
