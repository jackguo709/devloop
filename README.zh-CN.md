<div align="center"><pre>
█▀▄ █▀▀ █ █ █   █▀█ █▀█ █▀█
█ █ █▀▀ █ █ █   █ █ █ █ █▀▀
▀▀  ▀▀▀  ▀  ▀▀▀ ▀▀▀ ▀▀▀ ▀  
</pre></div>

<p align="center">
  <a href="README.md">English</a> |
  <a href="README.zh-CN.md">简体中文</a> |
  <a href="README.es.md">Español</a>
</p>

<p align="center">
  <em>代码写得越来越快了，</em><br>
  <em>但你有在成长吗？</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-000?style=flat&logo=anthropic&logoColor=white" alt="Claude Code">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT">
</p>

---

**Devloop** 帮你看清自己作为 AI 时代开发者的成长方向。它会分析你的代码、Claude 对话、git 记录和已发布的产品，在七个能力维度上给你画像，然后针对你最大的短板，找到一篇真正值得读的内容。

不刷 feed，不搞信息轰炸。一周 2-3 条推荐，每条都跟你当前的工作和阶段有关。

## 你可能需要它

- 用 AI 写代码又快又爽，但总觉得自己没从中真正学到什么
- 东西上线了，但没人用，不知道接下来该干嘛
- AI 圈天天有新东西（新框架、新工具、各种焦虑），但你分不清哪些值得关注
- 一个人干或者小团队，身边没有老手带，没人帮你复盘
- 隐约觉得自己的瓶颈不在写代码，但具体是什么又说不上来

## Devloop 不做这些事

- **不是课程。** 没有大纲，没有进度条。它告诉你该往哪看，不规定你怎么学。
- **不是代码审查工具。** 它找的是你能力上的盲区，不是代码里的 bug。
- **不适合还没开始动手的人。** 如果你还在跟教程，没有实际项目可以分析。

## 原理

```
  /grow ······· 一周跑 2-3 次
    │
    ▼
  扫描 ········ 代码、git、对话记录、已上线产品
    │
    ▼
  定位 ········ 七个维度里找到最值得提升的方向
    │
    ▼
  检索 ········ 50+ 精选信源并行搜索
    │
    ▼
  推荐 ········ 给你一条真正有用的内容
```

**注意：第一次运行会做一次全量扫描**，token 消耗会比较大（代码库大或者对话多的话尤其明显），但这只发生一次。后续每次运行都更快更准，因为系统会持续学习你的情况和偏好。

## 用和不用的区别

| 没有 Devloop                              | 有了 Devloop                                 |
| ----------------------------------------- | -------------------------------------------- |
| AI 工具每周都在变，根本追不过来           | 每次运行给你一条推荐，从 50+ 信源中精准匹配  |
| 觉得自己不会做增长，但不知道从哪开始      | 一张能力图谱，证据全来自你自己的代码和对话   |
| 刷 HN、刷 Twitter、看了一堆，但感觉没变强 | 推的内容跟你的项目直接相关，不是泛泛的攻略帖 |
| 没人带，没人给你反馈                      | 一份诚实的评估，不光说你强在哪，更说你差在哪 |
| 又在加功能了，其实该去跟用户聊聊          | 推荐会直说，还会告诉你具体该聊什么           |

## 能力图谱

2026 年做 AI 产品到底需要什么能力。七个维度，每个概念 0-5 分，打分依据是你真实的工作产出。

| 维度           | 包括什么                                                          |
| -------------- | ----------------------------------------------------------------- |
| **韧性**       | 方向感、节奏把控、该坚持还是该转向、表达能力                      |
| **产品感**     | 用户共情、价值判断、设计品味、做减法的能力、PMF 嗅觉              |
| **驾驭 AI**    | prompt 技巧、上下文工程、spec 驱动开发、工具选型、人机分工        |
| **Agent 能力** | 任务拆分与委派、编排模式、Agent 基础设施、harness 工程、介入时机  |
| **质量把控**   | 测试验证、code review、eval 设计、安全意识、威胁建模、AI 系统调试 |
| **增长分发**   | SEO 与线上存在、内容策略、渠道选择、社区运营、增长机制            |
| **商业能力**   | 变现设计、单位经济、合规法务、财务管理                            |

## 信息源

每次运行从 50+ 个精选信源中搜索：

- **工程博客：** Anthropic, Stripe, Cloudflare, Vercel, Supabase, Linear, Netflix
- **独立博主：** Simon Willison, Julia Evans, Paul Graham, Patrick McKenzie, Eugene Yan, Lilian Weng
- **Newsletter：** Latent Space, Pragmatic Engineer, Lenny's Newsletter, One Useful Thing, First Round Review
- **社区：** Hacker News（100+ 赞）, Twitter/X (@karpathy, @simonw, @swyx, @levelsio)
- **论文：** arXiv via HuggingFace Papers, Semantic Scholar
- **工具动态：** GitHub Trending, Product Hunt, 你项目实际依赖的更新日志
- **播客/视频：** Latent Space, Lightcone (YC), Fireship, Theo

## 快速开始

```bash
# 在任意 Claude Code 会话里
/install github:jackguo709/devloop
```

然后跑 `/grow` 就行了。全部本地运行，不联网不上传。

## 隐私

所有数据都在你自己电脑上。个人画像、观察记录、历史数据存在 `~/.devloop/`。不用注册，不采集数据，什么都不往外发。

## 路线图

- [x] 全方位扫描：代码、git、CLI 会话、桌面会话、线上资料
- [x] 七维能力图谱，基于真实证据打分
- [x] 50+ 精选信源的内容推荐
- [x] 画像和观察记录跨会话持久化
- [ ] SessionEnd 钩子，后台自动同步画像
- [ ] 成长轨迹追踪（看你的分数怎么变的）
- [ ] 团队模式（一个小团队的能力全景图）
- [ ] 邮件推送

## 许可证

MIT
