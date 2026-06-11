---
title: "docs: Add Linear and Things design references"
type: docs
status: completed
date: 2026-06-11
origin: docs/brainstorms/2026-06-10-linear-things-design-references-requirements.md
---

# docs: Add Linear and Things design references

## Summary

Extend the existing design skills with concise Linear and Things 3 references while keeping platform conventions authoritative. The work updates the Apple design skill, adds one focused cross-platform desktop product-design reference, and keeps README discovery accurate.

## Problem Frame

The repo already has Linear-style Apple UI guidance and a native-feel desktop skill focused on architecture and platform behavior. It lacks a compact shared design-quality layer that covers Things 3 and makes Linear useful beyond Apple UI without turning either product into a skin to copy.

## Requirements

**Skill coverage**

- R1. `apple-app-design-guidelines` covers Linear and Things 3 references for iOS, iPadOS, and macOS UI work.
- R2. `native-feel-desktop` covers Linear and Things 3 references for cross-platform desktop UI where the shell is native and the WebView is a rendering surface.
- R3. `README.md` summaries reflect the expanded design scope without overpromising a design system.

**Design reference content**

- R4. Linear guidance covers calm density, restrained chrome, speed, desktop keyboard/contextual workflows, and mobile companion workflows.
- R5. Things 3 guidance covers warm-neutral surfaces, clear typography, focused simplicity, sparse semantic color, calm positive-state accents, and place-preserving motion.
- R6. Mobile guidance defaults to triage, capture, review, reaction, comments, and lightweight edits rather than compressed desktop parity.
- R7. Desktop guidance preserves density, keyboard access, contextual actions, resizable layouts, platform menus, and compact hierarchy.

**Authoring quality**

- R8. `SKILL.md` files stay lean and delegate detailed rules to `references/*.md`.
- R9. New prose is English-only, normative, and concise enough for agents to apply during implementation or review.
- R10. The guidance forbids hardcoded brand imitation, including fixed Linear purple, forced Things blue, or mandatory green accents that override platform accent behavior.

## Key Technical Decisions

- **Extend existing skill surfaces:** Update the two existing skills rather than adding a standalone design-reference skill, preserving the repo's one-skill-per-purpose shape.
- **Keep Apple detail in the existing visual reference:** Expand the current Linear-style reference for Apple UI into Linear + Things guidance so the Apple entry point stays lean.
- **Add one desktop product-design reference:** Keep `native-feel-desktop` architecture and native-convention references focused by adding a separate design-quality reference for Linear/Things desktop guidance.
- **Treat green as semantic, not global:** Things 3's completion/positive-state green is a cue for sparse semantic emphasis, subordinate to system accent colors, contrast, and accessibility.

## Implementation Units

### U1. Expand Apple design guidance

- **Goal:** Update the Apple design skill so Linear and Things 3 both inform iOS, iPadOS, and macOS UI review and implementation guidance.
- **Requirements:** R1, R4, R5, R6, R8, R9, R10.
- **Dependencies:** None.
- **Files:** `skills/apple-app-design-guidelines/SKILL.md`; `skills/apple-app-design-guidelines/references/linear-style-rules.md`.
- **Approach:** Keep the entry point compact by adjusting the description, source-of-truth reference list, and gates only where discovery or priority changes. Put the expanded visual/product principles in the reference file, preserving the existing warning against superficial Linear imitation and adding Things 3 as a focused-simplicity reference.
- **Patterns to follow:** The existing `SKILL.md` operating model and the current checklist style in `references/linear-style-rules.md`.
- **Test scenarios:** Test expectation: none -- documentation-only skill content with no executable behavior.
- **Verification:** The Apple skill mentions Linear and Things 3, preserves Apple-native rules as the baseline, distinguishes mobile companion workflows from desktop parity, carries typography and hierarchy guidance, and avoids fixed brand-color mandates.

### U2. Add desktop product-design reference

- **Goal:** Give `native-feel-desktop` a concise design-quality layer for Linear and Things 3 within its native-shell/WebView architecture focus.
- **Requirements:** R2, R4, R5, R7, R8, R9, R10.
- **Dependencies:** None.
- **Files:** `skills/native-feel-desktop/SKILL.md`; `skills/native-feel-desktop/references/08-product-design.md`; optionally `skills/native-feel-desktop/references/06-native-conventions.md`.
- **Approach:** Add one new reference for product-design guidance and list it in the "Load only what's needed" section. Keep `06-native-conventions.md` as the native-behavior audit; only cross-link or add a small checklist note if needed to make the new reference discoverable during UI review.
- **Patterns to follow:** The numbered reference naming already used by `native-feel-desktop` and its tenet/audit style that names trade-offs directly.
- **Test scenarios:** Test expectation: none -- documentation-only skill content with no executable behavior.
- **Verification:** Desktop guidance covers density, contextual actions, command/keyboard workflows, warm-neutral restraint, clear typography, and semantic positive-state accents while preserving system fonts, native menus, system accent behavior, platform materials, and accessibility.

### U3. Update discovery and run manual verification

- **Goal:** Keep repo-level discovery accurate and verify the change respects the brainstorm boundaries.
- **Requirements:** R3, R8, R9, R10.
- **Dependencies:** U1, U2.
- **Files:** `README.md`; no test files.
- **Approach:** Update the README summaries for both skills with one concise phrase about Linear + Things 3 design guidance. After edits, review the diff for English-only prose, frontmatter validity, lean entry points, and absence of new scaffolding.
- **Patterns to follow:** The short skill summaries in `README.md` and the authoring conventions in `AGENTS.md`.
- **Test scenarios:** Test expectation: none -- verification is manual because the repo has no test harness and the change is Markdown-only.
- **Verification:** Search both target skill directories for `Things` and `Linear`; check that no new skill directory, scripts, CI, token library, component library, or design-system files were added; search for wording that mandates copying brand colors or cloning either product.

## Scope Boundaries

Explicitly not in this plan:

- Creating a standalone design-reference skill.
- Building a design system, component library, token library, screenshot catalog, validator, script, or CI workflow.
- Rewriting the existing Raycast-derived architecture references.
- Prescribing exact colors, component APIs, or implementation code.
- Claiming Linear or Things 3 aesthetics override Apple, macOS, Windows, or accessibility conventions.

## Risks & Dependencies

- **Entry-point bloat:** Adding too much prose to `SKILL.md` would weaken trigger clarity. Keep detailed guidance in references.
- **Brand-copy drift:** Product references can slip into surface imitation. Verification should reject fixed brand-color mandates and "clone" language.
- **Desktop reference discoverability:** A new desktop reference must be linked from `native-feel-desktop/SKILL.md`; otherwise agents may not load it.

## Sources / Research

- Origin requirements: `docs/brainstorms/2026-06-10-linear-things-design-references-requirements.md`.
- Repo conventions: `AGENTS.md`.
- Existing Apple skill: `skills/apple-app-design-guidelines/SKILL.md`; `skills/apple-app-design-guidelines/references/linear-style-rules.md`; `skills/apple-app-design-guidelines/references/apple-platform-rules.md`.
- Existing desktop skill: `skills/native-feel-desktop/SKILL.md`; `skills/native-feel-desktop/references/06-native-conventions.md`; `skills/native-feel-desktop/references/ship-readiness.md`.
- External grounding: Linear design refresh and docs for density, hierarchy, contextual actions, command/keyboard workflows, and away-from-keyboard mobile positioning.
- External grounding: Things 3 first-party materials and reviews for focused simplicity, neutral surfaces, sparse semantic color, tactile completion, and keyboard-capable native productivity.
