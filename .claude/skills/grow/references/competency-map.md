# Competency Map

7 domains, each with underlying concepts.

## 1. Resilience

Staying in the game long enough to win. AI speeds up building but not traction — the emotional crash when shipping speed ≠ distribution speed is the defining psychological challenge of the AI builder era. Without this, nothing else matters.

- **Direction** — Clear thesis, evidence-based pivoting, long-term vision that survives tactical changes.
- **Pace** — Sustainable cadence, energy management, calibrating expectations. Agentic tools operate like slot machines — variable ratio reinforcement that drives compulsive overwork. The crash comes when a product ships in two weeks but gets no traction for six months.
- **Persist vs. Quit** — The hardest judgment call. When to keep going, when to pivot, when to walk away.
- **Builder Voice** — Who you are beyond your tools or current project. The psychological foundation that survives any single product's failure, and the public voice that makes your perspective visible.

## 2. Product Taste

Building the right thing. When anyone can build your product in a weekend, design judgment and customer empathy are the moat. Taste is pattern recognition developed through experience — not unteachable genius.

- **User Empathy** — Understanding who you're building for through conversation, not assumption. The discipline of talking to users before, during, and after building.
- **Value Clarity** — Articulating what you do and why it matters in one sentence that makes strangers care.
- **Design Judgment** — Visual consistency, information architecture, UX decisions that get past AI's "80% quality" default. Intentionality and delight over generic competence.
- **Feature Discipline** — What to build, what to skip, what to kill — when building is cheap and the temptation is to build everything.
- **PMF Judgment** — Reading the signal on product-market fit. Competitive positioning, market timing, knowing when you've found it vs. when you're fooling yourself.

## 3. Directing AI

Telling AI what to do and how to do it. The shift from writing code to writing intent. When implementation is commoditized, the spec is the primary work product.

- **Prompt Craft** — From chat-style requests to authoritative, structured instructions that constrain AI output effectively.
- **Context Engineering** — Curating the information environment: what to include, what to withhold, when to refresh. The "RAM management" of AI work.
- **Spec-Driven Development** — Writing specifications that define what to build, how it should work, and what constraints apply — from feature specs to system architecture. The spec is the primary work product.
- **Tool & Service Evaluation** — Rapidly assessing and adopting new AI tools, services, and platforms. Knowing which tool for which task, when a service eliminates the need to build, switching without attachment.
- **Human-AI Task Allocation** — Choosing what to delegate to AI vs. do yourself. The core distinction: implementation has verifiable correctness (checkable); design does not (uncheckable). AI excels at the former, fails at the latter.

## 4. Agent Fluency

Thinking and working natively with AI agents. The cognitive and systems skills for effective human-agent collaboration — from basic delegation to orchestrating multi-agent systems.

- **Task Delegation** — Decomposing work into agent-sized chunks with clear goals, context, and success criteria. The management analogy: specifying, dividing, and providing actionable feedback.
- **Orchestration Patterns** — Choosing the right coordination model and managing parallel workstreams: prompt chains, parallel agents, orchestrator-workers, evaluator-optimizer. Includes escalation design — when should agents stop and ask instead of proceeding?
- **Agent Infrastructure** — Building the persistent environment that makes agents effective across sessions: CLAUDE.md, skills, hooks, MCP servers, memory systems.
- **Code Comprehension** — Actively questioning, reviewing, and understanding agent-generated code rather than accepting it blindly. Managing the risk of code you didn't write.
- **Intervention Judgment** — Knowing when to let agents run, when to redirect, and when to take over entirely. The human override instinct, calibrated by experience.

## 5. Verification

Proving it works. The non-outsourceable human responsibility — "a computer can never be held accountable." Testing, security, code review, and catching AI failures before they ship.

- **Testing & Verification** — Demonstrating that code does what it claims, both manually and through automated tests, before shipping. CI/CD, test coverage strategy, the discipline of "I saw it work."
- **Code Review** — Reading and evaluating AI-generated code with a critical eye. Catching hallucinations, silent regressions, and the "AI cheating" pattern — deleting tests to make them pass.
- **Eval Design** — Building systematic evals and quality benchmarks for AI output. Not just "does the code run" but "does the AI system do what I need, reliably."
- **Security Practice** — Secrets management, authentication, input validation, dependency awareness, security auditing, and hardening. From baseline hygiene to systematic security engineering.
- **Threat Modeling** — Systematic security thinking: attack surfaces, AI-specific threats (prompt injection, data poisoning), defense in depth.
- **AI System Debugging** — Diagnosing misbehaving AI systems where the bug isn't in code logic but in context, retrieval, or model behavior. Reading prompt traces, testing chunking strategies, identifying context window effects. No stack trace — requires a different investigative instinct.

## 6. Distribution

Getting people to use what you built. The #1 AI builder failure mode is "shipped but nobody uses it." AI compressed building to days; audience-building still takes months. Distribution is half the product.

- **Web Presence & SEO** — Existing on the internet and being found. Landing pages, search optimization, analytics, conversion. From minimum viable visibility to discoverability expertise.
- **Content Strategy** — Building in public, audience development, teaching what you learn. The long game that compounds.
- **Channel Focus** — Going deep in 2-3 channels rather than broadcasting everywhere. Manual-first validation before scaling any channel.
- **Community Building** — Cultivating relationships that become a moat AI can't replicate. Design partners, user communities, the relational advantage.
- **Growth Systems** — Repeatable acquisition, network effects, distribution that compounds without you.

## 7. Business

Money, legal, sustainability. The gap between a shipped product and a sustainable business. AI changes the economics — variable inference costs, outcome-based pricing, the 2026 renewal cliff.

- **Revenue Design** — Pricing strategy, monetization model, and the shift toward outcome-based pricing. Making money in a world where AI changes cost structures for everyone.
- **Unit Economics** — CAC, LTV, churn, margins. Understanding whether growth is sustainable or burning cash.
- **Legal & Compliance** — Terms, privacy policy, IP ownership, and AI-specific regulation (EU AI Act, output liability, disclosure obligations). From basic legal hygiene to navigating the expanding regulatory surface area for AI products.
- **Financial Management** — Modeling costs, managing runway, unit economics, and making sound investment decisions. From tracking expenses to financial modeling and fundraising strategy.

## Level Definitions

Rate each concept individually using these levels. Be critical. Volume of baseline observations does not equal a high level. Domain level = average across ALL concepts (one decimal place). "Need more data" counts as 0 in the average.

- **Need more data.** Not enough observations to assess confidently. Don't guess.
- **Level 0: Unstarted.** Unaware or hasn't engaged with this concept yet.
- **Level 1: Aware.** Knows this matters but hasn't applied it consistently. Relies on defaults or instinct.
- **Level 2: Solid.** Applies this consistently and deliberately. Understands the tradeoffs. Meets the bar for an active builder shipping real products.
- **Level 3: Deep.** Goes beyond the basics. Handles novel situations, makes nuanced judgment calls. Track record of good decisions here.
- **Level 4: Leading.** Creates approaches or work in this area that others learn from. Depth is visible in shipped work.
- **Level 5: Exceptional.** Pushes boundaries. Deep expertise that influences how others think about this concept. Few people reach this.
