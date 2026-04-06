# Design: Grow

## Onboarding

One-time. Builds the profile that all future runs operate on. Ends with the first recommendation, not just a saved profile.

**1. Quick setup.** Name, background (engineer? PM? designer? solo founder?), how long they've been using AI coding tools (training age). Optional: product URL, GitHub profile, Twitter/X handle.

**2. Full scan.** Silent, one pass across all seven domains. Tailored by background.

Sources:

- Code, git history, dependencies, configs, project files
- Claude Code session logs + Claude Desktop conversation history
- Product URL, GitHub profile, social profiles if provided

| Scannability | Domains                                       | With optional inputs                       |
| ------------ | --------------------------------------------- | ------------------------------------------ |
| High         | Building, Security, AI Steering               | —                                          |
| Medium       | Product & Design, Distribution & Growth       | High with product URL + social profile     |
| Low          | Business & Operations, Resilience & Direction | Medium with product URL (pricing, support) |

**3. Show observations.** Tailored to their background. "As a designer with 6 months of AI tool experience, here's what I see..." Trust moment — proves competence before asking anything reflective.

Show specific observations per domain, NOT tier labels. High-scannability domains (Building, Security, AI Steering) get concrete findings: "47 commits, zero tests. No CI config." or "Input validation on all user-facing endpoints. Rate limiting in place." Low-scannability domains say "Need more context" rather than guessing.

Include ONE "biggest blind spot" callout: the thing the scan found that the user probably doesn't know about themselves. A blind spot is a domain where the scan found concrete negative signals in code the developer actively wrote and recently committed, indicating they thought it was fine. Example: "You have strong architecture patterns but your error handlers are completely untested. That's the gap most likely to bite you." If the scan can't distinguish blind spots from simple gaps on first run, downgrade to "one surprising finding."

Offer cross-project opt-in HERE, after the scan has proven its value: "I can also look at your work in other projects for broader patterns. Everything stays local. Enable cross-project scanning?"

One sentence about deferred dimensions: "Over time, I'll also learn your learning patterns, blind spots, and growth trajectory."

**4. Reflective questions.** 2-3 max. These land better after the scan because the user has something concrete to react to.

- "Where are you with this... still building, or do people use it?" (stage)
- "What's the thing you're trying to figure out right now?" (readiness + current focus)
- "Does this match how you see it? What am I missing?" (self-perception calibration)

Orientation (shipping vs. exploring) inferred from the answer to question 2. Disagreement with observations captured through question 3, no explicit correction mechanism needed. The gap between what the scan shows and what they say IS the self-efficacy signal.

All questions must be **generative**: they force the user to construct an answer, not evaluate themselves. "How much of the diff did you actually read?" is generative. "Did you review the PR carefully?" is evaluative and gets a defensive "yes." Generative questions double learning gains (Chi et al.).

**5. Show competency map.** Full map across all seven domains (1-5 scale), now informed by scan + reflective answers. Each level justified with specific evidence: "Building: 3 — clean architecture, testing discipline, deliberate data modeling" not just "Building: 3." For domains where reflective answers shifted the assessment from the scan-only estimate, note the shift. Apply AI attribution: credit human decisions over AI-generated implementation patterns.

"Does this feel right?" — disagreement flows through natural conversation. No explicit correction UI.

| Dimension            | Source                                  | Drives                                          |
| -------------------- | --------------------------------------- | ----------------------------------------------- |
| Technical depth      | Scan                                    | Tier placement: Building, Security              |
| AI workflow maturity | Scan + training age                     | Tier placement: AI Steering                     |
| Builder context      | Ask + scan                              | Tier placement: Product, Distribution, Business |
| Orientation          | Inferred from "what are you figuring out" | Delivery framing                              |
| Self-efficacy        | Inferred (scan observations vs. step 4 answers) | Whether to lead with strengths             |
| Readiness            | Ask (current stuck point)               | Feedback type                                   |

**6. First recommendation.** Deliver the first /grow output immediately. Skip to Target → Find → Deliver (steps 3-5 of the pipeline), reusing the scan data from step 2 and the user's answers from step 4. Do NOT re-scan or re-ask. The user walks away having experienced the product, not just configured it.

If the content search returns nothing from any of the 5 subagents (all sources empty or failed), deliver a code-context-only observation instead. Use the blind spot from step 3 or the strongest scan finding as the basis for a recommendation without external content. "I couldn't find recent content on this, but here's what I noticed in your code..." Never end onboarding without delivering something.

**7. Save.** Profile, history (first entry), context. Silent.

### Edge cases

**Empty project (no code, no git history):** Step 2 finds nothing to scan. Skip step 3 observations (nothing to show). Step 4 questions become the primary input. Step 5 places all domains conservatively at Functional with "not enough data to assess, will improve over runs." Step 6 delivers a general recommendation based on their background and stated focus from step 4. The first real assessment happens on the next /grow run when they have code.

**User quits mid-onboarding:** Save whatever profile data has been collected so far after each step completes. If they quit after step 4, save the partial profile. On next /grow invocation, detect the incomplete profile (missing tiers or missing history entry) and resume from where they left off, not from scratch.

**All content search fails:** Covered in step 6 above. Code-context-only fallback. Never crash, never show nothing.

### Deferred dimensions

Built over runs from observed behavior, not from asking. Users are told these exist during step 3 ("Over time, I'll also learn your learning patterns, blind spots, and growth trajectory").

- Learning velocity — how quickly they act on recommendations
- Coachability — how they respond to feedback
- Blind spots — where scan and self-perception consistently diverge
- Growth trajectories — per-domain improvement over time

### Research notes

From the AI builder landscape:

- The most actionable profiling axes are technical depth x AI workflow maturity x orientation (shipping vs. exploring)
- "Training age" with AI tools matters as much as overall technical experience
- The #1 failure mode is distribution, not building... "shipped but nobody uses it"
- AI generates vulnerabilities at 2x the human rate, security is not optional
- Self-assessment is unreliable (Kruger & Dunning), scan signals beat self-report

From pedagogy:

- Prior knowledge is the single most significant learner characteristic (CMU)
- 1/3 of feedback interventions DECREASE performance, mostly when targeting self/identity rather than task/process (Kluger & DeNisi)
- Feedforward beats correction, frame as what to do next, not what went wrong (Goldsmith)
- Generative reflection questions double learning gains (Chi et al.)
- One thing per session, cognitive load theory (Sweller)
- Let the system recommend, let the learner override, autonomy is a core motivator (Deci & Ryan SDT)
- Adults only learn when facing a real problem NOW (Knowles readiness)
- Self-efficacy moderates everything, low confidence + gap-focused feedback = harmful

### Relevance by background

| Background         | Deepest               | Often missing                          |
| ------------------ | --------------------- | -------------------------------------- |
| Engineer           | Building, AI Steering | Distribution, Business, Design taste   |
| Designer           | Product & Design      | Distribution, Security, Business       |
| PM / non-technical | Product, Business     | Security, Architecture depth           |
| Solo founder       | All                   | Blind spots in self-assessed strengths |

## Pipeline

Every run after onboarding. Six steps: Scan → Ask → Target → Find → Deliver → Write.

### Step 1: Scan

Silent. Read state, scan what's changed.

**Read:** profile.json, context.json, history.json.

**Scan sources:** code, git history (since last run), dependencies, configs, project files, Claude Code session logs, Claude Desktop conversation history, cross-project sessions if opted in, product URL / GitHub / social profiles from profile.

**Update tier placements** where new evidence warrants. Most domains won't change between runs. A domain can move up (tests appeared → Building: Functional to Effective) or down (secrets committed → Security drops).

**Check previous recommendations.** Did they act on past feedback? Behavior change is the strongest signal. No change after repeated recommendations in the same domain → stop pushing that domain.

**Identify candidate domains.** 1-3 domains where feedback would be most impactful. Don't finalize — the Ask may redirect.

### Step 2: Ask

One question, grounded in what the scan found. The scan tells you what they've been doing. The ask tells you what they care about.

The question must be **generative**: it forces the user to construct an answer, not evaluate themselves. "You've been working on auth all week but none of it merged. Are you stuck on something specific?" is generative. "Is your auth implementation going well?" is evaluative. Generative questions serve dual purpose: they gather context for better targeting AND create a reflection moment that makes the subsequent feedback stick (Chi et al. — doubles learning gains).

Examples:

> "You've been working on auth all week but none of it merged. Are you stuck on something specific, or still exploring the approach?"

> "I see you're hand-rolling retry logic in three places. Have you looked at libraries for this, or is there a reason you're doing it manually?"

> "What's the thing you're actually trying to figure out right now?"

The answer reveals two things: **focus** (what domain they care about) and **readiness** (how receptive they are).

| Readiness | Signal                           | Implications                                    |
| --------- | -------------------------------- | ----------------------------------------------- |
| Stuck     | Actively blocked                 | Highest receptivity. Lead with the solution.    |
| Exploring | Considering options, not blocked | Good for introductions. Lead with the question. |
| In flow   | Shipping, everything working     | Low receptivity. Reinforce or stay light.       |

### Step 3: Target

The core decision. Combine scan + answer + profile to finalize what to deliver.

**Pick the domain.** Priority order:

1. User's stated focus — if they said "I'm trying to figure out pricing," that's Business & Operations, regardless of scan
2. Highest-impact gap — where improvement has the most ROI given their stage and goals
3. Avoid repeats — don't push domains where you've recently delivered and they haven't acted
4. Respect trust — Resilience & Direction requires established trust from prior useful feedback

**Pick the type:**

| Type          | When                                              |
| ------------- | ------------------------------------------------- |
| Correction    | Something is wrong or risky                       |
| Reinforcement | Something is working — affirm with specifics      |
| Introduction  | Something new and relevant they haven't seen      |
| Refinement    | Something that already works but could be sharper |

**Pick the delivery framing** based on how they operate in the target domain:

| How they operate                          | Mode                                                      |
| ----------------------------------------- | --------------------------------------------------------- |
| Following rules, no context               | **Tell** — specific instructions, checklists              |
| Recognizes patterns, still rule-dependent | **Show** — contextual examples, name the pattern          |
| Makes independent decisions               | **Coach** — decision frameworks, prioritization           |
| Adapts fluidly, uses intuition            | **Refine** — edge cases, sharpen judgment                 |
| Unconscious mastery                       | **Reflect** — challenge assumptions, mirror patterns back |

**Generate the search brief.** Must be specific enough to produce targeted results. Include: target domain, user's tech stack, current focus from answer, what "good" looks like (a concrete technique, not a think-piece), and time window. Example: "Find a recent article about spec-driven development for someone who decomposes well but doesn't write specs, framed as a workflow refinement. Prefer posts with real examples and production experience. < 2 weeks old."

### Step 4: Find

Two things in parallel, dispatched in a single message:

**Focused scan:** Dig into the target area in their actual code. Read the files, trace the patterns, find the specific details that earn attention in delivery. This is what makes the output feel personal — not the content link, but the connection to _their_ code.

**Content search:** Dispatch 5 subagents, each searching assigned sources. Each agent receives: the search brief, user's tech stack, target domain + tier, time window.

- Agent 1: Blogs + essays (engineering blogs, Simon Willison, Julia Evans, Paul Graham, First Round Review)
- Agent 2: Newsletters + long-form (Pragmatic Engineer, Lenny, Stratechery, Mollick, Latent Space, AlphaSignal, Rundown AI, Import AI, The Batch)
- Agent 3: HN + Twitter/X + community (HN front page / Show HN / Ask HN 100+ points, curated Twitter accounts)
- Agent 4: Papers + research + YC (arXiv via HuggingFace Papers, Semantic Scholar, YC YouTube, Lightcone)
- Agent 5: Tools + releases + GitHub trending + media (changelogs for user's deps, Trendshift, Fireship, ThePrimeagen, Theo, podcasts)

Each agent returns a structured result: title, URL, author, date, 2-sentence summary, relevance score (1-5). At most 3 results per agent. Agents that fail or find nothing return empty — never crash.

**Content selection.** From all agent results, pick the single best piece. Rank by: relevance to search brief × freshness × non-obvious (would they find this themselves?) × actionable (can they do something different after reading this?). Freshness is a scoring boost, not a gate: content from the last 7 days gets the strongest boost, last 30 days moderate, and older content can still win if relevance is high enough. A canonical post from 3 months ago that's the definitive take on the user's exact gap beats a mediocre article from yesterday. The product's default bias is toward what's new, but never at the cost of serving the wrong content.

### Step 5: Deliver

One cohesive output. Before delivering, check:

| Check                                          | If it fails                              |
| ---------------------------------------------- | ---------------------------------------- |
| Connects to their stated focus?                | Pick different content                   |
| Self-efficacy — confident enough to hear this? | Lead with what's working first           |
| An offer, not an order?                        | Reframe as option or question            |
| Can they act on this today?                    | Make it more concrete                    |
| Right difficulty for where they are?           | Too hard → simplify. Too easy → level up |

**Framing adapts to delivery mode** (Tell/Show/Coach/Refine/Reflect) **and readiness:**

- Stuck → lead with the solution, follow with context
- Exploring → lead with the question, follow with options
- In flow → keep it light. "Nothing urgent. Here's one thing worth watching."

**Output principles:**

1. Open with something specific from their code — earns attention, proves competence
2. One surprising detail from the source you wouldn't get from the headline
3. "So what?" at every sentence — connect to their situation
4. Write like a sharp friend — conversational, opinionated, uses their name
5. Explain everything, assume nothing — who is this person, what is this publication
6. Action must be embarrassingly specific — offer to DO it, reference exact files
7. End with a generative reflection question — "How would you apply this?" not "What did you learn?" Specific enough they can't deflect.

**Feedforward, not correction.** Frame as what to do next, not what went wrong. Reference the specific code or behavior, never the person. "This approach breaks down when X" not "you're bad at X."

### Step 6: Write

- **profile.md** — update tier placements if new evidence warrants, update present/absent signals, refresh readiness and current focus, add new deep patterns if detected, update deferred dimensions (learning velocity, coachability)
- **history.jsonl** — append one line: domain, tier, type, delivery mode, content delivered, user focus, readiness state. Update `actedOn` field on previous entries if behavior change detected during scan.

## File Layout

### Skill

```
.claude/skills/grow/
├── SKILL.md                    # Entry point: routing, onboarding, edge cases
├── competency-map.md           # 7 domains x 5 levels, assessment criteria, AI attribution
```

Single `/grow` command with modes via arguments:
- `/grow` — daily recommendation (default)
- `/grow me` — show current profile, tiers, patterns (read-only, no new scan)
- `/grow history` — past recommendations

### User state (per-user, NOT per-project)

```
~/.grow/
  profile.md       # Markdown + YAML frontmatter. Everything Grow knows about the user.
  history.jsonl    # Append-only. One line per recommendation, with actedOn tracking.
```

Two files. `profile.md` is the canonical view: frontmatter for structured metadata (name, background, stage, URLs), body for per-domain assessments (tier, present/absent signals, self-efficacy, delivery mode), deep patterns, operating style, readiness, and deferred dimensions. Human-readable, LLM-friendly for partial updates.

`history.jsonl` is append-only. Never rewritten. Each entry tracks what was recommended and whether the user acted on it (checked on subsequent scans).

State is per-user because Grow recommends to the person, not about a codebase. The current project is context for this run's scan, but the profile belongs to the builder.
