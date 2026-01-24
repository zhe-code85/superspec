# Superspec Agent Install Guide

This file is written for agents. You can read `INSTALL.md` and follow it to install the skill.

本文面向 Agent。请让 Agent 读取 `INSTALL.md` 并按步骤完成安装。

## Install (简化版)

1. Copy the folder `skills/superspec-orchestrator/` into your agent’s skills directory.
2. Keep the folder structure intact and ensure `SKILL.md` is at the skill root.

## Skills Directory (by OS)

- Windows: `%USERPROFILE%\.codex\skills\`
- macOS/Linux: `~/.codex/skills/`

## Codex CLI / Code Agent (PowerShell)

```
Copy-Item -Recurse -Force .\skills\superspec-orchestrator "$HOME\.codex\skills\superspec-orchestrator"
```

## Codex CLI / Code Agent (bash/zsh)

```
mkdir -p ~/.codex/skills
cp -R ./skills/superspec-orchestrator ~/.codex/skills/superspec-orchestrator
```

## Package Install (Optional)

If you have `dist/superspec-orchestrator.skill`, unzip it into the skills directory.

Windows:
```
mkdir -Force $HOME\.codex\skills | Out-Null
Expand-Archive -Force dist/superspec-orchestrator.skill $HOME\.codex\skills
```

macOS/Linux:
```
mkdir -p ~/.codex/skills
unzip -o dist/superspec-orchestrator.skill -d ~/.codex/skills
```
