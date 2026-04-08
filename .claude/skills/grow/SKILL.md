---
name: grow
description: |
  Your growth engine. Scans your code, conversations, and work patterns, finds the one
  piece of content that matters most, and delivers it with a reflection question that sticks.
  Run /grow for a recommendation. First run triggers onboarding.
argument-hint: "[me|history]"
disable-model-invocation: true
allowed-tools:
  - Agent
  - Bash
  - Read
  - Write
  - Glob
  - Grep
  - WebSearch
  - WebFetch
  - AskUserQuestion
---

## Context

```!
GROW_DIR="$HOME/.grow"
PROFILE="$GROW_DIR/profile.md"
mkdir -p "$GROW_DIR/observations"
[ -f "$PROFILE" ] && echo "PROFILE_EXISTS=true" || echo "PROFILE_EXISTS=false"
echo "GROW_DIR=$GROW_DIR"
```

## Routing

If `PROFILE_EXISTS=false`, read [onboarding.md](onboarding.md) and follow its instructions.

If `PROFILE_EXISTS=true`:

- No arguments or empty `$ARGUMENTS` → read [run.md](run.md) and follow its instructions
- `$ARGUMENTS` = "me" → read [me.md](me.md) and follow its instructions
- `$ARGUMENTS` = "history" → read [history.md](history.md) and follow its instructions

---

## Find Content

Two parallel pipelines search for different things. Each pipeline gets 1-2 Sonnet subagents with a tight brief — what to find, where to look, and why it matters for this user. ONLY return content from sources listed in [sources.md](references/sources.md).

### Pipeline A: Gap-based

Search for content that addresses the user's biggest growth opportunity. The targeting step identifies the specific domain and concept — this pipeline finds the best writing on that topic. Prefer last 30 days, but older canonical content wins if it's the definitive piece.

### Pipeline B: Recency-first

The AI ecosystem shifts weekly. This pipeline catches tools, skills, concepts, patterns, and what other builders are doing that the user doesn't know about yet. Last 7 days preferred, 14 days max. Relevance includes broader patterns that could change how they think or work, not just direct matches to their stack.

### Topic selection

Pick ONE topic from across both pipelines, informed by profile.md, observations, and history.jsonl. Weigh these factors:

**Leverage.** What would have the most impact given their state? Priority: product direction > tools/workflow > approach > skill gaps. Resilience is highest-order but requires established trust. Not rigid — a recency-first finding about a tool that eliminates their current project can outrank everything.

**Readiness.** Are they facing this problem NOW? A prototyping project needs "validate demand before building more," not "scale your channels."

**ZPD.** Match the recommendation to where they actually are. Domain levels give the rough picture; individual observations show which concepts they've mastered vs never encountered.

**Variety.** Don't repeat recent topics. Don't push topics where past recommendations were ignored.

**Self-efficacy.** Low confidence: lead with what's working, then the gap. High confidence: lead with the gap directly. Sometimes the highest-leverage move is reinforcement, not correction.

Then find 2-3 voices or perspectives on that topic.

---

## Deliver

One cohesive output, 250-400 words, on the single topic from Find Content.

**Structure:**

1. Open with something specific from their work or sessions. Earns attention.
2. Synthesize 2-3 voices into one narrative. Cite each source with author, who they are, and URL to build social proof.
3. Connect every sentence to their situation.
4. End with an actionable next step the LLM can implement with permission. Not "you should try X" but "want me to install this skill?" or "want me to set up this pattern?"

**Voice:**

Write like a sharp friend who shipped code today. Use their name. Short paragraphs, punchy sentences, curious not lecturing. "What's interesting here is..." beats "It is important to understand..."

Be specific. Reference their actual projects, decisions, and words:

- GOOD: "You have 8 projects in 9 months and none have a landing page."
- BAD: "You demonstrate strong building skills but could improve distribution."

Feedforward, not correction. Frame as what to do next, not what went wrong.

No AI slop. Avoid: delve, crucial, robust, comprehensive, nuanced, pivotal, landscape, tapestry, foster, showcase, intricate, fundamental, significant. No em dashes. No throat-clearing, generic optimism, or unsupported claims.

---

## Save

After every run, silently update state.

```
~/.grow/
  observations/                    # append-only, one file per domain
    resilience.md
    product-taste.md
    directing-ai.md
    agent-fluency.md
    verification.md
    distribution.md
    business.md
  profile.md                       # projects, workflow, patterns, readiness, motivation
  history.jsonl                    # one line per recommendation
```

### Observation format

```markdown
# [Domain Name]

- YYYY-MM-DD | positive/negative | concept | observation text | source category
```

Concepts are defined in [competency-map.md](references/competency-map.md). Use the exact concept names. Examples: `context engineering`, `web presence & SEO`.

Source categories:

- `codebase` — from anything in the codebase
- `CLI session` — from Claude Code logs
- `desktop session` — from Claude Desktop logs
- `git history` — from anything git
- `web profile` — from anything online
- `user input` — from the user's direct responses to our questions only

Read existing observations before appending. Only append what is new or changed.

### profile.md

```markdown
---
name: ""
background: ""
trainingAge: ""
stage: ""
orientation: ""
crossProject: false
createdAt: ""
lastUpdated: ""
lastRunDate: ""
urls:
  products: []
  github: []
  twitter: []
---

## Projects

[All projects. For each: name, one-line description, stack, stage
(prototyping / building / launched / revenue), traction, URL if any.
Updated each run from scan.]

## Workflow & tools

[Full AI stack: coding agents, IDE, MCP servers, Claude skills, AI services,
libraries, deploy targets, test frameworks, CI/CD.
How they work: spec-first, vibe code, parallel agents, etc.
Communication style (directive/exploratory, terse/verbose).
Updated each run from scan + user input.]

## Deep patterns

[Patterns spanning multiple domains, projects, or time.
Each with: evidence, domains involved, confidence, date.
Only include patterns that would change a recommendation.
Internal state — no filler, no compliments.]

## What drives them

[What they optimize for: shipping speed, craft, revenue, learning?
How they respond to feedback — what framing lands, what they act on vs ignore.
Inferred from sessions and updated as recommendations are acted on (or ignored).
Sparse on first run, richer over time.]

## Readiness

[Current focus, stuck point, what just happened (shipped? pivoted? hit a wall?).
Updated every run.]
```

### history.jsonl

```jsonc
{
  "date": "...",
  "domain": "...",
  "type": "...", // recommendation type: Correction, Reinforcement, Introduction, or Refinement
  "contentType": "...", // content format: article, podcast, video, paper, thread, etc.
  "source": "...",
  "title": "...",
  "url": "...",
  "summary": "...",
  "actedOn": null, // updated on subsequent scans: true if acted on, false if not
}
```
