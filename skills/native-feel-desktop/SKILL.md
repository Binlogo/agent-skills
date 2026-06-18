---
name: native-feel-desktop
description: "Architect and build cross-platform desktop apps (macOS + Windows) that feel indistinguishable from native: a native shell hosting the system WebView (WKWebView/WebView2), a Node backend, typed IPC, and an optional Rust core. Use when deciding between Electron / Tauri / a native shell, building launchers or global-hotkey / system-tray utilities, debugging WebView flicker or throttling, or auditing whether an app truly feels native. Run the decision tree first — this stack is wrong for single-platform apps, sub-150 MB / sub-100 ms budgets, or short runways. For visual/product design taste, use calm-dense-design."
---

# Native-Feel Desktop

Advise on cross-platform desktop architecture where the app must *feel native* — not a themed Electron app, not a web page in a window. A native shell (Swift/AppKit on macOS, C#/WPF on Windows) owns windowing, hotkeys, menu bar, materials, and lifecycle, and embeds the **system WebView** purely as a rendering surface for shared React/TypeScript UI. Business logic lives in a long-lived Node process; performance-critical work lives in an optional Rust core exposed via UniFFI. Four runtimes, one declared IPC schema.

Grounded in a reverse-engineering of a shipping app (`references/07-evidence-raycast.md`); distilled from [yetone/native-feel-skill](https://github.com/yetone/native-feel-skill) (MIT).

## Qualify first — this stack is not for every app

**Before recommending anything, run `references/decision-tree.md` (7 questions).** It rules the architecture *out* for single-platform apps, tight memory (<150 MB) or launch (<100 ms cold) budgets, short runways, and "Electron is fine" polish bars. Concluding "use Electron / build native" is a valid, common outcome — say so directly rather than over-fitting this stack onto a project it doesn't suit.

If the tree says proceed, continue below.

## The mental model

Read `references/01-philosophy.md` — eight tenets, each naming a tension and its structural resolution (seam at the rendering surface, one schema many languages, adopt the platform, perception over measurement, iteration loop as product, intentional boundaries, identity as muscle memory, baseline vs margin cost). When a decision feels contested, cite the tenet by number and name the trade-off.

The single most useful test for any cross-platform call: **is this above the rendering surface or below it?** Below (windowing, hotkeys, materials, dialogs) → write it twice in idiomatic native. Above (React tree, business logic, AI) → write it once in TS.

## Load only what the task needs

- Layer boundaries, how many layers *your* app needs → `references/02-architecture.md`
- WebView flicker, throttling, translucency, IME → `references/03-webview-survival.md`
- Typed IPC across Rust/Swift/C#/TS (UniFFI, request-vs-event, versioning) → `references/04-ipc-contract.md`
- What memory numbers mean and which costs you can move → `references/05-memory-truths.md`
- "Does this feel like a webpage?" audit → `references/06-native-feel-checklist.md`
- Shipping evidence that the architecture is real → `references/07-evidence-raycast.md`

For visual/product design (density, calm, color restraint), the taste is platform-agnostic and lives in the **`calm-dense-design`** skill — invoke it. This skill owns architecture and engineering, not taste.

## Core anti-patterns — stop and ask

- **"Electron + custom theme"** → can't get true vibrancy / Liquid Glass / acrylic without forking. See `02-architecture.md`.
- **"Tauri for native feel"** → same control-loss as Electron, less mature. Fine for utilities, not polish-critical apps.
- **"Native UI in Swift/C#, share only logic"** → two UI codebases forever. Use WebView-as-renderer instead.
- **"WebKit throttling — let's spin our own loop"** → it's two WKWebView flags. See `03-webview-survival.md`.
- **"400 MB is too much"** → probably a measurement error. Read `05-memory-truths.md` before optimizing.
- **"Hand-write IPC types per language"** → drift within a sprint. One schema, generated clients. See `04-ipc-contract.md`.
- **`cursor: pointer` on rows** → telegraphs web app. See `06-native-feel-checklist.md`.
- **"Make it look like Linear/Things"** → brand skinning is not native feel. Borrow density/restraint via `calm-dense-design`.

## Output style

- Quote the applicable tenet (e.g. *T3 — adopt the platform; don't compete with it*).
- Cite a file and section, not the whole skill.
- Name what the user **gives up** for each recommendation — no free wins.
- If unsure the architecture applies, run the decision tree first. "Use Electron" is a valid conclusion.
