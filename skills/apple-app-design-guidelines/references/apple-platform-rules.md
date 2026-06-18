# Apple Platform Rules

Use these rules when implementing or reviewing native iOS/macOS UI. They are intentionally practical for coding agents. Design *taste* (density, calm, color restraint) is in `calm-dense-design`; this file is the Apple-native *implementation* layer that sits on top of it.

## Platform baseline

Follow Apple Human Interface Guidelines as the baseline: hierarchy, harmony, consistency, accessibility, platform conventions. Calm/dense polish sits *on top of* Apple-native behavior — it never replaces it.

## iOS rules

Prefer:

- `NavigationStack` for hierarchical flows
- tab/navigation patterns only when the information architecture needs them
- sheets for focused creation/editing tasks
- swipe actions for inbox-like triage
- toolbar actions for primary contextual actions
- system materials/backgrounds when appropriate
- haptics only for meaningful state changes

Avoid:

- desktop sidebars squeezed onto iPhone
- small custom controls below 44pt hit target
- dense tables with too many simultaneous actions
- hidden gestures with no visible affordance
- fixed-size layouts that break with Dynamic Type

## macOS rules

Prefer:

- sidebar + detail layouts for productivity apps
- toolbars for frequent actions
- menu commands for app-level actions
- keyboard shortcuts for power workflows
- resizable windows and adaptive layouts
- hover and focus states
- context menus where discoverability is acceptable

Avoid:

- iOS-only patterns copied directly to macOS
- touch-sized controls everywhere with no desktop density
- custom titlebars/toolbars unless justified
- missing keyboard navigation
- ignoring window resizing and multi-monitor contexts

## SwiftUI implementation rules

Use SwiftUI idiomatically:

- keep `body` small; extract views and modifiers
- use semantic state ownership (`@State`, `@Binding`, `@Observable`, environment) deliberately
- avoid async work directly in view bodies
- avoid duplicated magic numbers; introduce tokens/components
- prefer platform controls before custom controls
- keep animations scoped to the state they describe
- break complex expressions when compiler type-checking slows/fails

## Design token guidance

Create or reuse semantic tokens instead of scattering literal color/spacing/radius values across views. Names below are an *illustrative* shape, not a required set:

- spacing: `compact`, `regular`, `comfortable`
- color: `appBackground`, `panelBackground`, `secondaryText`, `hairlineSeparator`, `primaryAccent`
- radius: `controlRadius`, `panelRadius`, `sheetRadius`
- typography: `title`, `sectionHeader`, `rowTitle`, `metadata`, `caption`

## Accessibility implementation

The accessibility *gate* (what to check) is in `decision-gates.md` gate 4 — that's the single source of truth. Implement it with the platform's own affordances rather than reinventing them:

- icon-only controls → `.accessibilityLabel`; group related elements with `.accessibilityElement(children:)`
- scalable type → system text styles or `@ScaledMetric`; test the largest Dynamic Type size
- focus/keyboard on macOS·iPad → `.focusable`, `.focused`, `@FocusState`, and `.keyboardShortcut`
- motion → gate behind `@Environment(\.accessibilityReduceMotion)`
- status → pair color with text/shape/SF Symbol, never color alone

## Build gate

After implementation, run the most specific available build/test command. If the project uses Xcode, prefer project-specific scripts first, then `xcodebuild`.

If build fails due to SwiftUI type-checking, simplify view hierarchy rather than adding type erasure everywhere.
