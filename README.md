# grow

The growth engine for AI builders who are actively shipping.

You're building faster than ever but not sure you're actually getting better. Grow scans your code, Claude conversations, and shipped product. It maps you against a competency map covering everything AI builders need, not just code, but product, distribution, security, and resilience. Then it finds the one piece of human-written content from 50+ curated sources that targets the gap holding you back most. The more you build, the sharper it gets.

## Example

```
$ /grow

Hey Jack, your auth-middleware PR has been open since Tuesday.
The agent rewrote your session handling and logout now silently
drops the refresh token instead of invalidating it server-side.
Your tests don't cover that path.

That PR is 340 lines. How much of it did you actually read?

> honestly I skimmed it, the diff was huge

Yeah, that's kind of the whole problem right now. Ankit Jain
(ex-Google, founded Aviator, YC S21, used by Slack and Figma)
wrote something on Latent Space (the biggest AI engineering
newsletter) last month that hit the HN front page and reframes
this really well.

His argument is that trying to review faster is a dead end.
Humans couldn't keep up with code review even when humans wrote
code at human speed. PRs would sit for days, approvals were
rubber stamps, and everyone skimmed 500-line diffs because they
had their own work to ship. Now agents are 10x-ing the volume
and it's only getting worse. A recent survey across 10,000+
developers found that teams with high AI adoption merge 98% more
PRs but review time is up 91%.

His alternative is to flip the order. Instead of letting the
agent code first and then trying to review a 340-line diff,
you write a short spec first, then let the agent implement it.

A spec is just a markdown file in your repo (something like
specs/auth-middleware.md) that describes what the feature should
do, the edge cases, and how to verify it worked. You write it
before asking Claude or Cursor to touch any code. Then the agent
codes to your spec instead of improvising, and you verify the
behavior matches what you wrote instead of reading every line.

In one of Ankit's experiments, a verifier agent checked 65 acceptance
criteria from a spec in six minutes: 60 passed, 4 failed,
1 partial. Way faster and more reliable than skimming a diff.

→ latent.space/p/reviews-dead

Want me to generate specs/auth-session.md? Based on your current
code, it would cover:
  - On logout, invalidate the refresh token server-side
    (not just drop it client-side like it does now)
  - Expired tokens return 401, not a silent failure
  - Test: logout then attempt refresh, expect rejection

```

## Install

Copy the skill into your project:

```bash
/plugin install github:jackguo709/grow
```

Then run `/grow` in Claude Code.

## How it works

1. **Scans** your project, git history, Claude sessions, and optionally your product URL and social profiles.
2. **Asks** a reflective question grounded in what it found.
3. **Targets** the single most impactful gap across seven competency domains, then searches 50+ sources in parallel.
4. **Delivers** one piece that matters, connected to your code, your situation, your stage.
5. **Adapts** how it teaches you. Beginners get specific instructions and checklists. Intermediate builders get contextual examples and named patterns. Advanced builders get decision frameworks, edge cases, and assumption challenges.
6. **Grows** with you. Every run refines your profile. The more you use it, the sharper it gets.

First run is onboarding: a quick setup, a full scan of your work, what it found (including your biggest blind spot), a few reflective questions, and your competency map across all seven domains. Then it delivers your first recommendation on the spot.

## Competency Map

Seven domains. Five levels each. Grow assesses where you are and targets the gap that matters most.

- **AI Steering** — Getting AI to do what you want, and knowing when not to use it.
- **Building & Architecture** — Making things that work, hold together, and don't collapse.
- **Security & Reliability** — Not getting hacked. Not losing data. Not leaking secrets.
- **Product & Design** — Building the right thing. Taste, judgment, problem framing.
- **Distribution & Growth** — Getting people to use what you built. Day-one concern, not afterthought.
- **Business & Operations** — Money, legal, support, systems. The gap between MVP and sustainable business.
- **Resilience & Direction** — Staying in the game long enough to win. Energy, pace, identity.

## Sources

Grow searches 50+ curated sources every run: engineering blogs (Anthropic, Stripe, Cloudflare, Vercel, Supabase), individuals (Simon Willison, Julia Evans, Paul Graham), newsletters (Pragmatic Engineer, Lenny, Latent Space, Stratechery), Hacker News (100+ points), Twitter/X (@karpathy, @simonw, @swyx, @levelsio, @emollick), research papers (arXiv via HuggingFace Papers, Semantic Scholar), YC content, GitHub trending, changelogs for your dependencies, and podcasts.

Only content with specifics, real experience, or production evidence makes the cut. Recent content gets priority (last 7 days preferred, last 30 days typical), but a canonical older piece that's the definitive take on your exact gap will still surface over a mediocre recent article.

## Privacy

Everything local. No account, no data sent. Only external calls are web searches and fetches for content.
