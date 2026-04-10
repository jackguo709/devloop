# Visual Identity

All /grow output uses this visual system. Read this file before generating any user-facing output. Follow the templates exactly.

## Brand Mark

The devloop logo. Always appears at the top of every output.

```
█▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
█ █ █▀▀ █ █ █   █ █ █ █ █▀▀
▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀
```

## Frame

Top/bottom frame only. No side borders on content lines. This avoids right-side alignment issues.

- Top: `╔` + `═` + `╗`
- Bottom: `╚` + `═` + `╝`
- Divider (below header): `╠` + `═` + `╣`

Content lines have NO side borders. Just 3 spaces of left padding.

## Header

Every output has the same header structure:

```
╔══════════════════════════════════════════════════════╗

   █▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
   █ █ █▀▀ █ █ █   █ █ █ █ █▀▀
   ▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀

   Feedback #N · Month Day, Year

╠══════════════════════════════════════════════════════╣
```

The subtitle line changes per context:

- Onboarding/daily run: `Feedback #N · April 9, 2026`
- Profile view: `Profile · Name · Background`
- History view: `History · N entries · Since Month Year`

Feedback numbers increment across all runs (onboarding is #1, first daily run is #2, etc.). Read from history.jsonl to determine the current feedback number.

## Content Rules

- 3 spaces of left padding (no side borders)
- One blank line between sections
- Two blank lines before a new section label
- Section labels are ALL CAPS, no decoration, no underlines
- No inner boxes or nested borders around any content
- Triangle bullet `▸` for action items and lists
- Close with `╚═...═╝` after the last content line + one blank line

## Progress Bars

Used for competency scores. 18 characters wide using full block `█` and light shade `░`:

```
Resilience      ████████░░░░░░░░░░  2.0
```

- Score 0: `░░░░░░░░░░░░░░░░░░  0.0`
- Score 2: `███████░░░░░░░░░░░  2.0`
- Score 5: `██████████████████  5.0`
- Unknown: `░░░░░░░░░░░░░░░░░░   ?`

Each `█` represents score/5 * 18 characters, rounded to nearest integer. Domain names are left-padded to align the bars.

## Competency Legend

Inline text, no progress bars in the legend:

```
0 Unstarted · 1 Aware · 2 Solid · 3 Deep
4 Leading · 5 Exceptional
```

## Templates

### Competency Map (onboarding, Step 5)

```
╔══════════════════════════════════════════════════════╗

   █▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
   █ █ █▀▀ █ █ █   █ █ █ █ █▀▀
   ▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀

   Feedback #1 · April 9, 2026

╠══════════════════════════════════════════════════════╣

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

   Direction (3, Deep): ...
   Pace (2, Solid): ...


   [repeat per domain]

╚══════════════════════════════════════════════════════╝
```

### Recommendation (daily /grow run)

```
╔══════════════════════════════════════════════════════╗

   █▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
   █ █ █▀▀ █ █ █   █ █ █ █ █▀▀
   ▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀

   Feedback #N · April 9, 2026

╠══════════════════════════════════════════════════════╣

   [recommendation body]

╚══════════════════════════════════════════════════════╝
```

### Profile (/grow me)

```
╔══════════════════════════════════════════════════════╗

   █▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
   █ █ █▀▀ █ █ █   █ █ █ █ █▀▀
   ▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀

   Profile · Name · Background

╠══════════════════════════════════════════════════════╣

   COMPETENCY MAP

   Resilience      ████████░░░░░░░░░░  2.0
   Product Taste   █████░░░░░░░░░░░░░  1.3
   Directing AI    ███████░░░░░░░░░░░  1.8
   Agent Fluency   ██████░░░░░░░░░░░░  1.5
   Business        █████░░░░░░░░░░░░░  1.0
   Verification    ░░░░░░░░░░░░░░░░░░   ?
   Distribution    ░░░░░░░░░░░░░░░░░░   ?


   DEEP PATTERNS

   ...


   WHAT DRIVES YOU

   ...


   PROJECTS

   ▸ project name · stage · one-line description
   ▸ project name · stage · one-line description

╚══════════════════════════════════════════════════════╝
```

### History (/grow history)

```
╔══════════════════════════════════════════════════════╗

   █▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
   █ █ █▀▀ █ █ █   █ █ █ █ █▀▀
   ▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀

   History · 3 entries · Since March 2026

╠══════════════════════════════════════════════════════╣

   Apr 9    Product Taste · article
            "How to know what to build"
            Lenny's Newsletter
            ✓ acted on

   Apr 5    Directing AI · video
            "Context engineering patterns"
            Simon Willison
            · not yet

   Mar 28   Resilience · article
            "The emotional arc of building"
            Paul Graham
            ✓ acted on

╚══════════════════════════════════════════════════════╝
```
