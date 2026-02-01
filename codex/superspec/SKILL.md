---
name: superspec
description: "OpenSpec+Superpowers orchestrator for spec-driven development. Use for new changes, proposals/spec updates, implementation after approval, and archiving. Trigger on new feature/requirement, spec change, proposal, plan, architecture."
---

# SuperSpec (Fusion)

Connect OpenSpec (strategy/spec truth) with Superpowers (execution discipline). Keep specs as source of truth and enforce explicit approval before coding.

## 0) Context Reload (Always)
1. Read `openspec/project.md`.
2. Run `openspec list` and `openspec list --specs`.
3. If ambiguous or architecture-impacting, read `openspec/AGENTS.md`.
4. Read relevant specs in `openspec/specs/**/spec.md`.

## 1) Proposal Phase (Strategy)
**Trigger:** new capability, behavior change, architecture shift, or unclear request.

1. Ask clarifying questions one at a time.
2. Invoke `brainstorming` to explore options, tradeoffs, and acceptance criteria.
3. Pick a verb-led `change-id` (kebab-case).
4. Create `openspec/changes/<change-id>/` with:
   - `proposal.md` (why/what/impact)
   - `tasks.md` (ordered checklist)
   - `specs/<capability>/spec.md` (delta requirements)
   - `design.md` only when cross-cutting, risky, or ambiguous
5. Write deltas using `## ADDED|MODIFIED|REMOVED|RENAMED Requirements` and at least one `#### Scenario:` per requirement.
6. Run `openspec validate <change-id> --strict --no-interactive`.
7. Present proposal/tasks/spec deltas to the user for review.
8. **Gate:** do NOT modify product code until the user replies exactly `Approved` (or a project-defined approval phrase).

## 2) Implementation Phase (Execution)
**Trigger:** proposal is approved and tasks exist.

1. Invoke `using-git-worktrees` to create a clean worktree for `<change-id>`.
2. Reload context: `proposal.md`, `tasks.md`, and spec deltas.
3. Execute tasks in order.
4. For each task:
   - If logic/algorithm heavy: invoke `test-driven-development` (red/green/refactor).
   - If simple wiring/UI/config: use direct implementation; optionally `subagent-driven-development`.
   - Run verification steps for the task.
   - Mark the task `[x]` in `tasks.md` only after verification passes.
5. If tests fail, invoke `systematic-debugging` before changing scope or design.
6. Avoid scope creep; update proposal/specs first if scope must change.

## 3) Archive Phase (Delivery)
**Trigger:** all tasks are `[x]` and verification passes.

1. Invoke `finishing-a-development-branch` for cleanup and final checks.
2. Run full verification (project test/lint commands).
3. Archive the change: `openspec archive <change-id> --yes`.
4. Run `openspec validate --strict --no-interactive`.

## Recovery / Resume
If interrupted, do NOT guess. Reconstruct from files:
1. `openspec list` to find active change.
2. `openspec show <change-id>` to reload proposal/tasks/spec deltas.
3. `openspec validate <change-id> --strict --no-interactive`.
4. Resume from the first unchecked task or re-request approval if not yet approved.

## Decision Logic
- No active change and new requirement -> Proposal Phase.
- Active change approved with pending tasks -> Implementation Phase.
- All tasks complete -> Archive Phase.
