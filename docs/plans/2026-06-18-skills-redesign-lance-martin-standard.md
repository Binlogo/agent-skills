# Skills redesign — Lance Martin / context-engineering standard

**Date:** 2026-06-18
**Scope:** Deep restructure of the two existing skills, plus extraction of one shared skill.

## The standard (7 lenses)

1. **Progressive disclosure / token frugality** — only `description` is always in context; SKILL.md body loads on trigger; deep detail in references loaded on demand.
2. **Right altitude** — heuristics over exhaustive rules; trust the model.
3. **Trigger-precise description** — third person, scenario keywords, no bloat; states when *not* to use.
4. **Single responsibility / composable** — one skill = one capability.
5. **Concrete > abstract** — examples, anti-patterns, decision trees.
6. **Evaluable** — instructions observable/testable.
7. **No context rot** — no redundancy, no time-bound facts, no cross-file overlap.

## Architecture decision: 2 skills → 3

The Linear/Things "calm, dense" design taste was duplicated (~50%) across both skills and is genuinely platform-agnostic and independently triggerable. Extracted it into a new shared skill rather than cross-linking (which would have pointed a Windows developer at an "apple-" skill) or leaving it duplicated.

- **`calm-dense-design` (new)** — platform-agnostic product-UI taste. Owns the Linear-density / Things-calm principles, color/type/motion restraint, two decision tests, self-check. Consumed by the two platform skills; works standalone for web or any surface.
- **`apple-app-design-guidelines` (restructured)** — Apple platform conventions + SwiftUI/AppKit engineering + accessibility + visual QA. Defers taste to `calm-dense-design`.
- **`native-feel-desktop` (restructured)** — cross-platform native-feel *architecture/engineering* only. Defers taste to `calm-dense-design`.

When taste and platform conflict, the platform skill wins.

## Per-skill changes

### calm-dense-design (new)
- `SKILL.md` (57 lines): two lessons, 5 principles (rule + the cut it forces), type/motion, two decision tests, self-check, "not this skill's job" boundary.
- `references/in-practice.md`: concrete (illustrative) values, expanded Prefer/Avoid, review-pass procedure.
- Sourced by merging the old `apple/linear-style-rules.md` + `native-feel/08-product-design.md`, de-duplicated and generalized.

### apple-app-design-guidelines
- SKILL.md **157 → 56 lines**. Inline now: 5 one-line anchors, review output format, anti-patterns, cross-refs. Operating model and the 5 gates moved out.
- **New `references/decision-gates.md`** — the five gates (scope / native-first / calm-density / accessibility / engineering) as Prefer/Avoid + Apple specifics. iOS-companion scope guidance folded in here from the deleted `linear-style-rules.md`.
- `apple-platform-rules.md` — accessibility list de-duplicated (gate 4 is now the single source; this file keeps SwiftUI *implementation* hints only); tokens marked illustrative; taste pointed at `calm-dense-design`.
- `visual-qa-loop.md` — taste questions defer to `calm-dense-design` self-check; Apple/render-specific checks kept.
- **Deleted** `linear-style-rules.md` (content split into `calm-dense-design` + `decision-gates.md`).

### native-feel-desktop
- `description` **~360 words → ~620 chars**, with explicit "wrong for X" guards.
- SKILL.md restructured **decision-tree-first** ("qualify before recommending"); reference map updated; taste pointed at `calm-dense-design`.
- **Merged** `06-native-conventions.md` + `ship-readiness.md` → **`06-native-feel-checklist.md`** (~70% overlap removed; reframed as a heuristic with a "highest-signal tells" section, not 75 binary checkboxes).
- **Deleted** `08-product-design.md` (moved to `calm-dense-design`).
- **De-timed** version-bound facts across `02/03/05/07` ("Xcode 17", "as of 2026", "v0.60.0", "seven entry points", "Raycast v1 200–300 MB"). All forensic/version specifics now quarantined in `07-evidence-raycast.md`, which carries a "read for the pattern, not the literals" snapshot disclaimer and is the single owner of the UniFFI symbol detail (removed from `02` and `04`).
- **Added** an L4 (Rust) "when to add" threshold heuristic in `02`, and a concrete IPC hot-loop example in `04` (the T6 concrete-example gap).

## Deliberately NOT done (and why)

- **Did not split `apple-app-design-guidelines` further.** The audit flagged it as covering many concerns, but it's one coherent "Apple design review" capability; splitting would fragment it. Internal boundaries are handled by references instead.
- **Did not rewrite `01-philosophy.md` "example-first".** It already leads tenets with concrete cues (platform blur, hotkey latency) and a hot-loop example; over-rewriting a strong file risked degrading it.
- **Did not gut `07-evidence-raycast.md` to ~60 lines.** Its forensic detail *is* its value, and it's the designated, clearly-labeled home for the point-in-time specifics other files now avoid. De-timed + de-duplicated instead.
- **Left `decision-tree.md` unchanged.** Already an excellent, concrete decision gate.

## Verification

- No dangling references to deleted/renamed files.
- Cross-skill references are clean and bidirectional.
- `name:` matches directory for all three; descriptions 588–622 chars (well under limit).
