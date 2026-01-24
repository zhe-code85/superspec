# Superpowers Inner Loop (Per Task)

## Principle

Use exactly one *primary* superpowers skill per task, load it first, and follow its checklist with `update_plan`.

## Skill Selection Map

| Situation | Primary skill |
|---|---|
| Requirements ambiguous / many options | `superpowers:brainstorming` |
| Need a concrete step-by-step plan document | `superpowers:writing-plans` |
| Executing a written plan task-by-task | `superpowers:executing-plans` |
| Implementing new behavior / refactor with confidence | `superpowers:test-driven-development` |
| Debugging a bug or flaky behavior | `superpowers:systematic-debugging` |
| Final confidence pass before completion | `superpowers:verification-before-completion` |

## Discipline Reminders

- Load the skill before acting: `~/.codex/superpowers/.codex/superpowers-codex use-skill <skill-name>`.
- If the skill has a checklist, mirror it into `update_plan` and tick it off.
- Keep the outer loop artifacts fresh:
  - Update `openspec/changes/<change-id>/tasks.md`
  - Update delta specs when behavior changes
  - Record decisions in `design.md` when non-obvious

