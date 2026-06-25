#!/usr/bin/env bash
# survey.sh <root> — READ-ONLY. Map the tree and every repo's worktree state so
# you have a pre-migration snapshot to verify against afterward. Works whether
# <root> is ~/Workspace (repos nested under category dirs) or a single category
# / container dir (repos directly inside).
set -uo pipefail
root="${1:-$HOME/Workspace}"
[ -d "$root" ] || { echo "no such dir: $root" >&2; exit 1; }

echo "### Top-level entries under $root"
for p in "$root"/*/ "$root"/.*/; do
  [ -d "$p" ] || continue
  name="$(basename "$p")"
  case "$name" in .|..) continue;; esac
  if   [ -d "$p/.git" ]; then kind="MAIN-repo";
  elif [ -f "$p/.git" ]; then kind="worktree";
  elif compgen -G "$p*/.git" >/dev/null 2>&1; then kind="container (holds repos)";
  else kind="plain-dir"; fi
  printf "  %-40s %s\n" "$name" "$kind"
done

echo
echo "### Worktrees per main repo (path | branch | dirty | unpushed | flags)"
# main repo = a directory whose .git is itself a directory; find at depth 1-2
find "$root" -mindepth 2 -maxdepth 3 -type d -name .git 2>/dev/null | sort | while read -r g; do
  d="$(dirname "$g")"
  echo "── ${d#$root/}"
  git -C "$d" worktree list --porcelain 2>/dev/null | awk '
    /^worktree /{wt=substr($0,10)}
    /^branch /{br=$2}
    /^detached/{br="(detached)"}
    /^locked/{lk=" locked"}
    /^prunable/{pr=" prunable"}
    /^$/{if(wt!="")print wt"\t"br lk pr; wt="";br="";lk="";pr=""}
    END{if(wt!="")print wt"\t"br lk pr}
  ' | while IFS=$'\t' read -r wt rest; do
    [ -n "$wt" ] || continue
    if [ -d "$wt" ]; then
      dirty=$(git -C "$wt" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
      if up=$(git -C "$wt" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null); then
        ahead=$(git -C "$wt" log --oneline '@{u}..' 2>/dev/null | wc -l | tr -d ' ')
        push="ahead:$ahead"
      else
        push="NO-UPSTREAM"
      fi
      printf "   %-64s %-38s dirty:%-3s %s\n" "$wt" "${rest# }" "$dirty" "$push"
    else
      printf "   %-64s %-38s MISSING-DIR\n" "$wt" "${rest# }"
    fi
  done
done
