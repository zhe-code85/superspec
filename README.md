# Superspec

Superspec 是一个编排式工作流：**OpenSpec 做外循环**（需求与变更可追踪），**superpowers 做内循环**（按纪律执行任务）。适用于新项目启动、能力新增与需求变更。

Superspec is an orchestration workflow: **OpenSpec as the outer loop** (traceable proposals/spec deltas) and **superpowers as the inner loop** (disciplined execution per task). It targets new project kickoff, new capability delivery, and requirements changes.

## 用法 / Usage

### 1) 安装 / Install

将整个目录复制到个人 skills 目录（不要只拷 `SKILL.md`）：

```
$HOME\.codex\skills\superspec-orchestrator\
```

Copy the whole folder (not just `SKILL.md`) into your personal skills directory:

```
$HOME\.codex\skills\superspec-orchestrator\
```

平台路径 / Platform paths:

- Windows: `%USERPROFILE%\.codex\skills\superspec-orchestrator\`
- macOS/Linux: `~/.codex/skills/superspec-orchestrator/`

可直接让 Agent 读取并执行 `INSTALL.md` 完成安装 / Ask the agent to read `INSTALL.md` and install.

### 1.1) 兼容其他 Agent 的安装手册 / Install for Other Agents

如果你使用的 Agent 不是 Codex CLI，请将整个 `superspec-orchestrator` 目录复制到该 Agent 的 skills 目录，并保持目录结构不变（`SKILL.md` 位于技能根目录）。

If you use a different agent (not Codex CLI), copy the whole `superspec-orchestrator` folder into that agent’s skills directory and keep the folder structure intact (`SKILL.md` at the skill root).

### 1.2) Codex CLI / Code Agent 快速安装

使用源码目录安装：

```
Copy-Item -Recurse -Force .\skills\superspec-orchestrator "$HOME\.codex\skills\superspec-orchestrator"
```

使用打包文件安装（如果你有 `dist/superspec-orchestrator.skill`）：

```
mkdir -Force $HOME\.codex\skills | Out-Null
Expand-Archive -Force dist/superspec-orchestrator.skill $HOME\.codex\skills
```

Quick install from source folder:

```
Copy-Item -Recurse -Force .\skills\superspec-orchestrator "$HOME\.codex\skills\superspec-orchestrator"
```

Quick install from package (if you have `dist/superspec-orchestrator.skill`):

```
mkdir -Force $HOME\.codex\skills | Out-Null
Expand-Archive -Force dist/superspec-orchestrator.skill $HOME\.codex\skills
```

### 2) 触发 / Trigger

在对话中直接点名 skill 并描述需求：

```
superspec-orchestrator
我要新增一个登录能力，之后可能会改成用户名或邮箱登录
```

Mention the skill name and describe the request:

```
superspec-orchestrator
We need a new login capability and may later switch to username-or-email login.
```

### 3) 外循环 / Outer loop: OpenSpec

最低产出：

- `openspec/changes/<change-id>/proposal.md`
- `openspec/changes/<change-id>/tasks.md`
- `openspec/changes/<change-id>/specs/<capability>/spec.md`（ADDED/MODIFIED + 至少 1 个 `#### Scenario:`）
- （可选）`openspec/changes/<change-id>/design.md`

Minimum artifacts:

- `openspec/changes/<change-id>/proposal.md`
- `openspec/changes/<change-id>/tasks.md`
- `openspec/changes/<change-id>/specs/<capability>/spec.md` (ADDED/MODIFIED + at least one `#### Scenario:`)
- (Optional) `openspec/changes/<change-id>/design.md`

校验 / Validate:

```
openspec validate <change-id> --strict --no-interactive
```

### 4) 内循环 / Inner loop: superpowers

每条任务只选一个主 skill：

- 新行为/重构：`superpowers:test-driven-development`
- Bug/不稳定：`superpowers:systematic-debugging`
- 需求不清晰：`superpowers:brainstorming`
- 收尾验收：`superpowers:verification-before-completion`

Pick one per task:

- New behavior / refactor: `superpowers:test-driven-development`
- Bug / flaky behavior: `superpowers:systematic-debugging`
- Requirements unclear: `superpowers:brainstorming`
- Final verification: `superpowers:verification-before-completion`

使用方式 / Load before acting:

```
~/.codex/superpowers/.codex/superpowers-codex use-skill <skill-name>
```

### 5) 变更脚手架（可选）/ Optional scaffolding

```
powershell -File skills/superspec-orchestrator/scripts/new-openspec-change.ps1 -ChangeId add-foo -Capabilities auth,api
```

## 中断恢复 / Interruption Recovery

1. 找到进行中的 change-id：`openspec list`
2. 读取进度：
   - `openspec/changes/<change-id>/proposal.md`
   - `openspec/changes/<change-id>/tasks.md`
   - （可选）`openspec/changes/<change-id>/design.md`
3. 从 `tasks.md` 第一个未勾选项继续
4. 同步现实进度：`git status`、`git diff`、`git log -n 20 --oneline`
5. 继续前先校验：`openspec validate <change-id> --strict --no-interactive`
6. 按任务选一个内循环 skill 执行，完成后勾选 `tasks.md`

1. Find the active change-id: `openspec list`
2. Reload context:
   - `openspec/changes/<change-id>/proposal.md`
   - `openspec/changes/<change-id>/tasks.md`
   - (Optional) `openspec/changes/<change-id>/design.md`
3. Resume from the first unchecked task in `tasks.md`
4. Sync with actual code state: `git status`, `git diff`, `git log -n 20 --oneline`
5. Re-validate: `openspec validate <change-id> --strict --no-interactive`
6. Execute the next task using one inner-loop skill and update `tasks.md`

## 许可 / License

MIT License (aligned with `superpowers` and `OpenSpec`).
