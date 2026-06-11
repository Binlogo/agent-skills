---
name: native-feel-desktop
description: "Design and build cross-platform desktop apps (macOS + Windows) that feel indistinguishable from native: four-layer architecture (native shell + system WebView + Node + Rust), WebKit/WebView2 survival guide, typed IPC, memory accounting, native UI conventions, and Linear/Things 3-inspired product design. Distilled from Raycast 2.0's public deep-dive. Use when choosing Electron vs Tauri vs native shell, building launchers, global-hotkey utilities, system-tray apps, WKWebView/WebView2 wrappers, near-native performance, restrained dense desktop UI, or auditing whether an app truly feels native."
---

# Native-Feel Desktop

Advise on cross-platform desktop architecture where the app must *feel native* — not a themed Electron app, not a web page in a window. Grounded in Raycast's 2.0 rewrite and reverse-engineering of the shipping `Raycast Beta.app`.

Distilled from [yetone/native-feel-skill](https://github.com/yetone/native-feel-skill) (MIT).

## How to use

1. **Start with philosophy** — `references/01-philosophy.md` (eight tenets). If a decision contradicts a tenet, cite it by number and explain the trade-off.
2. **Load only what's needed:**
   - Architecture / layer boundaries → `references/02-architecture.md`
   - WebView flicker, throttling, translucency → `references/03-webview-survival.md`
   - IPC typing across Rust/Swift/C#/TS → `references/04-ipc-contract.md`
   - Memory numbers / Activity Monitor → `references/05-memory-truths.md`
   - "Feels like a webpage" audit → `references/06-native-conventions.md`
   - Raycast shipping evidence → `references/07-evidence-raycast.md`
   - Dense, restrained product design → `references/08-product-design.md`
3. **Before recommending this stack** — run `references/decision-tree.md`. Rule it OUT when it doesn't fit.
4. **Before claiming "feels native"** — run `references/ship-readiness.md` (75-item audit).

## One paragraph

A native-feel cross-platform desktop app is a **native shell** (Swift/AppKit on macOS, C#/WPF on Windows) that owns windowing, hotkeys, menu bar, materials, and lifecycle — and embeds the **system WebView** (WKWebView / WebView2) purely as a *rendering surface* for shared React/TypeScript UI. Business logic lives in a long-lived Node process. Performance-critical work lives in Rust, exposed via UniFFI. Four runtimes share one declared IPC schema. Baseline memory is ~400 MB (~150 MB WebView+Node floor); you pay that to halve UI engineering and earn it back through HMR iteration speed.

## Core anti-patterns — stop and ask

- **"Electron + custom theme"** → Cannot get Liquid Glass / acrylic / true vibrancy without forking. See `references/02-architecture.md`.
- **"Tauri for native feel"** → Same control-loss as Electron; less mature. OK for utilities, not polish-critical apps.
- **"Native UI in Swift/C#, share only logic"** → Two UI codebases forever. Use WebView-as-renderer instead.
- **"WebKit throttling — spin our own loop"** → Fix with two WKWebView flags. See `references/03-webview-survival.md` § hidden window throttling.
- **"400 MB is too much"** → Probably wrong measurement. See `references/05-memory-truths.md` first.
- **"Hand-write IPC types per language"** → Drift within a sprint. Use UniFFI or a single IDL. See `references/04-ipc-contract.md`.
- **`cursor: pointer` on rows** → Telegraphs web app. See `references/06-native-conventions.md`.
- **"Make it look like Linear/Things"** → Brand skinning is not native feel. Borrow density, hierarchy, restraint, and semantic color from `references/08-product-design.md`.

## Output style

- Quote the applicable tenet from `references/01-philosophy.md` (e.g., *T3 — adopt the platform; don't compete with it*).
- Cite file and section, not the whole skill.
- Name what the user **gives up** for each recommendation — no free wins.
- If unsure this architecture applies, run `references/decision-tree.md` first. Concluding "use Electron" is valid.
