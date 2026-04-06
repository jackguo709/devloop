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

## AI Attribution

Most code in AI-assisted projects is AI-generated. The assessment must distinguish **human decisions** from **AI-generated implementation**.

**Credit as human signal (high weight):**

- Architecture and tool choices captured in session logs ("let's use X", "move these files to Y")
- Rejections and corrections ("don't use inline imports", "I see you use 'as any' a lot")
- Design documents, specs, README-as-spec written before implementation
- What they chose to build and why (product direction, feature prioritization)
- How they direct and evaluate AI output (prompting patterns, comprehension checks)
- Persist/pivot/kill decisions on features and projects

**Credit as deliberate choice, not implementation skill (medium weight):**

- Presence of validation, testing, or security patterns — credit the _decision_ to include them, not the code itself
- Architecture patterns — credit the structural choice, not the file organization details
- Tool/library selection — credit evaluating and choosing, not the integration code

**Do not credit (low weight):**

- Implementation details that are common AI defaults (boilerplate, standard patterns)
- Code quality metrics (line count, type coverage) that reflect AI capability, not human skill
- Patterns that appear without evidence of intentional choice in session logs

**Where to find human signal:** Session conversation logs are ground truth for intent. Git commit messages, design docs, and PR descriptions capture decisions. The gap between what was asked for and what was produced reveals comprehension.

---

## Find Content

Dispatch 2-3 parallel Sonnet subagents to search for content. Each agent gets a targeted search brief from the targeting step, not a broad category. Refer to [sources.md](sources.md) for the full source catalog, but assign each agent specific sources based on what's most likely to yield results for this topic.

Requirements:

- Freshness: prefer last 7 days, last 30 days typical. Older canonical content can win if relevance is high.
- Quality: must have specifics, real experience, or production evidence. No listicles or fluff.
- Each agent returns at most 2 results: title, author, source, direct URL, one-paragraph summary, why it matters for THIS user, one surprising detail. Or nothing if no relevant content exists.
- Keep agents fast: give them a tight scope and stop searching after finding a strong match.

**Select 2-3 complementary pieces** that together create a richer picture than any single source. Look for: one that frames the problem, one that shows a solution or example, and optionally one that adds a surprising data point or counterargument. If only one strong piece exists, that's fine — don't pad with weak results.

If all agents return nothing, deliver a code-context-only observation using the strongest scan finding.

---

## Deliver

Write one cohesive output. Target 250-400 words. The README example is the quality bar.

**Output principles:**

1. Open with something specific from their code — earns attention
2. Weave 2-3 sources into one narrative (don't list them separately — synthesize into a bird's-eye view)
3. One surprising detail from a source you wouldn't get from the headline
4. Connect every sentence to their situation
5. Write like a sharp friend, use their name
6. Explain who each author is in one parenthetical
7. End with an **actionable artifact** — don't just recommend, produce something. If the recommendation involves content strategy, draft example copy/posts. If it involves code, offer to write the file. If it involves a workflow, sketch the steps with their specific project details filled in. Ask permission before executing large actions.

**Feedforward, not correction.** Frame as what to do next, not what went wrong. "This approach breaks down when X" not "you're bad at X."

---

## Save

After every run, silently update state.

```
~/.grow/
  observations/                    # append-only, one file per domain + behavior
    resilience.md
    product.md
    ai-steering.md
    building.md
    distribution.md
    security.md
    business.md
    behavior.md
  profile.md                       # metadata + derived patterns + readiness
  history.jsonl                    # one line per recommendation
```

### Observation format

```markdown
# [Domain Name]

- YYYY-MM-DD | concept | observation text | source category
```

Concepts are defined in domain progressions in [competency-map.md](competency-map.md). Use the exact words. Examples: `basic SEO`, `user research`, `context engineering`, `content strategy`, `persist vs. quit judgment`, `threat modeling`.

`behavior.md` uses the same format with these concepts: `prompting style`, `work cadence`, `when-stuck`, `comprehension`, `confidence`, `focus`, `energy`. Pattern inferences ("abandons at distribution stage") go in profile.md, not here.

Source categories: `codebase`, `CLI session`, `desktop session`, `git history`, `web profile`, `user input`

Read existing observations before appending. Only append what is new or changed.

### profile.md

```markdown
---
name: ""
background: "" # engineer, PM, designer, solo founder, etc.
trainingAge: "" # how long they've used AI coding tools
stage: "" # "prototyping", "launched but no users yet", "two projects: one live, one early", etc.
orientation: "" # what they're focused on right now
crossProject: false # true if user opted in to cross-project scanning
createdAt: ""
lastUpdated: ""
lastRunDate: ""
urls:
  products: []
  github: []
  twitter: []
---

## Deep patterns

[Patterns spanning multiple domains, projects, or time.
Each with: evidence, domains involved, confidence, date first observed.]

## How they operate

[Prompting style, AI output handling, spec-to-code ratio,
work patterns, when-stuck behavior, comprehension signals]

## Readiness

[Current focus, stuck point, receptivity level — updated every run]

## Deferred dimensions

[Learning velocity, coachability, action rate — accumulate over runs]
```

### history.jsonl

```jsonc
{
  "date": "...",
  "domain": "...",
  "type": "...",          // recommendation type: Correction, Reinforcement, Introduction, or Refinement
  "contentType": "...",   // content format: article, podcast, video, paper, thread, etc.
  "source": "...",
  "title": "...",
  "url": "...",
  "summary": "...",
  "actedOn": null,        // updated on subsequent scans: true if behavior changed, false if not
}
```
