# Authoring conventions

Conventions for adding and maintaining skills in this repo. Keep the repo lean:
prefer editing existing files over adding scaffolding, and don't introduce
tooling (templates, validators, CI) unless it's actually needed.

## Repo layout

```
skills/<skill-name>/
  SKILL.md          # required entry point
  references/       # optional, loaded on demand
  scripts/          # optional helper scripts
install.sh          # author-side activation: phase 1 symlinks authored skills,
                    #   phase 2 replays consumed.skills via the skills CLI
consumed.skills     # declared third-party skills (one owner/repo[#ref] [skill …] per line)
README.md           # skill index + install command
AGENTS.md           # this file
```

Keep it lean — only these belong at the repo root.

## Skill rules

1. **One directory per skill**, named in `kebab-case`, under `skills/`.
2. **`SKILL.md` opens with YAML frontmatter** carrying `name` (matching the
   directory) and a trigger-rich `description`:

   ```yaml
   ---
   name: my-skill
   description: "What it does and when to use it. Pack the 'use when' triggers here — this string is what the agent matches against."
   ---
   ```

3. **English only** — frontmatter and body alike. This keeps trigger matching
   and execution aligned with the mainstream skill ecosystem.
4. **`SKILL.md` is the lean entry point.** Move bulky or optional detail into
   `references/*.md` and reference it so the agent loads it only when needed.
5. **Use `apple-app-design-guidelines` as the worked example** of these rules.

## Install model

Two audiences, two paths:

- **Consumers** install with the [skills.sh](https://www.skills.sh/) CLI:
  `npx skills add Binlogo/agent-skills`. The CLI *copies* skills into each
  detected agent — right for read-only use.
- **The author** (you, on your own machines) runs `./install.sh`. The CLI's
  copy model makes local edits go stale until `skills update`; the script
  *symlinks* each skill into the shared `~/.agents/skills` hub (and into
  `~/.claude/skills`), so edits in this repo are live. Read `install.sh` for
  the exact linking model.

`./install.sh` runs in two phases: **phase 1** symlinks the authored `skills/*`
(live edits); **phase 2** replays `consumed.skills` — the third-party skills you
*use* but don't author — through `npx skills add -g`, so one checkout reproduces
the entire skill set. The CLI still fetches/updates consumed skills; `consumed.skills`
just declares them reproducibly. Add a `#ref` after a source to pin it.

The canonical checkout lives at `~/.local/share/agent-skills`, parallel to
chezmoi's `~/.local/share/chezmoi`. A fresh machine is bootstrapped by chezmoi:
a `run_onchange` script clones this repo there and runs `./install.sh`. chezmoi
*orchestrates* only this repo — it never *owns* these files or learns about
individual skills. To add an authored skill: drop it under `skills/`, run
`./install.sh`, commit, push. To add a consumed skill: add a line to
`consumed.skills`, run `./install.sh`, commit, push.
