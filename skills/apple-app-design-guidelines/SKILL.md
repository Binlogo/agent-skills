---
name: apple-app-design-guidelines
description: "Review, design, and refine native iOS/iPadOS/macOS interfaces (SwiftUI, AppKit, UIKit) toward calm, dense, Apple-native UI: HIG-correct platform conventions, restrained hierarchy, accessibility, SwiftUI engineering hygiene, and screenshot-based visual QA. Use when building or reviewing an Apple-platform app, polishing SwiftUI/AppKit views, checking HIG compliance, doing screenshot critique of an iOS/macOS UI, or running a maker/checker design review for a coding agent. For platform-agnostic design taste use calm-dense-design; for cross-platform native-feel desktop architecture use native-feel-desktop."
---

# Apple App Design Guidelines

Constrain coding agents building native iOS/iPadOS/macOS UI so the result is **native, fast, calm, dense, legible, and disciplined** — Apple-platform software, not web mental models translated into SwiftUI.

The design *taste* (density without noise, calm without weakness, color restraint) is platform-agnostic and lives in the `calm-dense-design` skill — invoke it for hierarchy/spacing/color judgment. This skill adds what's Apple-specific: platform conventions, framework idioms, accessibility, and visual QA.

## How to use

Default to an **audit → small-pass revision → visual verification** loop. Load the reference that matches the task:

- Deciding what belongs where, or whether a feature even fits the platform → `references/decision-gates.md` (five non-negotiable gates).
- Implementing or reviewing SwiftUI/AppKit code → `references/apple-platform-rules.md`.
- Critiquing a rendered screen → `references/visual-qa-loop.md`.

Revise in small passes that preserve behavior; never broad-rewrite for visual polish. Verify against the *rendered* UI, not imagined UI.

## Non-negotiable anchors

Full detail in `references/decision-gates.md`; these are the one-line versions you must not violate:

- **Native-first.** SwiftUI for new UI; AppKit/UIKit bridges only for capabilities SwiftUI can't express cleanly. No web-style pseudo-native (giant cards, fake focus rings, fixed desktop layouts on iPhone).
- **Right platform, right workflow.** iOS is a companion surface (triage, capture, approve, read) — not a desktop clone. macOS preserves power (keyboard, menus, sidebar, resizable windows, hover/focus).
- **Calm density.** Content first; chrome recedes; one accent per screen following the *system* accent; hairline separators over heavy borders. (Taste → `calm-dense-design`.)
- **Accessibility is a gate, not polish.** Dynamic Type, VoiceOver labels on icon-only controls, light/dark contrast, 44pt touch targets, keyboard/focus on macOS·iPad, reduced-motion, no color-only status.
- **Visual evidence.** Critique a screenshot or preview, never imagined UI. No "looks good" without a concrete observation. Stop after 3 visual passes unless asked to continue.

## Review output format

When reviewing code, cite `file:line` (or the screen/component name when no line is available):

```text
Summary: <1-3 sentence verdict>

Blocking:    <file:line — issue — required fix>
Polish:      <file:line — issue — suggested fix>
Accessibility: <file:line — issue — fix>
Visual QA needed: <screen — screenshot/build step>

Decision: accept / accept with fixes / reject
```

A checker's job is to find hierarchy, density, alignment, contrast, accessibility, and convention problems — not to praise. For non-trivial UI, keep maker and checker as separate passes.

## Anti-patterns to call out bluntly

- "Make it look like Linear/Things" by copying dark backgrounds and purple/blue/green brand accents.
- A mobile app that is the web sidebar squeezed onto a phone.
- Over-carded UI — every element in a rounded rectangle.
- Heavy borders, heavy shadows, and low-density spacing pretending to be premium.
- Custom controls that drop platform affordances (system states, focus rings, menus).
- Agent self-review with no rendered screenshot, or "looks good" with no evidence.
