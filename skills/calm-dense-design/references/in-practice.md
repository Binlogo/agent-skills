# Calm, Dense Design — in practice

Concrete moves behind the principles. Numbers here are **illustrative anchors**, not a spec — they show the *shape* of a good choice, not a value to hardcode. Match the platform's metrics and the surrounding design.

## Density without clutter

A dense list row is calm when it has one strong element and everything else recedes.

**Prefer**
- one title at full strength; metadata one size down and at ~50–70% opacity
- a single predictable trailing slot (status, count, or time) — not three competing ones
- row-level actions revealed on hover/focus/selection, not all visible at rest
- a consistent vertical rhythm (e.g. a repeating row height and a single gutter value) so the eye tracks a grid
- progressive disclosure: dates, tags, notes, and rare controls appear when relevant

**Avoid**
- every row exposing every action "to save a click"
- inflated padding (e.g. tripling row height) sold as premium minimalism
- decorative icons repeated down a dense list — they become visual noise
- shrinking text below readable size to fit more in

Rule of thumb: if you doubled the content, would the layout still read? Dense-but-calm scales; padding-as-luxury doesn't.

## Structure felt, not seen

**Prefer** — optical alignment, a small set of spacing values used consistently, hairline separators (0.5–1px) at low contrast, opacity steps to push things back, grouped backgrounds to bundle related items, type weight/size for hierarchy.

**Avoid** — heavy 1–2px borders boxing every element, large drop shadows for "depth," decorative gradients, saturated background panels behind content, an icon-in-a-rounded-square around everything.

Test: squint at the screen. If you still see a grid of boxes and lines, structure is *seen*. If you see content in a clear hierarchy, structure is *felt*.

## Calm that clarifies

**Prefer** — warm-neutral surfaces with enough contrast to read; one obvious next action per view; brief, semantic completion feedback; empty states that look like a ready workspace ("nothing here yet, here's how to start"), not a marketing illustration.

**Avoid** — pale whitespace that hides where the structure is; low-contrast gray text that fails legibility while pretending to be quiet; permanent fields for rare actions; a celebratory animation on every small completion.

## Restrained semantic color

Map each color use to a *meaning*, then check the map is short:

| Use | Color |
|---|---|
| primary action / selection / focus | system accent (don't override it) |
| important / warning / destructive | semantic system colors |
| completion / positive state | a semantic green — a cue, not the brand |
| everything else | warm-neutral grays |

If the map has an entry like "section header — brand purple because it looks nice," that's decoration. Cut it. Verify the whole map in light *and* dark mode; warm neutrals shouldn't turn muddy, and dark mode shouldn't be pure-black/white harshness unless a platform material provides it.

## Applying it in a review pass

1. **Name the primary task** of the screen in one sentence. If you can't, the hierarchy is the bug.
2. **Find what shouts.** List every element competing with the primary task (a saturated panel, a heavy border, a brand-colored chrome element). Each is a candidate for recede-or-remove.
3. **Run the two tests** (drama test, calm test) on each questionable treatment.
4. **Check the color map** is short and semantic.
5. **Report findings as `element — issue — fix`**, e.g. `list row trailing area — three icons compete — keep status, reveal others on hover`.

Don't end on "looks good." End on what you checked and what you'd change — or state that each item above passed and why.
