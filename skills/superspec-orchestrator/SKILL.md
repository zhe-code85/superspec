---
name: superspec-orchestrator
description: Use when a user asks for a new project kickoff, a plan/proposal/spec (规划/提案/规格), a new feature, or a requirements change (需求变更) and you need a traceable OpenSpec outer loop plus a disciplined superpowers inner loop (TDD/debugging/verification) that leaves auditable docs.
---

# Superspec Orchestrator

## Overview

Use **OpenSpec as the outer loop** (spec-first change proposals + validation) and **superpowers skills as the inner loop** (disciplined execution per task). The output is a traceable set of artifacts (proposal/tasks/design/spec-deltas + validation notes) that supports ongoing requirement changes.

## Quick Start (Outer → Inner)

1. Bootstrap superpowers (once per session): run `~/.codex/superpowers/.codex/superpowers-codex bootstrap` and review the available skills list.
2. Load the minimum relevant skills for this request (examples below) using `~/.codex/superpowers/.codex/superpowers-codex use-skill <skill-name>`.
3. Run the **OpenSpec outer loop** to create/update a change proposal and validate it.
4. Execute each task using a **superpowers inner loop** skill (TDD for code, debugging for bugs, verification before completion).
5. Update `openspec/changes/<change-id>/tasks.md` so the checklist matches reality.

## Workflow Decision Tree

### Step 0: Classify the Request

Use OpenSpec (create a change proposal) if the request is any of:
- New project setup (new repo, new capability specs)
- New capability / feature (行为新增)
- Requirements change (行为变更 / 需求变更)
- Breaking change / architecture shift / performance or security work

Skip a proposal only for narrow bugfixes that restore intended behavior (and still keep a minimal trace: failing test first, fix, verify).

### Step 1 (Outer Loop): OpenSpec Change Creation

Minimum required artifacts (per change-id):
- `openspec/changes/<change-id>/proposal.md`
- `openspec/changes/<change-id>/tasks.md`
- `openspec/changes/<change-id>/design.md` (only if technical decisions need recording)
- `openspec/changes/<change-id>/specs/<capability>/spec.md` (deltas: ADDED/MODIFIED/REMOVED/RENAMED)

Core commands (run from repo root):
```bash
openspec list
openspec list --specs
openspec validate <change-id> --strict --no-interactive
```

Authoring rules that must be enforced:
- Every `### Requirement:` has at least one `#### Scenario:`
- Deltas use exactly one of: `## ADDED Requirements`, `## MODIFIED Requirements`, `## REMOVED Requirements`, `## RENAMED Requirements`
- Prefer editing an existing capability over inventing duplicates

Optional: use `scripts/new-openspec-change.ps1` in this skill to scaffold a change quickly when the `openspec` CLI isn't available.

### Step 2 (Inner Loop): Execute Each Task with a Superpowers Skill

Pick exactly one primary inner-loop skill per task:
- Ambiguous / many options → `superpowers:brainstorming` (then produce concrete tasks/spec deltas)
- Multi-step implementation checklist → `superpowers:writing-plans` (then `superpowers:executing-plans`)
- New feature or behavior change → `superpowers:test-driven-development`
- Bug / flaky behavior / hard-to-reproduce issue → `superpowers:systematic-debugging`
- Before final response / PR-ready state → `superpowers:verification-before-completion`

Inner-loop discipline:
- Always load the chosen superpowers skill *before* doing the work.
- Follow the skill’s checklists with `update_plan` items.
- Keep artifacts in sync: update `tasks.md` and add/adjust spec deltas as behavior changes.

### Step 3: Traceability (可追踪/可审计)

Use these conventions to keep work traceable across requirement changes:
- Name every change with a verb-led `change-id` (`add-...`, `update-...`, `refactor-...`).
- Keep a stable narrative in `proposal.md` (why/what/impact) and a checklist in `tasks.md`.
- Put decisions (tradeoffs, rejected options) into `design.md` when needed.
- Optional: add a lightweight execution log using `assets/templates/trace.md` (store in `docs/trace/<change-id>.md`).
- In git commits/PR titles, prefix with `<change-id>:` so history is searchable.

## Common Mistakes (and Fixes)

- Skipping `openspec validate` → Always run strict non-interactive validation for the change.
- Writing deltas without scenarios → Add at least one `#### Scenario:` per requirement.
- Implementing while the spec is vague → Stop and run `superpowers:brainstorming` to clarify.
- Mixing multiple inner-loop skills at once → Choose one primary skill per task; keep scope tight.

## Red Flags — STOP and Reset

- “This is small; we can skip spec/proposal.” (If behavior changes, spec it.)
- “I’ll add tests later.” (Use TDD for any new behavior.)
- “We already know what to build.” (If requirements are ambiguous, brainstorm first.)
- “We don’t need to validate.” (Validate changes strictly before sharing/merging.)

## Bundled Resources

### scripts/
- `scripts/new-openspec-change.ps1`: Scaffold an OpenSpec change folder with proposal/tasks/spec deltas.

### references/
- `references/openspec-outer-loop.md`: Detailed OpenSpec authoring rules and checklist.
- `references/superpowers-inner-loop.md`: Skill selection guide and discipline reminders.

### assets/
- `assets/templates/proposal.md`
- `assets/templates/tasks.md`
- `assets/templates/design.md`
- `assets/templates/trace.md`
