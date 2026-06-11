# 08 — Product Design: Dense, Calm, Native

T3 (*adopt the platform; don't compete with it*) still wins. Linear and Things 3 are references for product judgment, not skins to copy.

Use this file when the native shell + WebView architecture is already plausible and the question is whether the rendered product surface feels authored, fast, and native.

---

## Linear: density without noise

Linear's useful lesson is not a dark theme or purple accent. It is dense work presented with restrained hierarchy.

Prefer:

- compact rows with predictable alignment
- metadata that recedes until needed
- sidebars and navigation that stay visually quiet
- command menu and keyboard paths for frequent actions
- contextual menus for mouse-driven power users
- bulk actions that preserve selection and focus
- subtle separators over bordered boxes

Avoid:

- inflated padding sold as premium minimalism
- every row exposing every action
- decorative icons repeated in dense lists
- saturated panels competing with content
- web-style hover treatment applied uniformly

**Decision test:** if removing a visual treatment preserves orientation, speed, and confidence, remove it.

---

## Things 3: calm without weakness

Things 3's useful lesson is focused simplicity. It keeps the main task surface calm while making capture, review, and completion feel immediate.

Prefer:

- warm-neutral surfaces with subtle contrast
- clear system typography and readable metadata
- one obvious next action
- progressive disclosure for dates, tags, notes, and secondary controls
- positive-state feedback that is brief and semantic
- empty states that feel like a ready workspace, not a marketing panel

Avoid:

- hiding structure behind pale whitespace
- low-contrast text pretending to be calm
- permanent metadata fields for rare actions
- decorative completion animation
- forcing Things blue or green onto unrelated controls

**Decision test:** if calm makes the hierarchy harder to read, it is not calm; it is vague.

---

## Color and accent rules

The platform accent color is the default accent. Do not override it with brand color just because a reference app does.

Use color for:

- current selection
- focused state
- important status
- destructive state
- completion or positive-state feedback

Do not use color for decoration. A calm green can signal completion or "all good" when it is semantic, accessible, and compatible with the system accent. It is not the app's universal primary action color.

Check light and dark mode. Warm neutrals should not turn muddy in dark mode, and dark mode should avoid pure black/white harshness unless the platform material provides it.

---

## Desktop power rules

Desktop users expect power to stay visible through behavior, not visual noise.

Check:

- Are frequent actions reachable by keyboard?
- Does the command menu cover the same actions as visible buttons?
- Do contextual menus teach or mirror shortcuts?
- Does selection survive bulk actions and navigation?
- Do resizable windows preserve hierarchy at narrow and wide sizes?
- Are native menus used for app-level actions?
- Are notifications, dialogs, and file operations native?

If the interface becomes simpler by deleting a shortcut, menu item, or native affordance, the design probably became less desktop-native.

---

## WebView-specific reminders

The WebView renders the product surface, but the surface must not behave like a browser page.

Keep:

- system fonts
- native scroll behavior
- native focus rings or faithful equivalents
- platform materials behind the window
- system accent integration
- keyboard navigation across the rendered UI

Avoid:

- `cursor: pointer` on native-style rows
- custom modal overlays for OS-level confirmations
- web toasts instead of OS notifications
- page-transition animations
- hardcoded brand accents in platform chrome

See `references/06-native-conventions.md` before claiming the app feels native.

---

## Final rule

Linear should make the product faster and denser. Things 3 should make it calmer and clearer. If either reference makes the app less native, less legible, or less direct, ignore the reference and follow the platform.
