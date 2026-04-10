# Onboarding

First-run only. Builds the user's profile and ends with a first recommendation. Follow these steps precisely.

## Desktop session paths

- macOS: `~/Library/Application Support/Claude/claude-code-sessions/`
- Windows: `~/AppData/Roaming/Claude/claude-code-sessions/`
- Linux: no Claude Desktop support

Check `local-agent-mode-sessions/` too (legacy name). Sessions are in `<accountId>/<orgId>/` subdirectories. Each has `local_{id}.json` metadata and `audit.jsonl` conversation log.

## Step 1: Setup

Collect via AskUserQuestion (minimum 2 options per question):

- "What's your name?"
- Background: engineer, PM, designer, solo founder, or something else?
- "How long have you been using AI coding tools like Claude Code, Codex, Cursor, or Copilot?"
- "I can look at your work across all projects on this machine for broader, more insightful patterns. Everything stays local. Enable cross-project scanning?" Recommend enabling.
- "Share any product URLs, GitHub profiles, or Twitter/X handles if you want deeper product taste and distribution analysis. Otherwise skip." Recommend sharing.

Run `bash scripts/detect-stack.sh` to auto-detect the stack. This covers OS, languages, package managers, AI tools, IDEs, Claude config, MCP servers, projects, infra, and databases in one pass.

## Step 2: Scan permissions

Subagents need permissions to read session logs and write observations. Merge the following entries into `.claude/settings.local.json`. Ask the user to confirm before writing.

**Permissions to add:**

```
Read(path:~/.devloop/**)
Write(path:~/.devloop/**)
Edit(path:~/.devloop/**)
Read(path:~/.claude/**)
Bash(path:~/.claude/**)
Glob(path:~/.claude/**)
Grep(path:~/.claude/**)
```

Plus `Read`, `Bash`, `Glob`, `Grep` for the Desktop sessions path (OS-dependent, from the paths listed at the top of this file).

Do NOT add WebFetch permissions here. Those are handled after the scan and calibration are complete.

## Step 3: Scan

Dispatch one Sonnet subagent per domain to find evidence of competence AND gaps for each concept. Give each its domain file path from [domains/](references/domains/). We only scan past evidence once; missed observations are gone forever, so tell each subagent to be thorough and check every source. A desktop session can reveal product taste, a CLI session can reveal business thinking.

**Interpretation rules:**

Assume all code is AI-generated. Credit what the human did and thought, not the implementation. Conversation and user input are ground truth; code artifacts alone are weak signal.

Check authorship before crediting work. Third-party tools the user configured are evidence of Tool & Service Evaluation, not of building the tool. AI-generated artifacts and specs are evidence of Directing AI, not of the output's domain.

**Scan inputs:**

- **CLI sessions:** `~/.claude/projects/` — session JSONL files. Each subdirectory is a project (path with `/` replaced by `-`). If cross-project scanning is disabled, scan only the current project.
- **Desktop sessions:** OS-specific path defined above.
- **Project codebases:** Discover paths from CLI session directory slugs. For each project that still exists on disk, scan git history, config files, and code.
- **Web profiles (only if URLs provided):** product URLs, GitHub and Twitter/X profiles.

**Recording observations:**

Each subagent writes directly to its domain's observation file using the format in SKILL.md. Every observation must be grounded in concrete evidence. No fabrication or hypotheticals. ONLY return a one-line confirmation to the main agent. Do not return observation content.

**Signal labels:**

- **Positive**: evidence the user does something well.
- **Negative**: evidence of a gap, absence, or inconsistency.
- **Strong**: clearly and substantially demonstrates the signal. Consistent pattern, multiple instances, or a single instance with major impact.
- **Weak**: incidental, low-impact, or limited to a minor or rarely-used part of their work. Single instance that could be explained away.

## Step 4: Quality filter

Dispatch parallel Haiku subagents to review the observation files. Each reads its file, scores observations 1-100 on informativeness (does this tell us something useful about the user's actual level, or is it noise?), removes observations scoring below 80, merges true duplicates, and writes the filtered file back. Don't filter based on the strong/weak label itself. Return only a one-line confirmation.

## Step 5: Present and calibrate

Read all observation files. The goal is to show the user you understand their situation, surface something they might not have articulated, and give them a chance to correct you.

**1. Lead with the most striking pattern.** Surface a tension, contradiction, or cross-domain insight from the scan. Not a list of what they've done, but what it means.

**2. Show the competency map.** Rate each concept as an integer 0-5 as defined in [domains/](references/domains/). A concept rated N must meet all requirements from levels below N. If a Level 2 requirement is missing, the concept cannot score above 1 regardless of how impressive the Level 3+ evidence is. Rate "Need more data" if there's insufficient observations to rate confidently. Do not guess. Domain score (one decimal place) = average across concepts. "Need more data" counts as 0 in the average.

Read [visual-identity.md](references/visual-identity.md) and format the entire output using the Competency Map template. Be direct.

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

## Step 7: Session notifications

"Want a heads-up when your next /grow is ready? I'll add a small startup check so you see a reminder when it's time, instead of having to remember." Recommend enabling.

If enabled:

1. Create `~/.devloop/scripts/` directory if it doesn't exist.
2. Copy `scripts/check-grow-ready.sh` to `~/.devloop/scripts/check-grow-ready.sh`. Make it executable with `chmod +x`.
3. Read `~/.claude/settings.json`. Merge the following entry into `hooks.SessionStart` (create the key path if it doesn't exist). Preserve all existing settings and hooks:

    ```json
    {
      "matcher": "startup",
      "hooks": [
        {
          "type": "command",
          "command": "bash ~/.devloop/scripts/check-grow-ready.sh",
          "timeout": 5
        }
      ]
    }
    ```

If declined, skip. The cooldown still works (enforced in SKILL.md), the user just won't get the session reminder.

## Step 8: First recommendation

Run **Find Content**, **Deliver**, and **Save** from SKILL.md.

Set `lastRun` in profile.md frontmatter to the current ISO 8601 datetime.
Set `runCount` in profile.md frontmatter to `1`.

## Edge cases

- **Empty project:** CLI and Desktop sessions still provide context. If no sessions exist either, step 5 questions become the primary input.
- **User quits mid-onboarding:** Save partial state after each step. Resume on next /grow run.
