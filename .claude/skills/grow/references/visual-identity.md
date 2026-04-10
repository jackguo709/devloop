# Visual Identity

All /grow output uses this visual system. Follow the templates exactly.

## Header

Every output starts with this. Do not repeat the logo elsewhere.

```
╔══════════════════════════════════════════════════════╗

   █▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
   █ █ █▀▀ █ █ █   █ █ █ █ █▀▀
   ▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀

   [subtitle]

╠══════════════════════════════════════════════════════╣
```

Subtitles: onboarding/daily `Feedback #N · April 9, 2026` (N from history.jsonl, onboarding is #1) | profile `Profile · Name · Background` | history `History · N entries · Since Month Year`

## Formatting Rules

- Top/bottom frame only (`╔═╗`, `╚═╝`, `╠═╣`). No side borders on content lines.
- 3 spaces left padding. Section labels: ALL CAPS, no decoration.
- One blank line between sections, two before a new label. `▸` for lists.
- Close with `╚══...══╝` after last content + one blank line.

## Progress Bars

18 chars wide: `█` filled, `░` empty. Formula: `round(score/5 * 18)` filled blocks. Unknown: `░░░░░░░░░░░░░░░░░░   ?`. Domain names left-padded to align bars.

```
Resilience      ████████░░░░░░░░░░  2.0
```

## Templates

All templates: header (above) + body (below) + closing `╚══...══╝`.

### Competency Map (onboarding)

```
   [opening insight]

   COMPETENCY MAP

   0 Unstarted · 1 Aware · 2 Solid · 3 Deep
   4 Leading · 5 Exceptional

   Resilience      ████████░░░░░░░░░░  2.0
   Product Taste   █████░░░░░░░░░░░░░  1.3
   Directing AI    ███████░░░░░░░░░░░  1.8
   Agent Fluency   ██████░░░░░░░░░░░░  1.5
   Business        █████░░░░░░░░░░░░░  1.0
   Verification    ░░░░░░░░░░░░░░░░░░   ?
   Distribution    ░░░░░░░░░░░░░░░░░░   ?

   RESILIENCE (2.0)

   Direction (3): ...
   Pace (2): ...

   [repeat per domain]
```

### Recommendation

Body is the recommendation text. No sections.

### Profile

```
   COMPETENCY MAP
   [progress bars]

   DEEP PATTERNS
   ...

   WHAT DRIVES YOU
   ...

   PROJECTS
   ▸ project name · stage · one-line description
```

### History

```
   Apr 9    Product Taste · article
            "How to know what to build"
            Lenny's Newsletter
            ✓ acted on

   Apr 5    Directing AI · video
            "Context engineering patterns"
            Simon Willison
            · not yet
```
