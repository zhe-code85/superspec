---
name: openspec-driven-dev
description: OpenSpec workflow coordinator with pluggable agent interfaces. Defines workflow steps with optional agent insertion points. Use for spec-driven development. Configure available agents per your environment.
---

# OpenSpec Workflow Coordinator

Workflow with pluggable agent interfaces. Configure based on your environment.

## Decision Tree

```
Request?
├─ Bug fix/typo? → Fix directly
└─ New feature/breaking? → OpenSpec workflow
```

## OpenSpec Workflow

### Step 1: Check Context
```bash
openspec list
openspec list --specs
```

**Optional Agent Insertion**: If requirements unclear
→ Use your environment's brainstorming/analysis agent

### Step 2: Create Proposal
```
/openspec-proposal
```
- Write proposal.md (why, what, impact)
- Write tasks.md (implementation checklist)
- Write spec deltas
- Validate: `openspec validate <id> --strict`

**Optional Agent Insertion**: If complex architectural decisions
→ Use your environment's architecture/planning agent

Get user approval before proceeding

### Step 3: Implement
```
/openspec-apply
```
For each task in tasks.md:
```
1. Write code
2. Run tests
```

**Optional Agent Insertion**: After completing logical units
→ Use your environment's code review agent (if available)

### Step 4: Verify
- All tests pass
- Linting clean

**Optional Agent Insertion**: Before completion
→ Use your environment's verification agent (if available)

- Manual verification done

### Step 5: Archive
```
/openspec-archive
```

## Agent Interface Configuration

This skill defines **insertion points**. Configure based on your environment:

### Available Agent Slots

| Slot | Purpose | Example Agents (configure as needed) |
|------|---------|--------------------------------------|
| **Brainstorming** | Requirement analysis | `superpowers:brainstorming`, `general-purpose` |
| **Planning** | Architecture decisions | `oracle`, `general-purpose` |
| **Code Review** | Quality gate | `superpowers:code-reviewer` |
| **Verification** | Pre-completion check | `superpowers:verification-before-completion` |
| **Debugging** | When tests fail | `superpowers:systematic-debugging` |

### Usage Pattern

```python
# If your environment has the agent, use it:
if has_agent("superpowers:code-reviewer"):
    Task(subagent_type="superpowers:code-reviewer")

# If your environment has oracle:
if has_agent("oracle"):
    Task(subagent_type="oracle")
else:
    Task(subagent_type="general-purpose")  # Fallback

# If no specialized agent available:
# → Do the work directly without delegation
```

## Default Behavior

**If no agents configured**: This skill works as a pure workflow coordinator
- Lists steps
- Uses OpenSpec slash commands
- You do all work directly

**If agents configured**: Insert them at appropriate points
- Enhanced quality with code review
- Enhanced planning with architecture agents
- Enhanced verification

## Configuration

**This skill does not hardcode any agents**. Based on your environment:

**With Superpowers**:
```python
# Brainstorming slot → superpowers:brainstorming
# Review slot → superpowers:code-reviewer
# Verify slot → superpowers:verification-before-completion
```

**With OpenCode agents**:
```python
# Planning slot → oracle
# Review slot → (use your review agent)
```

**Minimal (no specialized agents)**:
```python
# All slots → direct implementation (no delegation)
```

## That's It

- **Core**: OpenSpec workflow steps
- **Interfaces**: Pluggable agent insertion points
- **Configuration**: Per your environment
- **Fallback**: Works without any specialized agents

Reference documentation:
- `openspec/AGENTS.md` - OpenSpec conventions
- `openspec/project.md` - Project patterns
