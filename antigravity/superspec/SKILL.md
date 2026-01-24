---
name: superspec
description: "Orchestrator for OpenSpec-driven development. Use when starting a new change, implementing a plan, or achieving a feature."
---

# SuperSpec: The OpenSpec Orchestrator

This skill connects OpenSpec (Strategy/Outer Loop) with Superpowers (Execution/Inner Loop).

## 🟢 Phase 1: Proposal (Strategy)
**Trigger**: When the user says "I want to add feature X" or "Start a new change".

1. **Check Context**:
   - Run `openspec list` to check for active changes.
   - Run `openspec list --specs` to see existing capabilities.

2. **Scaffold**:
   - Ask for a unique `change-id` (verb-noun, kebab-case).
   - Create directory `openspec/changes/<change-id>/`.

3. **Brainstorm & Plan**:
   - **Invoke `brainstorming` skill**: Focus on "Why", "What", and "Impact".
   - **Invoke `writing-plans` skill**: Convert the brainstormed ideas into:
     - `openspec/changes/<change-id>/proposal.md`: SOURCE OF TRUTH for intent.
     - `openspec/changes/<change-id>/tasks.md`: SOURCE OF TRUTH for execution.
     - `openspec/changes/<change-id>/specs/<capability>/spec.md`: The Delta requirements.

4. **Validate**:
   - Run `openspec validate <change-id> --strict --no-interactive`.
   - Ask user to review and approve `proposal.md`.

---

## 🔵 Phase 2: Implementation (Execution)
**Trigger**: When `proposal.md` is approved and `tasks.md` exists.

1. **Setup**:
   - **Invoke `using-git-worktrees`**: Create a clean workspace for `<change-id>`.

2. **Loop (The Superpowers Cycle)**:
   - **Check State**: Read `openspec/changes/<change-id>/tasks.md` to identify the first unchecked Task.
   - **Context Loading**: Read `openspec/changes/<change-id>/proposal.md` and `specs/*.md` to refresh context.
   - **Resume**: If a task was partially started, check Git status to decide whether to continue or reset.
   - For each unchecked Task:
     - **Decision: TDD vs Direct?**
       - **IF** logic/algorithm heavy -> **Invoke `tdd` skill** (Red-Green-Refactor).
       - **IF** simple wiring/UI/config -> **Invoke `subagent-driven-development`**.
     - **Update Truth**: Mark task as `[x]` in `openspec/changes/<change-id>/tasks.md` immediately after verification.
     - **Invoke `systematic-debugging`**: If integration tests fail.
     - Mark task as `[x]` in `tasks.md`.

3. **Verify**:
   - Run full suite `npm test`.
   - Ensure all specs in `specs/` delta are satisfied.

---

## 🔴 Phase 3: Archive (Delivery)
**Trigger**: When all tasks in `tasks.md` are `[x]`.

1. **Final Polish**:
   - **Invoke `finishing-a-development-branch`**: Cleanup code, final lint.

2. **Merge Strategy**:
   - Run `openspec archive <change-id>`.
   - This moves the Change to `archive/` and merges Delta Specs into the main `specs/` directory.

3. **Commit**:
   - Commit the changes to Git.

---

## Decision Logic
- **IF** no active change -> Go to **Phase 1**.
- **IF** active change exists AND tasks pending -> Go to **Phase 2**.
- **IF** tasks complete -> Go to **Phase 3**.
