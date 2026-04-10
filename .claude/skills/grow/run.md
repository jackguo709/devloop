# Default Run

The regular recommendation pipeline. Profile exists, scan for new evidence, deliver.

## Desktop session paths

- macOS: `~/Library/Application Support/Claude/claude-code-sessions/`
- Windows: `~/AppData/Roaming/Claude/claude-code-sessions/`
- Linux: no Claude Desktop support (skip desktop sessions)

Check `local-agent-mode-sessions/` too (legacy name). Sessions are in `<accountId>/<orgId>/` subdirectories. Each has `local_{id}.json` metadata and `audit.jsonl` conversation log.

## Step 1: Change Detection

Parse `lastRun` and `runCount` from `~/.devloop/profile.md` frontmatter.
If `lastRun` missing: treat as meaningful delta (bootstrap case).

Count new evidence since `lastRun`:

- **CLI sessions:** files in `~/.claude/projects/` with mtime after `lastRun`. If `crossProject: false` in profile.md, only scan the current project's directory.
- **Desktop sessions:** files in Desktop session path (above) with mtime after `lastRun`.
- **Git commits:** `git log --after=<lastRun> --format="%h %s" | head -200 | wc -l`. If not in a git repo, count = 0, no error.
- **New projects:** CLI session directory slugs not yet in profile.md Projects section.

**Threshold:** delta is MEANINGFUL if ANY of:

- 1+ session files with mtime after `lastRun`
- 3+ git commits since `lastRun`
- New project directories detected
- `lastRun` field is missing (bootstrap)

Otherwise delta is MINIMAL (skip to Step 4).

## Step 2: Delta Scan (skip if delta is minimal)

Pre-filter context for subagents:

- **Session paths:** find session files with mtime after `lastRun`.
- **Git log:** `git log --after=<lastRun> --format="%h %s" --stat | head -200`. Cap at 200 lines to bound token cost. If truncated, note how many additional commits were omitted.

Dispatch 7 parallel Sonnet subagents (one per domain). Give each:

- Its domain reference file path from `references/domains/`
- The `lastRun` date
- The list of new session file paths (subagent reads only these)
- The capped git log output
- Its observation file path for appending

Each subagent:

- Reads new sessions and git log for evidence in its domain
- Reads existing observations in its domain file to avoid duplicates
- **Dedup rule:** skip if same concept + signal direction + source category already exists for the same evidence (same session file or commit)
- Appends ONLY new observations using the format from SKILL.md
- Returns a one-line confirmation (do not return observation content)

**Interpretation rules** (same as onboarding):

- Assume all code is AI-generated. Credit human decisions, not implementation.
- Conversation and user input are ground truth; code alone is weak signal.
- Check authorship before crediting work.

## Step 3: Quality Filter (skip if <5 new observations OR delta was minimal)

Dispatch parallel Haiku subagents (one per domain that has new observations). Same logic as onboarding Step 4:

- Score each new observation 1-100 on informativeness
- Remove observations scoring below 80
- Merge true duplicates
- Write filtered file back
- Return one-line confirmation only

## Step 4: Quick Questions

**Q1** is CONDITIONAL (not every run):

- Ask Q1 if 3+ days since `lastRun` OR scan found evidence of a focus shift (e.g., new project detected, observations in a domain not previously active).
- Q1 text: "What are you focused on right now?" via AskUserQuestion with options:
  - Building something new
  - Shipping or launching
  - Stuck on a problem
  - Learning or exploring
  - Just maintaining
- If Q1 not asked, carry forward the previous readiness context.

**Q2** is CONDITIONAL:

- Ask Q2 if the most recent `history.jsonl` entry has `actedOn: null`.
- Q2 text: "Last time I recommended [title] about [domain]. Did you get a chance to check it out?" with options:
  - Yes, it was helpful
  - Yes, but it wasn't relevant
  - No, haven't gotten to it
- Update `actedOn` field based on response: "Yes, helpful" → `true`, "Yes, not relevant" → `true`, "No" → leave `null`.
- If no `null` actedOn entries, skip Q2.

If neither Q1 nor Q2 triggers, skip questions entirely and proceed to Step 5.

## Step 5: Profile Update (consolidated write)

All profile.md writes happen here in one pass:

1. **Readiness section:** update from Q1 answer (if asked) + scan findings (if scan ran). If Q1 was not asked, keep existing readiness and layer in scan findings only.
2. **Competency snapshot:** recalculate ONLY if scan ran and new observations change any concept rating by 0.5+ (use same 0-5 rubric from `references/domains/`).
3. **Projects section:** add new projects if scan detected them.
4. **runCount:** increment by 1.
5. **lastRun:** set to current ISO 8601 datetime (e.g., `2026-04-09T14:30:00`).

## Handoff

Run **Find Content**, **Deliver**, and **Save** from SKILL.md.

Note: observations and profile have already been updated by this pipeline. Save only needs to append the new recommendation to `~/.devloop/history.jsonl`.
