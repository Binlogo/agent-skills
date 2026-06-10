---
name: apple-app-design-guidelines
description: "Review, design, and refine native iOS/macOS SwiftUI or AppKit/UIKit interfaces toward a Linear-like level of polish: calm density, restrained chrome, native Apple platform feel, accessibility, visual QA, and coding-agent-safe UI iteration. Use when building or reviewing iOS/macOS apps, SwiftUI views, native UI polish, Linear Mobile/Linear-style interfaces, Apple HIG compliance, screenshot-based UI critique, or maker/checker design review for coding agents."
---

# Linear-style Apple App Design

Use this skill to constrain coding agents building native iOS/macOS UI. The goal is not to imitate Linear superficially; it is to produce **native, fast, calm, dense, legible, and disciplined** Apple-platform software.

## Operating model

Default to an audit-and-iteration loop:

1. **Classify the target**: iOS companion app, iPad app, macOS productivity app, menu-bar utility, document app, dashboard, or settings-heavy tool.
2. **Read project rules**: `AGENTS.md`, `CLAUDE.md`, design tokens, SwiftUI theme files, existing components, screenshots, and relevant Swift files.
3. **Apply gates**: Apple HIG, Linear-style visual rules, SwiftUI/AppKit engineering rules, accessibility, and visual QA.
4. **Report concrete issues**: prefer `file:line — issue — fix` when reviewing code.
5. **Revise in small passes**: preserve behavior; avoid broad rewrites for visual polish.
6. **Verify visually**: build/run/preview/screenshot when possible; critique the actual rendered UI, not imagined UI.
7. **Stop after 3 visual iterations** unless the user explicitly asks to continue.

## Source-of-truth references

Read these only when needed:

- `references/linear-style-rules.md` — Linear-inspired visual/product principles.
- `references/apple-platform-rules.md` — Apple HIG + SwiftUI/AppKit implementation rules.
- `references/visual-qa-loop.md` — screenshot/build/reviewer workflow for coding agents.

## Non-negotiable gates

### 1. Scope gate

For iOS, first ask whether the feature belongs on mobile.

Linear Mobile is a companion product, not a desktop clone. Prefer away-from-keyboard workflows:

- triage inbox
- quick capture / issue composer
- notifications and approvals
- lightweight status reading
- comments and small edits
- camera/photo/screenshot capture

Reject or defer workflows that require prolonged editing, dense table manipulation, or multi-pane desktop cognition unless the user explicitly wants them.

For macOS, preserve desktop power:

- keyboard shortcuts
- menu bar integration when appropriate
- toolbar/sidebar conventions
- resizable windows
- multi-window or document behavior when relevant
- hover/focus states

### 2. Native-first gate

Prefer SwiftUI for new UI. Use AppKit/UIKit bridges only for platform-native capabilities SwiftUI cannot express cleanly.

Do not implement web-style pseudo-native UI: giant cards everywhere, custom buttons that ignore system states, fixed desktop layouts on iPhone, fake focus rings, or JS/web mental models translated into SwiftUI.

### 3. Calm-density gate

Linear-style UI is not empty minimalism. It is dense but quiet.

Enforce:

- content first; navigation and chrome recede
- restrained accent color, usually one primary accent per screen
- warm/neutral grays over saturated backgrounds
- subtle separators instead of heavy borders
- hierarchy through spacing, type, alignment, opacity, and grouping
- no decorative gradients/shadows unless they clarify depth or state

### 4. Accessibility gate

Every UI pass must check:

- Dynamic Type or scalable typography where applicable
- VoiceOver labels for icon-only controls
- sufficient contrast in light and dark mode
- hit targets: minimum 44pt on touch surfaces
- keyboard navigation and focus states on macOS/iPad
- `Reduce Motion` compatibility for animations
- no color-only status communication

### 5. Engineering gate

Avoid common SwiftUI agent failures:

- massive `body` views; extract subviews
- deprecated APIs when modern alternatives exist
- custom layout where `List`, `NavigationStack`, `Form`, `Grid`, `Toolbar`, `Sidebar`, or platform controls fit
- state scattered across views without clear ownership
- visual constants duplicated instead of tokens/components
- animations attached too broadly
- async work in view bodies
- compiler-hostile nested expressions

## Review output format

When reviewing code, output:

```text
Summary: <1-3 sentence verdict>

Blocking issues:
- file:line — <issue> — <required fix>

Polish issues:
- file:line — <issue> — <suggested fix>

Accessibility:
- file:line — <issue> — <fix>

Visual QA needed:
- <screen/view> — <screenshot/build step>

Decision:
- accept / accept with fixes / reject
```

When no file/line is available, cite the screen or component name.

## Implementation guidance

When asked to implement or polish UI:

1. Make the smallest useful change.
2. Preserve existing data flow and behavior.
3. Introduce tokens/components before duplicating style constants.
4. Use semantic names: `primaryAction`, `secondaryText`, `panelBackground`, `hairlineSeparator`.
5. Test light/dark mode.
6. Build after changes.
7. If screenshots are available, critique them explicitly before claiming success.

## Anti-patterns to call out bluntly

- “Make it look like Linear” by copying dark backgrounds and purple accents only.
- Mobile app that is just the web sidebar squeezed into a phone.
- Over-carded UI: every element in a rounded rectangle.
- Heavy borders, heavy shadows, and low-density spacing pretending to be premium.
- Custom controls that lose platform affordances.
- Agent self-review with no rendered screenshot.
- “Looks good” without identifying concrete visual evidence.

## Preferred maker/checker split

For non-trivial UI work, separate roles:

- **Maker**: implements UI changes.
- **Checker**: reviews screenshot/code against this skill and rejects vague polish.

The checker should not merely praise. It should identify hierarchy, density, alignment, contrast, accessibility, and platform-convention issues.
