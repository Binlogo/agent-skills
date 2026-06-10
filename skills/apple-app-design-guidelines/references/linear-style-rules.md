# Linear-style Rules

Use these rules to approximate the qualities that make Linear and Linear Mobile feel refined. Do not copy surface aesthetics blindly.

## Product principle

Linear Mobile is a companion experience. It optimizes for fast, on-the-go workflows rather than full desktop parity.

Good mobile candidates:

- triage inbox
- capture issue/idea quickly
- approve, assign, comment, snooze
- read project updates/specs
- receive controlled notifications
- attach screenshot/photo evidence

Bad default mobile candidates:

- dense multi-column planning
- complex bulk editing
- prolonged document authoring
- admin-heavy configuration
- workflows needing many simultaneous panes

## Visual principles

### Do not compete for attention you have not earned

Secondary UI should recede:

- navigation chrome
- separators
- metadata
- empty-state decoration
- inactive tabs
- repeated icons

Main content and primary action should be obvious without shouting.

### Structure should be felt, not seen

Prefer:

- optical alignment
- consistent spacing rhythm
- subtle 1px/0.5pt separators
- opacity differences
- grouped backgrounds
- typographic hierarchy

Avoid:

- heavy borders
- large shadows
- decorative gradients
- saturated panels
- excessive icon containers

### Preserve density without clutter

Linear-like UI is information-dense. Do not create premium-looking emptiness by inflating padding.

Good density:

- concise rows
- clear metadata hierarchy
- predictable column/row alignment
- compact controls with enough hit target
- progressive disclosure for details

Bad density:

- tiny unreadable text
- crowded actions
- every row has all controls visible
- inconsistent baseline alignment

### Use restrained color

Use accent color for:

- primary action
- current selection
- important status
- focused state

Do not use accent color for decoration. Prefer warm neutral grays and semantic colors that work in light/dark mode.

### Typography

Use system fonts unless there is a strong reason not to. Hierarchy should come from size, weight, opacity, and placement.

Typical direction:

- screen title: clear, not oversized
- row title: medium weight
- metadata: smaller, lower opacity
- status labels: compact, semantic, not badge-heavy

### Motion

Motion should explain continuity or state change:

- composer appearing
- row swipe action
- selection change
- navigation transition
- inline status update

Avoid ornamental animation. Respect reduced motion.

## Native feel checklist

A Linear-style Apple app should feel native and authored, not skinned.

Check:

- Does it use platform navigation patterns?
- Are controls reachable by thumb on iPhone?
- Are macOS toolbar/sidebar/menu patterns respected?
- Does it respond gracefully to window size changes?
- Does the UI still work with large text?
- Does dark mode avoid pure black/white harshness?
- Are empty states useful, not decorative filler?

## Decision rule

If a design choice increases visual drama but does not improve orientation, speed, confidence, or task completion, remove it.
