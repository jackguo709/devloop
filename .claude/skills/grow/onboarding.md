# Onboarding

First-run only. Builds the user's profile and ends with a first recommendation. Follow the following steps precisely.

## Desktop session paths

- macOS: `~/Library/Application Support/Claude/local-agent-mode-sessions/`
- Windows: `%APPDATA%/Claude/local-agent-mode-sessions/`
- Linux: `~/.config/claude/local-agent-mode-sessions/`

Each session has `local_{id}.json` metadata and `audit.jsonl` conversation log.

## Step 1: Setup

Collect via AskUserQuestion (minimum 2 options per question):

- "What's your name?"
- Background: engineer, PM, designer, solo founder, or something else?
- "How long have you been using AI coding tools like Claude Code, Codex, Cursor, or Copilot?"
- "I can look at your work across all projects on this machine for broader patterns. Everything stays local. Enable cross-project scanning?"
- "Share any product URLs, GitHub profiles, or Twitter/X handles if you want deeper analysis. Otherwise skip."

Auto-detect the user's full AI and engineering stack, tools, workflow, and dev environment from the filesystem. Then ask follow-up questions to cover gaps — new tools and services emerge almost daily, so auto-detection will miss things.

## Step 2: Scan permissions

Subagents need access to session logs and observation files. Detect the OS and ask to merge these permissions into `.claude/settings.local.json`:

```
Read(path:~/.grow/**)
Write(path:~/.grow/**)
Read(path:~/.claude/**)
Bash(path:~/.claude/**)
Glob(path:~/.claude/**)
Grep(path:~/.claude/**)
```

Plus `Read`, `Bash`, `Glob`, `Grep` for the Desktop sessions path.

## Step 3: Scan

Dispatch one Sonnet subagent per domain. Give each subagent:

- The relevant domain section from [competency-map.md](references/competency-map.md)
- ALL scan inputs listed below. Do not predict which source has signal for which domain. A desktop or CLI session might contain rich human intent across any domain.

Each subagent saves observations directly to its domain's observation file using the format in SKILL.md. Every observation must be grounded in concrete evidence. No fabrication or hypotheticals. Skip observations where the evidence is too thin to be meaningful.

Assume all code is AI-generated. Credit what the human did, not the implementation. Conversation and user input are ground truth; code artifacts alone are weak signal.

**Scan inputs**:

- **CLI sessions:** `~/.claude/projects/` — session JSONL files. Each subdirectory is a project (path with `/` replaced by `-`). If cross-project scanning is disabled, scan only the current project. These are high-signal for human intent.

- **Desktop sessions:** OS-specific path defined above. High-signal for human intent.

- **Project codebases:** Discover paths from CLI session directory slugs. For each project that still exists on disk, scan git history, config files, and code.

- **Web profiles (only if URLs provided):** product URLs, GitHub and Twitter/X profiles.

## Step 4: Quality filter

Dispatch parallel Haiku subagents to review the observation files. For each observation, score it 1-100 on signal strength: does this reveal genuine competence or a genuine gap, or is it just "did a reasonable thing"? Remove observations scoring below 80. Merge duplicates that describe the same evidence.

## Step 5: Present and calibrate

Read all observation files. The goal is to show the user you understand their situation, surface something they might not have articulated, and give them a chance to correct you.

**1. Lead with the most striking pattern.** Surface a tension, contradiction, or cross-domain insight from the scan. Not a list of what they've done, but what it means.

- GOOD: "Alex, you spec everything before touching code, and the specs are good. But you've specced 4 projects in 6 months without shipping any to users. The spec is becoming the product instead of the product."
- BAD: "8 projects in 9 months, all convergent. Pivots deliberately based on real learning."

**2. Show the competency map.** For each domain: rate using Level Definitions in [competency-map.md](references/competency-map.md), and add a detailed summary of the level ratings: what's working and what's missing, and what the next level looks like. Be direct.

```
Your competency map:

Resilience:       1.8 — Direction (2): deliberate pivots, coherent thesis.
                        Pace (2): ships fast but 47 parallel workstreams
                        on a product you killed 2 days later.
                        Persist vs Quit (2): clean kills, but no evidence
                        of surviving a long traction drought.
                        Builder Identity (1): tied to current project,
                        no public identity beyond it.

Product Taste:    1.4 — User Empathy (0): no evidence of talking to users.
                        Value Clarity (2): precise problem framing.
                        Design Judgment (2): intentional design system.
                        Feature Discipline (2): deliberate cuts.
                        PMF Judgment (1): builds before validating demand.

...
```

**3. Ask 0-3 questions** to fill gaps in domains or profile. Skip if signal is sufficient.

**4. "Does this feel right? Am I missing anything?"**

**5.** Update observations from their response if needed. Populate profile.md as defined in SKILL.md, informed by scan observations, user answers, and how they responded to the map.

## Step 6: Content permissions and tools

**Web permissions.** Read [permissions.json](references/permissions.json) and compare against the project's `.claude/settings.local.json`. If missing, ask to add them. If declined, proceed without.

**Optional MCP servers.** Check if these are already installed. For any that aren't, offer to install them to access richer content:

- `arxiv-mcp-server` — search and read research papers
  `claude mcp add -s user arxiv -- uvx arxiv-mcp-server`
- `youtube-transcript` — get video transcripts
  `claude mcp add -s user youtube-transcript -- npx -y @kimtaeyoon83/mcp-server-youtube-transcript`

## Step 7: First recommendation

Run **Find Content**, **Deliver**, and **Save** from SKILL.md.

## Edge cases

- **Empty project:** CLI and Desktop sessions still provide context. If no sessions exist either, step 5 questions become the primary input.
- **User skips all questions:** Proceed with scan-only data.
- **User quits mid-onboarding:** Save partial state after each step. Resume on next /grow run.
