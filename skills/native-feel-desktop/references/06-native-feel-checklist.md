# 06 — Native-feel checklist

Where T3 (*adopt the platform*) and T4 (*performance is perception*) converge. Each item is a behavior that, when wrong, telegraphs "web app." None moves a benchmark; all change what the user *feels*.

This is a **heuristic, not a binary gate.** There are degrees of native-ness. Use it to find the highest-signal misses, not to chase 100% checkmarks. The goal: a skeptic who uses native apps daily examines yours for 30 seconds and concludes "this is a regular Mac/Windows app."

## Do this test first

Hand the app to a designer who lives in native Mac/Windows apps but has never seen yours. Say nothing. Watch for the first time they say *"wait, this feels weird."* That moment is one item below. Find it, fix it. This single test out-diagnoses the whole list.

## Highest-signal tells (fix these before anything else)

These are the common offenders that most cheaply scream "web":

1. `cursor: pointer` on rows, buttons, or tabs — native never changes the cursor there.
2. Text selectable on chrome (labels, headings, button text) — selection belongs to content only.
3. WebKit's context menu instead of a native one (or none).
4. "Dialogs" as DOM overlays with backdrop blur instead of `NSAlert` / `MessageBox` / native sheets.
5. Web "toasts" instead of OS notifications.
6. Hardcoded brand accent instead of the **system** accent color.
7. A web font for chrome instead of the system font.
8. CSS `box-shadow` / `border-radius` faking the window's shadow and corners — the OS draws those.
9. Page transitions / route fades — native apps cut between views.
10. Loading skeletons for sub-200 ms operations — a web idiom that makes fast feel slow.
11. Missing keyboard navigation or non-platform focus rings.
12. A white/black flash before content paints on launch.
13. *Uniform* hover treatment on every control (see the precise hover rule below).

In review, grep for: `cursor: pointer`, `user-select` outside editable areas, `behavior: 'smooth'`, custom modal overlays, hardcoded `#0066cc`-type accents.

## Full audit, by area

**Input & cursor**
- Caret/I-beam on editable areas only; no link previews (`-webkit-touch-callout`), no spellcheck underlines on chrome, no dictionary popup on force-tap.
- IME composition window appears *at the caret*, not above the WebView. Test Pinyin, Japanese kana, Korean Hangul.

**Windowing & focus**
- Platform window verbs work: ⌘W / Alt-F4 close, ⌘M / Win+Down minimize. Green button *zooms* to content size on Mac (fullscreen only with Option).
- Window remembers size/position across launches, per-screen on multi-monitor; opens on the active screen, not screen 0.
- Re-focusing (Dock/Taskbar click) re-shows the last window rather than spawning a new one, unless identity demands otherwise.
- Settings open in a native window (⌘, / Ctrl,), not an in-window modal.
- Real title bar (or a real chromeless drag region) — drag works across the whole bar, not a centered handle. Window controls on the platform's side.
- On focus loss, a launcher hides predictably (or follows its configured behavior).

**Materials & visual**
- Window background is a platform material, not a static color: `NSVisualEffectView` (or the newer Liquid Glass material on recent macOS); `DwmSetWindowAttribute(DWMWA_SYSTEMBACKDROP_TYPE, …)` for mica/acrylic on Windows.
- Dark mode follows system, toggles without per-frame flicker. Accent follows `NSColor.controlAccentColor` / `UISettings` accent. System font (`-apple-system` / `Segoe UI Variable`).
- Window corner radius matches the system's standard — don't hardcode it.

**Scrolling & motion**
- Mac overlay scrollbars that fade (WebKit default if you let it); thin scrollbars on Windows 11+. No `behavior: 'smooth'` polyfills, no rubber-band override. Scroll position survives in-window navigation (router scroll restoration).
- Animations honor `prefers-reduced-motion`. Window resize is animated by the OS — push resize to the shell, don't JS-animate layout. Reserve spring/bounce for grab-and-drag; use tight ease curves elsewhere.

**Keyboard**
- Every actionable element reachable via Tab/arrows; logical tab order (not DOM order if they differ). Platform shortcuts (⌘F vs Ctrl-F). Escape always does something meaningful. Type-ahead jumps to matching list items.

**File & drag-and-drop**
- Native drag-and-drop with file URLs (`NSPasteboard` / `IDataObject`), not the web drag API. Dropping files on the dock/app icon opens them. Copy writes all expected pasteboard types (text + RTF + HTML for rich content). Native save panels, not download bars.

**System integration**
- Correct `Info.plist` / app manifest (identifier, version, icon, document types). `appname://` URL scheme works system-wide; file associations open the app. Single-instance on Windows (second launch focuses the existing one). Real auto-update (Sparkle / MSIX / custom), not "download a new version." Crash reports go to a real reporter with symbolicated traces.

**Accessibility**
- VoiceOver / Narrator can navigate everything (proper ARIA on WebView content; native controls self-handle). Focus is announced on move. Contrast ≥ WCAG AA. No fixed-pixel sizes that break when the system font scales. Every action reachable without a mouse.

**Performance** (see `05-memory-truths.md` for what to measure)
- Resident memory within this stack's stated idle budget; no hitch expanding results or typing fast into live search. Background CPU near zero when hidden — and confirm the hidden window isn't WebKit-throttled (scheduled updates fire promptly on re-show). Heavy indexing off the main process. Plugin crash doesn't take down the app. Loading state for >200 ms operations; nothing under.

**Cross-platform parity**
- Same feature set both OSes; both shells hit the same IPC schema version after update; third-party extensions behave identically; visual differences track platform conventions, not arbitrariness; most bug fixes propagate from one codebase change.

## Edge cases worth naming

**Hover — the precise rule.** The error is never "too much" or "too little" hover; it's *uniform* hover (a web idiom). Native varies by control kind — ask "what does the equivalent native control do here?" and do exactly that:
- list rows / sidebar / toolbar items → subtle hover background (keep it; only `cursor: pointer` is the tell)
- plain push buttons → no hover effect at all
- borderless icon buttons → subtle background tint
- content hyperlinks → underline on hover; never on navigation chrome

**Buttons.** Native buttons have a distinct *pressed* state, not just hover. Add an `:active` style that visibly depresses.

**Loading thresholds.** < 200 ms: show nothing, commit on arrival. 200 ms–2 s: spinner. > 2 s: progress. Never skeletons under ~500 ms — they make fast feel slow.

**Empty states & onboarding.** Native is terse: an icon + one line, no marketing panel. Native apps rarely ship multi-step tours — the interface should be self-explanatory; teach with a first-hover tooltip, once.

## How to use

- **PR review:** pick the 5–10 items touching the PR's surface and the grep targets above.
- **Regression audit after a refactor:** walk the whole list — refactors silently undo native-feel work.
- **"The app feels weird":** walk the user through the list; usually a single named item lands the unconscious "this is wrong."
