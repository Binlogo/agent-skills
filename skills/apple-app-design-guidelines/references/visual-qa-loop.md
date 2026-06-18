# Visual QA Loop

Use this workflow when a coding agent changes native UI. The goal is to avoid text-only self-review.

## Loop

1. Build or run the target screen.
2. Capture screenshot or SwiftUI preview output.
3. Inspect rendered UI against:
   - hierarchy
   - alignment
   - density
   - contrast
   - native platform conventions
   - accessibility risks
4. Make one focused revision pass.
5. Repeat up to 3 times.
6. Ask for human acceptance if remaining issues are subjective or pixel-level.

## Screenshot sources

Use the best available source:

- simulator screenshot
- Xcode preview screenshot
- snapshot testing image
- app screenshot supplied by user
- screen recording for motion issues

If no screenshot path exists, ask the implementing agent to add one or provide manual screenshot instructions.

## What to critique

Do not say only “looks good.” Run the `calm-dense-design` self-check (primary task obvious, chrome recedes, alignment, density vs. inflated padding, color carries state) against the screenshot, then add the Apple/render-specific checks:

- Are icon-only actions understandable without a label visible?
- Does dark mode feel harsh (pure black/white) or muddy?
- Are controls reachable by thumb on iPhone / clickable on macOS?
- Does the screen still hold up with longer copy and the largest Dynamic Type size?
- Are platform conventions (nav, toolbar, sidebar, sheets) used where expected?

## Visual reviewer output

```text
Visual verdict: accept / accept with fixes / reject

Evidence:
- <specific observation from screenshot>

Required fixes:
- <fix 1>
- <fix 2>

Optional polish:
- <polish 1>
```

## Stop rule

Stop after 3 visual iterations unless the user asks for more. Coding agents often overfit screenshots or self-declare success. Escalate subjective choices to the human.

## Maker/checker rule

The agent that implemented the UI should not be the only reviewer. Use a separate reviewer pass when quality matters.
