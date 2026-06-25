# agent-skills

A personal collection of [Agent Skills](https://www.skills.sh/) — packaged,
reusable instructions that extend AI coding agents (Claude Code, Cursor, Codex,
and others).

## Install

Install every skill in this repo into your detected agents with one command:

```sh
npx skills add Binlogo/agent-skills
```

Or install a single skill by name:

```sh
npx skills add Binlogo/agent-skills/apple-app-design-guidelines
```

The skills.sh CLI auto-detects your installed agents and writes the skills into
each one. No manual syncing required.

> Editing these skills yourself? Don't use the CLI — it installs *copies*, so
> your edits go stale. Clone to `~/.local/share/agent-skills` and run
> `./install.sh` to symlink them live. See [Authoring](#authoring).

## Available skills

### apple-app-design-guidelines

Review, design, and refine native iOS/iPadOS/macOS SwiftUI or AppKit/UIKit
interfaces toward Linear-like density and Things 3-like calm: restrained chrome,
warm-neutral hierarchy, native Apple platform feel, accessibility, and visual QA.
Use when building or reviewing Apple-platform UI.

### native-feel-desktop

Design cross-platform desktop apps (macOS + Windows) that feel native: four-layer
architecture, WebKit/WebView2 pitfalls, typed IPC, ship-readiness audit, and
Linear/Things 3-inspired product design. Distilled from
[yetone/native-feel-skill](https://github.com/yetone/native-feel-skill). Use when
choosing Electron vs native shell, building launchers, or auditing native feel.

```sh
npx skills add Binlogo/agent-skills/native-feel-desktop
```

## Authoring

The canonical checkout lives at `~/.local/share/agent-skills` (parallel to
chezmoi). Activate skills locally with live symlinks:

```sh
git clone https://github.com/Binlogo/agent-skills.git ~/.local/share/agent-skills
cd ~/.local/share/agent-skills && ./install.sh
```

`install.sh` symlinks each skill into `~/.agents/skills` (read by Codex, Cursor,
Gemini, …) and `~/.claude/skills`, so edits here take effect immediately. Re-run
it after adding a skill. 

Conventions for adding or editing skills live in [`AGENTS.md`](AGENTS.md).
