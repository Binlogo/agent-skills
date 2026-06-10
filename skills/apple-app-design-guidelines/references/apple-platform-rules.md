# Apple Platform Rules

Use these rules when implementing or reviewing native iOS/macOS UI. They are intentionally practical for coding agents.

## Platform baseline

Follow Apple Human Interface Guidelines as the baseline:

- hierarchy
- harmony
- consistency
- accessibility
- platform conventions

Linear-style polish must sit on top of Apple-native behavior, not replace it.

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

Create or reuse semantic tokens:

- spacing: `compact`, `regular`, `comfortable`
- color: `appBackground`, `panelBackground`, `secondaryText`, `hairlineSeparator`, `primaryAccent`
- radius: `controlRadius`, `panelRadius`, `sheetRadius`
- typography: `title`, `sectionHeader`, `rowTitle`, `metadata`, `caption`

Do not scatter literal color/spacing/radius values across many views.

## Accessibility checklist

Review every UI change for:

- VoiceOver labels for icon-only controls
- keyboard access on macOS/iPad
- focus visibility
- hit target size
- Dynamic Type behavior
- light/dark contrast
- reduced motion
- no color-only status encoding

## Build gate

After implementation, run the most specific available build/test command. If the project uses Xcode, prefer project-specific scripts first, then `xcodebuild`.

If build fails due to SwiftUI type-checking, simplify view hierarchy rather than adding type erasure everywhere.
