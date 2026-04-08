# Skill Writing Best Practices

From Anthropic official plugins/skills and skill-creator documentation.

## Description field

The sole triggering mechanism. Claude reads this to decide whether to load a skill.

- Be "pushy" — Claude tends to under-trigger. List specific trigger phrases and contexts.
- Include negative triggers (DO NOT TRIGGER when...) if there's ambiguity.
- Max 1024 chars.

## SKILL.md body

- Keep under 500 lines / ~5000 tokens. Move reference material to separate files.
- Three-level loading: metadata (~100 tokens, always loaded) > SKILL.md body (on activation) > reference files (on demand).
- Explain **why**, not just what. LLMs have good theory of mind — reasoning beats rigid rules.
- If you're writing ALWAYS or NEVER in all caps, reframe as reasoning instead.
- Keep the prompt lean. Remove things that aren't pulling their weight.

## Subagent dispatch

- Don't specify exact search queries — specify what to look for and where.
- Provide **example prompts**, not verbatim prompts. Let the LLM compose actual queries.
- Specify model tier (Haiku/Sonnet) only when cost/quality tradeoff matters.
- For complex agents, define personality and output format in separate `agents/` files.

## Output format

- Exact template with placeholders: when output needs to be machine-readable.
- Structural guidance (list sections, not exact format): when the LLM needs flexibility.
- No format spec: when the output type is implicit (e.g., code generation).

## File organization

```
skill-name/
  SKILL.md          # required, <500 lines
  references/       # docs loaded into context on demand
  scripts/          # executable code for deterministic tasks
  agents/           # subagent definitions (personality, tools, output format)
  assets/           # templates, icons, fonts
```

- Reference files: include "read this when..." guidance in SKILL.md.
- Scripts: tell the agent to run `--help` first, not read source code.
- For large reference files (>300 lines), include a table of contents.

## Patterns that work

- **Decision trees** for skills with multiple paths.
- **Progressive disclosure** — keep SKILL.md lean, point to reference files.
- **Philosophy-first** — explain the aesthetic or intent before mechanics.
- **Example prompts** for subagents instead of exact prompts.

## Anti-patterns

- Specifying exact search queries (too brittle, LLM can do better).
- Repetitive emphasis ("meticulously", "master-level" — once is enough).
- Inline reference material that should be in a separate file.
- Heavy-handed MUSTs when reasoning would be more effective.

## Voice and anti-slop (for user-facing output)

From gstack skills, office-hours, and design-consultation.

**Tone:** direct, concrete, sharp, encouraging, curious not lecturing. Sound like a builder talking to a builder, not a consultant presenting to a client.

**Show, don't tell.** Reference the user's actual projects, decisions, and words:
- GOOD: "You didn't say 'small businesses,' you said 'Sarah, the ops manager at a 50-person logistics company.'"
- BAD: "You demonstrated conviction and independent thinking."

**Banned vocabulary:** delve, crucial, robust, comprehensive, nuanced, multifaceted, furthermore, moreover, additionally, pivotal, landscape, tapestry, underscore, foster, showcase, intricate, vibrant, fundamental, significant, interplay.

**Banned phrases:** "here's the kicker", "here's the thing", "plot twist", "let me break this down", "the bottom line", "make no mistake", "can't stress this enough".

**Anti-sycophancy:** Never say "that's an interesting approach", "there are many ways to think about this", "you might want to consider", "that could work". Take a position instead.

**Writing patterns:**
- No em dashes. Use commas, periods, or "..."
- Short paragraphs. Mix one-sentence paragraphs with 2-3 sentence runs.
- Punchy standalone sentences. "That's it." "Not great."
- Lead with the point. End with what to do.
- Every recommendation needs a "because".
- Praise must be earned and specific. "Great job!" is banned.
- Frame growth as investment, not criticism.

**Final test:** does this sound like a sharp friend who shipped code today, or a consultant presenting to a client?
