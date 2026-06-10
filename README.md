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

## Available skills

### apple-app-design-guidelines

Review, design, and refine native iOS/macOS SwiftUI or AppKit/UIKit interfaces
toward a Linear-like level of polish: calm density, restrained chrome, native
Apple platform feel, accessibility, and visual QA. Use when building or
reviewing Apple-platform UI.

### native-feel-desktop

Design cross-platform desktop apps (macOS + Windows) that feel native: four-layer
architecture, WebKit/WebView2 pitfalls, typed IPC, and ship-readiness audit.
Distilled from [yetone/native-feel-skill](https://github.com/yetone/native-feel-skill).
Use when choosing Electron vs native shell, building launchers, or auditing native feel.

```sh
npx skills add Binlogo/agent-skills/native-feel-desktop
```

## Authoring

Conventions for adding or editing skills live in [`AGENTS.md`](AGENTS.md).
