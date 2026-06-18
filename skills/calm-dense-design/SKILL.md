---
name: calm-dense-design
description: "Platform-agnostic product-UI design taste — Linear-style information density without noise, Things 3-style calm without weakness, restrained semantic color, typographic hierarchy, and purposeful motion. Use when a UI feels noisy, over-decorated, low-density, brand-heavy, or carded-up and should become quieter, denser, and clearer; when judging visual hierarchy, spacing, color restraint, or motion; or when someone says 'make it feel like Linear / Things'. Consumed by platform skills (apple-app-design-guidelines, native-feel-desktop), but works on its own for web or any surface."
---

# Calm, Dense Design

A taste, not a skin. Linear and Things 3 are references for *judgment* — how to present a lot of information without noise, and how to stay calm without going vague. Borrowing their dark theme, purple accent, or blue/green brand color is not borrowing the taste.

Two lessons carry most of the value:

- **Linear — density without noise.** Show dense work with restrained hierarchy.
- **Things — calm without weakness.** Keep the main surface calm by hiding detail until it earns its place, not by emptying the screen.

## Principles

Each is a rule plus the cut it forces. Apply them when building or critiquing a surface.

1. **Don't compete for attention you haven't earned.** Chrome, separators, metadata, inactive tabs, repeated icons recede; main content and the one primary action read first without shouting.
2. **Structure is felt, not seen.** Get hierarchy from optical alignment, a consistent spacing rhythm, 0.5–1px separators, opacity steps, grouped backgrounds, and type — *not* from heavy borders, large shadows, decorative gradients, saturated panels, or icon containers.
3. **Density without clutter.** Compact rows with predictable alignment and progressive disclosure of detail. Not: tiny unreadable text, every row exposing every control, or inflated padding sold as "premium."
4. **Calm that clarifies, not calm that hides.** Calm comes from a clear hierarchy and one obvious next action — not from pale whitespace, low-contrast text pretending to be quiet, or empty states used as decoration.
5. **Restrained semantic color.** Accent marks selection, focus, important status, and positive/completion state — never decoration. Respect the system accent; don't repaint everything in a brand color. A "completion green" is a semantic cue, not the app's primary color.

## Type and motion

- **Type:** system fonts unless there's a strong reason otherwise; hierarchy from size, weight, opacity, and placement. Direction: screen title (clear, not oversized) → row title (medium weight) → metadata (smaller, lower opacity) → status (compact, semantic, not badge-heavy) → body (short, readable).
- **Motion:** explains continuity or state change (a composer appearing, a selection moving, an inline status update). Never ornamental. Always honor reduced-motion.

## Two decision tests

- **Drama test:** if a treatment adds visual drama but doesn't improve orientation, speed, confidence, or task completion — remove it.
- **Calm test:** if "calm" makes hierarchy, density, or the next action harder to read — it isn't calm, it's vague. Tighten it.

## Self-check

Read a screen against these. A "no" is a finding, not a preference:

- Is the primary task obvious within one glance, without the eye hunting?
- Does secondary chrome recede, or does it compete?
- Are rows/items aligned on a predictable grid and baseline?
- Is the screen dense because it's informative — or sparse because padding is inflated?
- Does color communicate *state*, or is it brand decoration?
- Could you delete a separator, shadow, gradient, or icon container and lose nothing?

## Going deeper

`references/in-practice.md` — concrete (illustrative) values, expanded Prefer/Avoid lists, and how to apply this taste during a review pass.

## Not this skill's job

This is platform-agnostic taste. Platform conventions, controls, and architecture live elsewhere:

- **Apple (iOS/iPadOS/macOS) UI + HIG + SwiftUI/AppKit + visual QA** → `apple-app-design-guidelines`.
- **Cross-platform native-feel desktop architecture (shell + WebView + IPC)** → `native-feel-desktop`.

When taste and platform conflict, the platform wins — defer to those skills.
