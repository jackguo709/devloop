# Directing AI

Telling AI what to do and how to do it. The shift from writing code to writing intent. When implementation is commoditized, the spec is the primary work product.

## Prompt Craft

From chat-style requests to authoritative, structured instructions that constrain AI output effectively. The skill has shifted from clever tricks to clear communication — frontier models don't need prompting hacks, they need precise instructions and good context.

- **Level 0:** Types into AI like a search engine. No awareness that phrasing, structure, or context affect output quality.
- **Level 1:** Knows that clearer instructions get better results. Uses simple task prompts and maybe role assignment. Might use a prompt template found online without understanding why it works. Treats each conversation as independent.
- **Level 2:** Writes structured instructions with constraints, examples, and explicit output format — not chat-style requests. Gets predictably good output on the first or second try. Understands that few-shot examples control format more than capability, and that frontier models reason well without elaborate prompting tricks.
- **Level 3:** Designs reusable prompt templates with modular input slots, versioned and reviewed like code. Knows when techniques help vs. hurt — role prompting improves creative tasks but can damage factual accuracy. Writes system prompts at the right altitude: specific enough to guide, flexible enough to adapt. Uses emphasis strategically on critical rules.
- **Level 4:** Builds prompt systems others adopt — libraries, templates, evaluation pipelines. Treats prompts as first-class engineering artifacts with testing and version control.
- **Level 5:** Advances the field's understanding of effective human-AI instruction. Published research or frameworks.

## Context Engineering

Curating the information environment: what to include, what to withhold, when to refresh. The discipline of finding the smallest set of high-signal tokens that maximizes the desired outcome. Most agent failures are context failures, not model failures.

- **Level 0:** No awareness that what surrounds the prompt matters. Dumps everything in or provides nothing. Conversations accumulate noise without management.
- **Level 1:** Knows context matters but manages it by gut feel. Might start new conversations when things get messy. No deliberate strategy for what information the model sees at each step.
- **Level 2:** Maintains a deliberate, minimal project context file (CLAUDE.md or equivalent) where each line earns its place. Manages what the AI sees — clears context between tasks, uses fresh sessions for review. Understands that more context isn't better context: models degrade with irrelevant information, and critical instructions get buried in noise.
- **Level 3:** Designs dynamic context systems: just-in-time retrieval over upfront loading, progressive disclosure (summaries first, details on demand), sub-agent isolation to keep focused context clean. Structures information to survive compaction — persistent state lives in files, not conversation history. Understands context rot: lost-in-the-middle effects, attention dilution, distractor interference.
- **Level 4:** Builds context architectures others adopt. Designs for cache efficiency, token budget optimization, and multi-agent context isolation. Measures and iterates on context quality systematically.
- **Level 5:** Advances the field's understanding of context engineering. Published research or systems that change how others design AI information environments.

## Spec-Driven Development

Writing specifications that define what to build, how it should work, and what constraints apply. The spec is the primary work product — code is its expression. Specs are versioned documents that survive context resets, team handoffs, and implementation pivots.

- **Level 0:** No specifications. Goes directly from idea to prompting AI to build. Requirements exist only in the builder's head.
- **Level 1:** Has a rough idea of what to build but communicates it conversationally, not as a structured document. Requirements are scattered across chat messages. No acceptance criteria. No distinction between planning and implementation.
- **Level 2:** Writes requirements and constraints before AI implements. Uses tests or acceptance criteria to verify output matches intent. Separates planning from implementation — explores and plans before coding.
- **Level 3:** Full spec-driven pipeline: structured requirements (what/why), implementation plan (how), and task checklists (what next) as linked documents. Specs include explicit uncertainty markers rather than letting AI fill gaps with assumptions. Uses plan mode for architecture before code mode for implementation. Specs survive context resets and enable team handoffs.
- **Level 4:** Spec frameworks others adopt. Designs specification systems for teams — templates, review processes, traceability from requirements through implementation to verification.
- **Level 5:** Advances spec-driven development methodology. Published frameworks or tooling that shapes the field.

## Tool & Service Evaluation

Rapidly assessing and adopting new AI tools, services, and platforms. Knowing which tool for which task, when a service eliminates the need to build, and switching without attachment when something better arrives. The landscape shifts every few months — the tool you commit to in March may not be best by September.

- **Level 0:** Uses whatever AI tool was suggested first. No evaluation criteria. Doesn't know alternatives exist or that tools differ meaningfully.
- **Level 1:** Aware that multiple AI tools exist but hasn't compared them systematically. Uses one tool for everything regardless of task. Doesn't understand cost structures or model differences.
- **Level 2:** Has a primary AI tool chosen for workflow fit, knows its limits, and can adopt new tools without disrupting shipping. Uses managed services (auth, database, hosting) instead of building commodity infrastructure. Understands the cost of what they use.
- **Level 3:** Multi-tool workflow: different tools for different tasks, model routing between cheap and expensive models based on task complexity. Evaluates new tools against concrete criteria (quality, integration, cost, privacy). Adopts new tools in days, not weeks. Manages costs deliberately across the stack.
- **Level 4:** Tool evaluation frameworks others adopt. Influences selection across teams or organizations. Contributes to ecosystem through reviews, benchmarks, or integrations.
- **Level 5:** Shapes how the industry evaluates and adopts AI development tools. Published comparisons or selection frameworks.

## Human-AI Task Allocation

Choosing what to delegate to AI vs. do yourself. The core heuristic: work with verifiable correctness (tests pass, output matches spec) delegates well; work requiring judgment, taste, or organizational context stays with you. AI amplifies existing expertise — seniors ship 2.5x more AI-assisted code than juniors.

- **Level 0:** Either does everything manually or tries to delegate everything to AI. No framework for what AI handles well vs. what it doesn't.
- **Level 1:** Delegates opportunistically — whatever seems like it might work. No systematic criteria. Sometimes delegates judgment calls that need human ownership; sometimes keeps tasks AI could handle faster.
- **Level 2:** Delegates based on verifiability and stakes. Boilerplate, exploration, test generation, and debugging go to AI. Architecture, security decisions, and judgment calls stay with the human. Follows the sandwich workflow: human specifies → AI implements → human verifies.
- **Level 3:** Delegation is systematic and informed by experience. Knows what AI is reliably good at in their domain and where it consistently fails. Adjusts as models improve. Designs work to maximize the delegatable surface — writing clearer specs expands what AI can handle well.
- **Level 4:** Task allocation frameworks others adopt. Designs workflows that optimize the human-AI split for teams. Identifies novel delegation patterns as tooling evolves.
- **Level 5:** Advances the field's understanding of optimal human-AI work allocation. Published research or frameworks.
