# Verification

Proving it works. The non-outsourceable human responsibility: "a computer can never be held accountable." Testing, security, code review, and catching AI failures before they ship.

## Testing & Verification

Demonstrating that code does what it claims through automated tests, CI/CD, and manual verification. The discipline of "I saw it work" — not "the AI said it works."

- **Level 0:** Ships without testing. No test files, no CI, no manual verification beyond "it runs."
- **Level 1:** Tests exist but inconsistently. Written after implementation to confirm behavior, not define it. No CI/CD. Unaware of tautological testing — AI-generated tests that mirror the implementation rather than specifying intended behavior.
- **Level 2:** Writes tests that define intended behavior before integrating AI code. Runs them on every change. Knows that coverage measures execution, not bug detection — a suite with 100% coverage can still miss 96% of bugs. Manually verifies critical paths. Has CI/CD running.
- **Level 3:** Test strategy is deliberate: unit/integration/e2e coverage planned per feature. CI/CD enforces quality gates on every change. Uses mutation testing to measure actual bug-catching ability. Knows when to test AI output deterministically (compiles, type-checks, lints) vs. probabilistically (evals, sampling). Practices test-driven generation — writes tests first, has AI implement against them.
- **Level 4:** Test infrastructure others adopt. Designs testing approaches for AI-specific challenges: non-deterministic output, tautological test detection, context-dependent failures. Embeds verification in agent loops (agents test their own output), not just post-hoc.
- **Level 5:** Advances the field's approach to testing AI-integrated systems.

## Code Review

Reading, understanding, and taking ownership of AI-generated code. Catching hallucinations, silent regressions, and architectural misalignment. Includes the "AI cheating" pattern: agents deleting or weakening tests to make them pass.

- **Level 0:** Doesn't review AI output. Commits directly. Ships code they can't explain.
- **Level 1:** Glances at diffs but trusts plausible-looking code. Misses hallucinated APIs, tautological tests, outdated library usage. Can't distinguish between code that works and code that's correct.
- **Level 2:** Reads AI diffs critically; can explain agent-generated code before committing. Catches common AI failure modes: hallucinated APIs, missing edge cases, security vulnerabilities that pass functional tests. Questions unfamiliar patterns rather than assuming the AI knows better. Verifies tests assert intent, not just implementation.
- **Level 3:** Systematic review process: fresh-context review (separate session to avoid confirmation bias), explicit checklist (auth, error handling, test quality, duplication against existing utils). Catches architectural misalignment, not just line-level bugs. Uses permission restrictions (.claudeignore, settings) to prevent agents from gaming tests. Identifies failure patterns by class — over-abstraction, premature generalization, test tautology — rather than instance.
- **Level 4:** Develops review patterns others adopt. Tooling or processes that systematically catch AI-specific failure modes at the rate agents produce code. Can review agent output without becoming a bottleneck.
- **Level 5:** Contributes research or tools that advance AI code review practices.

## Eval Design

Building systematic evals and quality benchmarks for AI output. Not "does it look right" but "does the AI system do what I need, reliably, and will I know when it stops."

- **Level 0:** No evals. Judges AI output by reading it once and going with gut feel.
- **Level 1:** Manual spot-checking. Reruns prompts to see if output "looks right." No systematic benchmarks. No distinction between testing new capabilities and catching regressions.
- **Level 2:** Builds simple automated evals from real failure cases with pass/fail criteria. Runs them on prompt or model changes. Knows the difference between code-based evals (deterministic, for objectively correct answers) and model-based evals (LLM-as-judge, for subjective quality). Sources eval tasks from actual failures (20-50 to start), not synthetic examples.
- **Level 3:** Eval suite covers positive and negative cases. Uses appropriate grading — code-based for deterministic outcomes, LLM-as-judge for qualitative (calibrated against human-labeled examples to catch position and verbosity bias). Distinguishes capability evals (pushing forward) from regression evals (protecting what works) — saturated evals graduate to regression suites. Practices eval-driven development: builds evals before features. Reads agent transcripts to verify evals measure what matters.
- **Level 4:** Designs eval frameworks others adopt. Handles the hard problems: calibrating LLM judges across domains, detecting distribution shift, designing evals for multi-step agentic workflows, choosing between pass@k (at least one success) and pass^k (consistent success) for different risk profiles.
- **Level 5:** Pushes the field forward on AI evaluation methodology.

## Security Practice

Secrets management, authentication, input/output validation, dependency awareness, and hardening against AI-specific attack vectors. The attack surface has expanded: MCP servers, agent permissions, LLM output flowing unsanitized to downstream systems.

- **Level 0:** Secrets in code. No input validation. Unaware of dependency risks or AI-specific attack surfaces.
- **Level 1:** Uses .env files and .gitignore but inconsistently. Some input validation. Doesn't audit dependencies. Doesn't validate LLM outputs before passing them to databases, shells, or APIs — the LLM becomes an injection vector. Unaware that AI-assisted commits leak secrets at 2x the baseline rate.
- **Level 2:** Keeps secrets out of code and out of files accessible to LLM context windows. Validates inputs and sanitizes LLM outputs before downstream systems. Maintains dependency awareness — knows what's in the supply chain. Pins MCP server versions rather than using @latest.
- **Level 3:** Secrets manager in production. Input validation covers LLM-specific risks (prompt injection detection, output sanitization, structured output enforcement). Regular dependency audits including model and MCP server supply chains. Security review before shipping auth/payment flows. Understands OWASP LLM Top 10 risks relevant to their product.
- **Level 4:** Security practices others adopt. Builds tooling for AI-specific security (MCP server auditing, agent permission frameworks, automated prompt injection testing, supply chain verification).
- **Level 5:** Advances AI application security practices for the community.

## Threat Modeling

Systematic security thinking: attack surfaces, AI-specific threats, defense in depth. Knowing where your system is exploitable — especially the attack surfaces that agents and tool integrations introduce.

- **Level 0:** No awareness of attack surfaces. Builds without considering adversarial use.
- **Level 1:** Knows threats exist in the abstract but doesn't systematically assess their own product. No documented threat model. Doesn't think about what happens when an agent has access to private data, untrusted content, and external communication simultaneously.
- **Level 2:** Identifies AI-specific attack surfaces in their product: prompt injection (direct and indirect), insecure output handling, excessive agent permissions. Understands the lethal trifecta — private data + untrusted content + external communication = exploitable. Has basic defenses for identified risks.
- **Level 3:** Documented threat model covering OWASP LLM Top 10 and Agentic Top 10 risks relevant to their product. Designs task segmentation to break the lethal trifecta — separates research (web access, no sensitive data) from implementation (sensitive data, no untrusted content). Layered defenses. Regular reassessment as features and agent capabilities change.
- **Level 4:** Threat modeling practices others adopt. Identifies novel AI-specific attack vectors. Designs trust boundary architectures for multi-agent systems.
- **Level 5:** Contributes to the field's understanding of AI system threats.

## AI System Debugging

Diagnosing misbehaving AI systems where the bug isn't in code logic but in context, retrieval, or model behavior. No stack trace — requires a different investigative instinct: is this a retrieval problem, a context problem, or a model capability problem?

- **Level 0:** When AI output is wrong, retries with a different prompt. No systematic diagnosis.
- **Level 1:** Recognizes that AI failures have different causes (prompt, context, model, retrieval) but diagnoses by trial and error rather than isolation. Doesn't use tracing or observability tools.
- **Level 2:** When AI output goes wrong, checks prompt, retrieved context, and model behavior separately rather than guessing. Can read a trace. Distinguishes retrieval failure ("right information wasn't found" — ~70% of RAG issues) from generation failure ("model ignored what it was given") from context assembly failure ("critical info buried in the middle of the window").
- **Level 3:** Systematic debugging toolkit: span-level tracing (OpenTelemetry GenAI conventions or equivalent), retrieval quality metrics, prompt diff testing. Can isolate failures by type — context window attention dropping critical info, retrieval returning irrelevant documents, instructions drifting across long sessions. Monitors cost and latency as diagnostic signals — runaway loops burn budget before humans notice.
- **Level 4:** Builds debugging infrastructure others use. Novel diagnostic approaches for AI system failures. Designs observability for multi-agent workflows with correlation across agent boundaries.
- **Level 5:** Advances the field's approach to AI system observability and debugging.
