<div align="center"><pre>
█▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
█ █ █▀▀ █ █ █   █ █ █ █ █▀▀
▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀  
</pre></div>

<p align="center">
  <em>You're shipping faster than ever.</em><br>
  <em>But are you actually getting better?</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-000?style=flat&logo=anthropic&logoColor=white" alt="Claude Code">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT">
</p>

---

**Devloop** is the growth feedback loop for AI builders. It scans your code, Claude sessions, git history, and shipped products. Maps you against seven competency domains. Finds the one thing worth reading about your biggest gap.

No feeds. No firehose. 2-3 recommendations a week, connected to your work, your stage.

## Right for you if

- You build with AI coding tools and ship fast, but worry you're not learning from the speed
- You've shipped something but nobody uses it, and you're not sure what to work on next
- You feel the AI news firehose (new framework every week, tool fatigue, FOMO) but can't separate signal from noise
- You're a solo founder or small team without a senior engineer, PM, or mentor looking over your shoulder
- You suspect your weakest skill isn't code, it's something else, but you can't name it

## What Devloop is not

- **Not a course.** No curriculum, no lessons. It shows you where to focus, not what order to learn things in.
- **Not a code review bot.** It finds growth gaps across your skillset, not bugs in your code.
- **Not for non-builders.** If you're stuck in tutorial hell, there's no work to scan.

## How it works

```
  /grow ······· run 2-3 times a week
    │
    ▼
  Scan ········ code, git, sessions, shipped products
    │
    ▼
  Target ······ rank growth opportunities across 7 domains
    │
    ▼
  Search ······ 50+ curated sources in parallel
    │
    ▼
  Deliver ····· one recommendation that hits
```

**Heads up: the first run triggers a full scan of your work**. This is token-heavy (especially with a large codebase or many sessions), but it only happens once. Every run after is lighter and sharper as the system learns more about you and how you respond to recommendations.

## What changes

| Without Devloop                                                        | With Devloop                                                              |
| ---------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| You know AI tools are changing weekly but can't keep up with all of it | One recommendation per run, from 50+ sources, targeting your specific gap |
| You suspect you're weak at distribution but don't know where to start  | A competency map with concrete evidence from your own code and sessions   |
| You read HN/Twitter/newsletters and feel informed but not better       | Content connected to your project, not generic "10 tips" listicles        |
| You have no mentor, no senior engineer reviewing your growth           | An honest assessment that shows gaps, not just what you're good at        |
| You build another feature when you should be talking to users          | A recommendation that says so, with the specific conversation to have     |

## Competency map

What it actually takes to build and ship AI products in 2026. Seven domains, rated 0-5 per concept, grounded in evidence from your actual work.

| Domain            | What it covers                                                                                                  |
| ----------------- | --------------------------------------------------------------------------------------------------------------- |
| **Resilience**    | Direction, pace, persist vs. quit, builder voice                                                                |
| **Product Taste** | User empathy, value clarity, design judgment, feature discipline, PMF judgment                                  |
| **Directing AI**  | Prompt craft, context engineering, spec-driven development, tool & service evaluation, human-AI task allocation |
| **Agent Fluency** | Task delegation, orchestration patterns, agent infrastructure, harness engineering, intervention judgment       |
| **Verification**  | Testing & verification, code review, eval design, security practice, threat modeling, AI system debugging       |
| **Distribution**  | Web presence & SEO, content strategy, channel focus, community building, growth systems                         |
| **Business**      | Revenue design, unit economics, legal & compliance, financial management                                        |

## Sources

Every run searches 50+ curated definitive sources:

- **Engineering blogs:** Anthropic, Stripe, Cloudflare, Vercel, Supabase, Linear, Netflix
- **Individual voices:** Simon Willison, Julia Evans, Paul Graham, Patrick McKenzie, Eugene Yan, Lilian Weng
- **Newsletters:** Latent Space, Pragmatic Engineer, Lenny's Newsletter, One Useful Thing, First Round Review
- **Social:** Hacker News (100+ points), Twitter/X (@karpathy, @simonw, @swyx, @levelsio)
- **Research:** arXiv via HuggingFace Papers, Semantic Scholar
- **Tools & releases:** GitHub Trending, Product Hunt, changelogs for your actual dependencies
- **Podcasts & video:** Latent Space, Lightcone (YC), Fireship, Theo

## Quick start

```bash
# In any Claude Code session
/install github:jackguo709/devloop
```

Then run `/grow`. That's it, everything runs locally.

## Privacy

Everything stays on your machine. Your profile, observations, and history live in `~/.devloop/`. No account, no telemetry, no data sent anywhere.

## Roadmap

- [x] Onboarding scan across code, git, CLI sessions, desktop sessions, web profiles
- [x] Seven-domain competency map with evidence-grounded ratings
- [x] Curated content delivery from 50+ sources
- [x] Profile and observation persistence across sessions
- [ ] SessionEnd hook for background profile sync
- [ ] Growth tracking over time (see your ratings change as you level up)
- [ ] Team mode (map a small team's collective gaps)
- [ ] Email delivery

## License

MIT
