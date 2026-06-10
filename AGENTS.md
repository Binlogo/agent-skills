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
README.md           # skill index + install command
AGENTS.md           # this file
docs/brainstorms/   # design notes (not shipped as skills)
```

Nothing else belongs at the repo root.

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

Distribution is handled entirely by the [skills.sh](https://www.skills.sh/) CLI
(`npx skills add <owner/repo>`). The repo ships no sync, symlink, or copy
scripts. To make a new skill installable, commit it under `skills/` and push.
