# Agent Fluency

Thinking and working natively with AI agents. The cognitive and systems skills for effective human-agent collaboration, from basic delegation to orchestrating multi-agent systems.

## Task Delegation

Decomposing work into agent-sized chunks with clear goals, context, and success criteria. The core bottleneck: agents can execute almost anything you can specify — the skill is in the specification.

- **Level 0:** Asks agents open-ended questions without structure. No decomposition. Accepts whatever comes back.
- **Level 1:** Gives agents tasks but success criteria are vague or absent. Doesn't split large work into smaller pieces. No distinction between what to fully delegate, collaborate on, or keep.
- **Level 2:** Breaks work into tasks with machine-verifiable completion criteria (tests pass, linter clean, checklist items complete). Provides minimum viable context — enough to constrain the agent, not so much that it drowns. Each task is self-contained enough that an agent can complete it without implicit knowledge from other tasks.
- **Level 3:** Designs task graphs with dependencies, parallelism, and checkpoints. Uses spec-driven patterns (requirements → plan → tasks) for multi-step work with persistent progress files that survive context resets. Each task includes constraints, output format, and explicit done-state. Feedback from completed tasks refines subsequent ones.
- **Level 4:** Creates reusable task specification patterns others adopt. Delegation quality is consistent across projects and team members, not dependent on individual skill.
- **Level 5:** Builds systems that automate task decomposition — novel work broken into agent-ready chunks programmatically. Published frameworks that advance delegation practice.

## Orchestration Patterns

Choosing the right coordination model and managing parallel workstreams. The canonical patterns: prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer, autonomous agents. Includes the judgment to start simple and add complexity only when needed.

- **Level 0:** Single chat window. One model, one turn at a time. No awareness that different tasks benefit from different coordination.
- **Level 1:** Uses one agent at a time, sequentially. Might copy output between sessions manually. No deliberate isolation, coordination protocol, or pattern selection.
- **Level 2:** Chooses between sequential and parallel execution based on task shape. Uses worktrees or separate sessions for isolation. Runs subagents for focused work without polluting main context. Uses fresh-context review (a different session reviews what the first one wrote). Knows when NOT to parallelize.
- **Level 3:** Deploys agent teams (3–5) with role assignment, shared task lists, and quality gates between stages. Selects patterns deliberately — prompt chaining for fixed steps, orchestrator-workers when subtasks emerge dynamically, evaluator-optimizer when iteration measurably improves output. Encodes escalation rules so agents stop and ask rather than proceeding on assumptions.
- **Level 4:** Fluent across coordination tiers: in-process tool use, local multi-agent orchestration, and cloud-async managed agents. Builds custom agent workflows programmatically with agent SDKs. Creates reusable orchestration configurations others adopt.
- **Level 5:** Builds or extends orchestration infrastructure. Runs 10+ concurrent agents productively with principled coordination and self-improving loops. Published patterns that advance the field.

## Agent Infrastructure

Building the persistent environment that makes agents effective across sessions. The stack: project context files → rules → hooks → skills → MCP servers → memory systems. Each layer adds deterministic control that prompts alone cannot provide.

- **Level 0:** Uses AI tools with default settings. No project-specific configuration. No awareness that configuration matters.
- **Level 1:** Has a project context file (CLAUDE.md, AGENTS.md, or equivalent) but it's auto-generated, copy-pasted, or bloated. Might have one MCP server installed from a tutorial. No hooks, skills, or memory configured deliberately.
- **Level 2:** Maintains a focused project context file (concise enough that the agent actually follows it). Has hooks for formatting or linting after edits. Uses MCP servers that serve actual workflow needs. Configuration is lean — each line earns its place.
- **Level 3:** Configuration is layered (global → project → directory → topic-specific rule files). Hooks enforce quality gates deterministically at lifecycle events. Custom skills encapsulate repeated workflows as reusable commands. Multiple MCP servers extend agent capabilities to external systems. Memory persists decisions and context across sessions.
- **Level 4:** Builds custom infrastructure — skills, MCP servers, plugins — that others install and use. Environment design is deliberate, documented, and versioned. Contributes to ecosystem tooling.
- **Level 5:** Creates infrastructure patterns that change how the community thinks about agent environments. Contributes to open standards (MCP protocol, agent configuration formats, skills specifications). Work shapes the field.

## Harness Engineering

Building the scaffolding around agent execution — tool design, loop architecture, session management, and verification integration. The discipline that makes long-running autonomous agent work reliable. The model is not the bottleneck; the harness is.

- **Level 0:** Uses agents through default chat interfaces. No awareness that tool design, execution structure, or session management affect agent outcomes.
- **Level 1:** Aware that agents run in loops and use tools, but treats both as black boxes. Uses default tool sets without modification. No session management beyond starting new conversations. Doesn't think about what happens when context fills up or how agents recover from failures.
- **Level 2:** Understands the agent loop (gather context → act → verify → repeat) and structures work to fit it. Writes tool descriptions that agents follow reliably. Embeds verification in the loop — agents test their own output, not just humans after the fact. Manages what information survives context compaction: critical state lives in files, not just conversation history.
- **Level 3:** Builds custom tools (MCP servers, CLI commands) applying ACI principles: poka-yoke constraints that eliminate error classes, token-efficient responses, meaningful error messages over opaque codes. Designs multi-session workflows with initialization rituals, structured progress tracking (JSON over Markdown for agent-written state), and checkpointing. Integrates browser automation or test runners so agents verify their own work end-to-end.
- **Level 4:** Builds agent harness infrastructure others adopt. Designs programmatic agent workflows using SDKs for CI/CD, headless execution, or production automation. Custom tool sets that measurably outperform defaults.
- **Level 5:** Advances the field's understanding of agent scaffolding and tool design. Contributes to ACI research, harness patterns, or tool interface standards. Published work that shapes how others build agent execution environments.

## Intervention Judgment

Knowing when to let agents run, when to redirect, and when to take over entirely. Calibrated by experience and observable signals, not anxiety or blind trust.

- **Level 0:** Either micromanages every output or fully trusts agents with no oversight. No middle ground.
- **Level 1:** Intervenes on gut feeling, not signals. Lets agents loop on the wrong approach too long — burning tokens and compounding errors — or interrupts productive work unnecessarily. Doesn't recognize when an agent is stuck.
- **Level 2:** Reads the signals: agent repeating the same failed approach, edits thrashing without progress, token budget draining. Knows when to let agents run (clear verification path ahead), redirect (wrong approach or repeated failed corrections), or take over (architecture decisions, security, judgment calls). Clears context and restarts rather than fighting accumulated confusion.
- **Level 3:** Categorizes decisions by risk level (proceed / notify / block) and encodes these in agent instructions and hooks. Sets iteration caps and token budgets. Intervention is based on task properties and observable signals, not anxiety. Designs bounded autonomy: clear operational limits with explicit escalation paths.
- **Level 4:** Designs intervention frameworks teams adopt. Calibrates trust as models and tooling improve — knows when to loosen the reins. Identifies where human oversight adds value vs. where it's pure overhead. Refines thresholds with data.
- **Level 5:** Pushes boundaries of autonomous agent operation. Research on when human judgment helps vs. hurts. Published frameworks that advance the field.
