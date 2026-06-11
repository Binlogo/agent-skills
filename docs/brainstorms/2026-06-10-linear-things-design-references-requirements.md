---
date: 2026-06-10
topic: linear-things-design-references
---

# Linear and Things 3 Design References

## Summary

Update the existing design-oriented skills so agents can apply Linear's dense, restrained product feel and Things 3's warm-neutral calm to both desktop and mobile UI work. The references should be concise, practical, and framed as judgment rules rather than a copied visual skin.

## Problem Frame

The repo already has a Linear-style reference for Apple-native UI, and `native-feel-desktop` focuses on architecture, platform behavior, and native conventions. What is missing is a shared design-quality layer that helps agents make desktop and mobile visual decisions without bloating the skill entry points or turning brand references into imitation.

## Key Decisions

- **Update existing skills.** Add the guidance to `apple-app-design-guidelines` and `native-feel-desktop` rather than creating a third design-reference skill.
- **Use brand references as principles, not skins.** Linear contributes information density, restraint, speed, keyboard/contextual workflows, and mobile companion scope. Things 3 contributes calm hierarchy, warm-neutral surfaces, sparse semantic color, and focused task flow.
- **Keep platform conventions ahead of brand influence.** The guidance must not override Apple-native, macOS, Windows, or system accent behavior.

## Requirements

**Coverage**

- R1. `apple-app-design-guidelines` covers Linear and Things 3 references for iOS, iPadOS, and macOS UI work.
- R2. `native-feel-desktop` covers the same design references for cross-platform desktop UI work where the shell is native and the WebView is a rendering surface.
- R3. The README skill summaries remain accurate after the expanded design scope.

**Reference content**

- R4. Linear guidance emphasizes calm information density, restrained chrome, fast workflows, keyboard/context menu affordances on desktop, and away-from-keyboard companion workflows on mobile.
- R5. Things 3 guidance emphasizes warm-neutral surfaces, clear typography, sparse semantic color, calm green completion or positive-state accents, and animations that preserve place rather than decorate.
- R6. Mobile guidance distinguishes companion workflows from desktop parity: triage, capture, review, react, comment, and lightweight edits are in; dense multi-pane planning and bulk editing are not default mobile goals.
- R7. Desktop guidance preserves power-user density: keyboard access, contextual actions, resizable layouts, platform menus, and compact information hierarchy.

**Authoring quality**

- R8. `SKILL.md` files stay lean and trigger-rich; bulky details live in `references/*.md`.
- R9. New reference prose is English-only, normative, and concise enough for agents to apply during implementation or review.
- R10. The guidance avoids hardcoded imitation such as copying Linear purple, forcing Things blue, or overriding system accent colors with a fixed green.

## Scope Boundaries

Explicitly not building:

- A new standalone design-reference skill.
- A full design system, token library, component library, or screenshot catalog.
- A visual clone of Linear or Things 3.
- New validation tooling, scripts, CI, or repo structure changes.
- Deep implementation planning for exact file edits, token names, or component APIs.

## Dependencies / Assumptions

- Public Linear materials establish desktop speed and keyboard workflow as central, and Linear Mobile as a purpose-built away-from-keyboard companion experience.
- Public Things 3 references establish the useful design signal as focused simplicity, neutral interface weight, sparse semantic color, and calm movement.
- `native-feel-desktop` already requires system-native behavior; any green accent guidance must remain semantic and subordinate to platform accent rules.

## Sources / Research

- `skills/apple-app-design-guidelines/SKILL.md`
- `skills/apple-app-design-guidelines/references/linear-style-rules.md`
- `skills/native-feel-desktop/SKILL.md`
- `skills/native-feel-desktop/references/06-native-conventions.md`
- `skills/native-feel-desktop/references/ship-readiness.md`
- Linear Mobile public page: away-from-keyboard workflows, native mobile app, inbox triage, quick capture, compact reading.
- Things 3 public and third-party design references: focused simplicity, neutral surfaces, sparse semantic color, completion/positive-state green.
