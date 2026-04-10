---
name: grow
description: Your personal feedback loop. Finds the one thing worth reading right now.
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
DEVLOOP_DIR="$HOME/.devloop"
PROFILE="$DEVLOOP_DIR/profile.md"
mkdir -p "$DEVLOOP_DIR/observations"
[ -f "$PROFILE" ] && echo "PROFILE_EXISTS=true" || echo "PROFILE_EXISTS=false"
echo "DEVLOOP_DIR=$DEVLOOP_DIR"
if [ -f "$HOME/.devloop/scripts/check-grow-ready.sh" ]; then
  bash "$HOME/.devloop/scripts/check-grow-ready.sh" --context 2>/dev/null
else
  echo "GROW_AVAILABLE=true"
fi
```

## Routing

If `PROFILE_EXISTS=false`, read [onboarding.md](onboarding.md) and follow its instructions.

If `PROFILE_EXISTS=true`:

- No arguments or empty `$ARGUMENTS`:
  - If `GROW_AVAILABLE=false`: respond with the value of `COOLDOWN_MSG` as plain text and stop. Do not read any other files.
  - Otherwise → read [run.md](run.md) and follow its instructions
- `$ARGUMENTS` = "me" → read [me.md](me.md) and follow its instructions
- `$ARGUMENTS` = "history" → read [history.md](history.md) and follow its instructions

---

## Find Content

ONLY use content from sources listed in [sources.md](references/sources.md). Run this entire section silently.

### Step 1: Target

Read profile.md, observations, and history.jsonl. Identify 3-5 growth opportunities, ranked with reasoning. Don't search yet. For each:

- Which concept(s) it addresses
- **Impact**: A 0-1 concept or recurring cross-domain pattern from Deep Patterns? Does fixing this unlock progress in other domains? A tool that eliminates their current approach? Generally: product direction > tools/workflow > approach > skill gaps, but not rigid. Mindset-level feedback is the most personal and requires established trust.
- **Readiness**: Is the user bumping into this right now, or is it important in the abstract? A user mid-build may need building advice. A user who just shipped may need distribution advice.
- **Pacing**: Repeat topics from history.jsonl only if strategic. Think twice before pushing topics where past recommendations were ignored.

### Step 2: Explore

Two parallel Sonnet subagents. They explore wide and return a menu of candidates, not a committed topic:

**Opportunity explorer.** Given all ranked opportunities from Step 1, find 2-3 high-quality, up-to-date pieces from sources.md for each opportunity. Prefer canonical/definitive content. Return candidates with: source, author, URL, one-line summary, which opportunity it serves.

**Recency explorer.** Search last 7-14 days across sources.md for the most important recent content in the AI builder space. Not constrained to the opportunity list. Give it the user's profile for relevance, but let it find what's new and significant independently. Return candidates with: source, author, URL, one-line summary, why it matters.

### Step 3: Select

Evaluate candidates from both explorers against the growth opportunities without bias. Be open to recency findings that challenge assumptions, introduce new ways of thinking, or significantly change productivity. Pick ONE topic by weighing impact and content quality.

### Step 4: Enrich (only if needed)

If the selected topic already has 2-3 strong voices, skip. If it needs depth, dispatch a Sonnet subagent to find 1-2 complementary perspectives on the locked topic.

---

## Deliver

Read [visual-identity.md](references/visual-identity.md) and format the output using the Recommendation template. One cohesive output, 400-700 words, on the single topic from Find Content.

**Voice:**

Write like a friend telling you about something they read that changed how they think. Curious, not lecturing. Stories, not summaries. Reference their actual projects, decisions, and words.

Feedforward, not correction. Low confidence: lead with what's working, then the gap. High confidence: lead with the gap directly.

**Structure:**

1. Open with something specific from their work or sessions. If they've encountered the framework before, frame as application, not introduction.
2. Let one source dominate as the main story. Others support and deepen it, not compete for equal airtime. Sources should feel like characters, not footnotes.
3. When introducing a source, include social proof that makes a stranger trust it (who publishes it, who reads it, what makes this person worth listening to). Ground claims in numbers when available.
4. Close with a concrete playbook that flows as narrative, not a numbered checklist. Specific enough to execute in the next hour. End on the smallest possible first action. Human action: close with it directly. LLM action: offer it.

**Avoid:**

No em dashes. No throat-clearing, generic optimism, or unsupported claims. Banned words: delve, crucial, robust, comprehensive, nuanced, multifaceted, furthermore, moreover, additionally, pivotal, landscape, tapestry, underscore, foster, showcase, intricate, vibrant, fundamental, significant, interplay.

---

## Save

After every run, silently update state.

```
~/.devloop/
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

- YYYY-MM-DD | signal | concept | observation text | source category
```

The date is when the evidence happened, not when the scan ran. Signal is one of: `strong positive`, `weak positive`, `strong negative`, `weak negative`. Concepts are defined in domain files under [domains/](references/domains/). Use the exact concept names. Examples: `context engineering`, `web presence & SEO`.

Source categories:

- `codebase` — from anything in the codebase
- `CLI session` — from Claude Code logs
- `desktop session` — from Claude Desktop logs
- `git history` — from anything git
- `web profile` — from anything online
- `user input` — from the user's direct responses to our questions only

### profile.md

```markdown
---
name: ""
background: ""
trainingAge: ""
stage: "" # builder journey, one sentence (e.g. "launched first product but stuck on distribution")
crossProject: false
createdAt: ""
lastRun: ""
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

## Competency snapshot

[Stored verbatim from the most recent onboarding/run output so we can display it
directly. Updated after each scan if there are new observations.]
```

### history.jsonl

```jsonc
{
  "date": "...",
  "domain": "...",
  "type": "...", // recommendation type: correction, reinforcement, introduction, or refinement
  "contentType": "...", // content format: article, podcast, video, paper, thread, etc.
  "source": "...",
  "title": "...",
  "url": "...",
  "summary": "...",
  "actedOn": null, // updated on subsequent scans: true if acted on, false if not
}
```
