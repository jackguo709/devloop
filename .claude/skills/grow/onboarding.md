# Onboarding

First-run only. Builds the user's profile and ends with a first recommendation.

## Step 1: Setup

Use AskUserQuestion to collect. Note: AskUserQuestion requires a minimum of 2 options per question.

- "What's your name?"
- Background: engineer, PM, designer, solo founder, or something else?
- "How long have you been using AI coding tools like Claude Code, Codex, Cursor, or Copilot?"
- "I can look at your work across all projects on this machine for broader patterns. Everything stays local. Enable cross-project scanning?"
- "Share any product URLs, GitHub profiles, or Twitter/X handles if you want deeper analysis. Otherwise skip."

## Step 2: Scan

Dispatch parallel Sonnet subagents. Each agent reads [competency-map.md](competency-map.md) for domains and concepts, SKILL.md for the AI Attribution section and behavior concepts. Scan deeply and thoroughly. Log ALL observations for ANY concept or domain that can be gleaned from the source. Do not assign levels.

Every observation must be grounded in something concrete from the source. No fabrication, no hypotheticals, no inferences from absence. Only log high-confidence observations — if the evidence is too thin to be meaningful, skip it.

**AI attribution matters.** Most code is AI-generated. When logging observations, distinguish human decisions (captured in session conversations, design docs, git commit messages) from AI-generated implementation. Flag which observations come from session-level intent vs. code-level patterns. See the AI Attribution section in SKILL.md.

Save observations as detailed in SKILL.md.

**Sources:**

- **CLI sessions:** `~/.claude/projects/` — session JSONL files. Each subdirectory is a project (path with `/` replaced by `-`). If cross-project scanning is disabled, scan only the current project.

- **Desktop sessions:** `~/Library/Application Support/Claude/local-agent-mode-sessions/` (macOS), `$APPDATA/Claude/local-agent-mode-sessions/` (Windows), `~/.config/claude/local-agent-mode-sessions/` (Linux). Each session has `local_{id}.json` metadata and `audit.jsonl` conversation log. Skip silently if path doesn't exist.

- **Project codebases:** Discover paths from CLI session directory slugs. For each project that still exists on disk, scan git history, config files, and code.

- **Web profiles (only if URLs provided):** WebFetch product URLs, WebSearch GitHub and Twitter/X profiles.

Wait for all agents to return.

## Step 3: Present and calibrate

Read all observation files. Identify gaps: which domains lack signal, which profile fields (patterns, behavior, readiness) are incomplete.

**1. Show the most striking finding.** Use their name. Lead with the highest-value or most surprising observation from the scan. 1-2 sentences. This is the hook.

**2. Ask 0-3 adaptive questions** based on what's missing across domains, behavior, and profile. Choose at runtime. If all fields have sufficient signal, skip to the map.

**3. Write answers** to the relevant observation files and profile.md.

**4. Show the competency map** with levels derived from all observations (scan + answers) using [competency-map.md](competency-map.md):

```
Your competency map:

Resilience:           3 — evidence-based pivoting, sustainable pace
AI Steering:          3 — context engineering, spec-driven development
Building:             2 — ships working apps, basic patterns
Security:             2 — env vars, basic auth, no validation yet
Product & Design:     [Need more data]
Distribution:         [Need more data]
Business:             [Need more data]
```

Each level must cite specific evidence. Never assign a level without justification.

**5. Ask: "Does this feel right? What am I missing?"**

**6. Update** observation files and profile.md from their response.

**7. Synthesize deep patterns** from all observations: cross-domain, cross-project, or longitudinal patterns. Write to profile.md.

## Step 3.5: Permissions setup

Before searching content, ensure the project has the required web permissions.

1. Read [permissions.json](permissions.json) to get the list of required permissions.
2. Read the project's `.claude/settings.local.json` (if it doesn't exist, start with `{"permissions":{"allow":[]}}`)
3. Compare: find entries in the template that are not already in the project's allow list.
4. If there are missing entries, show the user: "To search 50+ content sources for your recommendations, I need to add web access permissions to this project's settings. This lets me fetch from sites like simonwillison.net, latent.space, paulgraham.com, and others. OK to proceed?"
5. On approval, merge the missing entries into the project's allow list (preserve all existing entries) and write the updated `.claude/settings.local.json`.
6. If the user declines, proceed without — content search will prompt per-domain instead.

## Step 4: First recommendation

Target the single highest-impact gap from the observations. Priority:

1. User's stated focus or challenge (if shared in step 3)
2. Most striking negative observation
3. Highest-impact gap given their stage

Run **Find Content** from SKILL.md with this target. Then run **Deliver** from SKILL.md.

If all content search fails, deliver a code-context-only observation using the strongest scan finding.

Append the recommendation to `~/.grow/history.jsonl`.

## Edge cases

**Empty project:** CLI and Desktop sessions still provide context. If no sessions exist either, step 3 questions become the primary input.

**User skips all questions:** Proceed with scan-only data.

**User quits mid-onboarding:** Save partial state after each step. On next /grow run, detect incomplete profile and resume.
