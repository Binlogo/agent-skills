# Decision gates

Five gates a UI change must pass. Each is a *decision*, not a checklist — apply judgment, but don't silently skip one. When a gate fails, say which and why.

## 1. Scope gate — does this belong on this platform, in this form?

**iOS / iPadOS is a companion surface, not a desktop clone.** Prefer away-from-keyboard workflows; defer desktop-grade ones unless the user explicitly wants them.

- Good on mobile: triage inbox, quick capture / composer, approve·assign·comment·snooze, read updates/specs, controlled notifications, camera/photo/screenshot capture.
- Push back on mobile: dense multi-column planning, complex bulk editing, prolonged document authoring, admin-heavy configuration, many simultaneous panes.

**macOS preserves desktop power through behavior.** Keyboard shortcuts, menu-bar commands, toolbar/sidebar conventions, resizable/multi-window, hover and focus states. If a feature only makes sense with a keyboard and a large window, it's a macOS feature — don't force it onto iPhone.

Ask the scope question *before* designing pixels.

## 2. Native-first gate

Prefer SwiftUI for new UI; reach for AppKit/UIKit bridges only for platform capabilities SwiftUI can't express cleanly.

**Avoid web-style pseudo-native:** giant cards everywhere, custom buttons that ignore system pressed/disabled/focus states, fixed desktop layouts on iPhone, fake focus rings, page-transition animations, and JS/web mental models ported into SwiftUI. If a control already exists in the platform (`List`, `Form`, `Toolbar`, `Menu`, `NavigationStack`, `Sidebar`), use it before building a custom one.

## 3. Calm-density gate

The *taste* is in `calm-dense-design` (density without noise, calm without weakness, color restraint, the two decision tests) — apply it. Apple-specific application:

- Content first; navigation and chrome recede.
- One accent per screen, following the **system accent color** — not a hardcoded brand color.
- Warm/neutral grays over saturated backgrounds; hairline separators over heavy borders.
- Hierarchy from spacing, type, alignment, opacity, and grouping — not decorative gradients/shadows unless they clarify depth or state.

Linear-style polish sits *on top of* Apple-native behavior; it never replaces it.

## 4. Accessibility gate

Every UI pass checks all of these — a miss is a blocking issue, not polish:

- Dynamic Type / scalable typography where applicable
- VoiceOver labels for icon-only controls
- sufficient contrast in light *and* dark mode
- hit targets ≥ 44pt on touch surfaces
- keyboard navigation and visible focus on macOS / iPad
- `Reduce Motion` honored by animations
- no color-only status (pair color with text, shape, or icon)

## 5. Engineering gate

Catch the common SwiftUI agent failures before they ship:

- massive `body` views → extract subviews and modifiers
- deprecated APIs where a modern equivalent exists
- custom layout where `List` / `NavigationStack` / `Form` / `Grid` / `Toolbar` / `Sidebar` fits
- state scattered without clear ownership (`@State` / `@Binding` / `@Observable` / environment used deliberately)
- visual constants duplicated instead of semantic tokens/components
- animations attached too broadly instead of scoped to the state they describe
- async work in view bodies
- compiler-hostile nested expressions (break them up rather than spraying type erasure)

Implementation specifics for this gate live in `references/apple-platform-rules.md`.
