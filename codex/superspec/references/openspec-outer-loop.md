# OpenSpec Outer Loop (Checklist)

## Pre-flight

- Read `openspec/AGENTS.md` for authoritative rules.
- Read `openspec/project.md` for project context (fill it in for new projects).
- Enumerate existing work:
  - `openspec list`
  - `openspec list --specs`
  - Optional full-text: `rg -n "### Requirement:|#### Scenario:" openspec/specs openspec/changes`

## Decide: New Change vs Bugfix

Create an OpenSpec change proposal for:
- New capability / new feature
- Requirements change (behavior change)
- Breaking change, architecture shift
- Security/performance work that changes behavior

Skip only for narrow bugfixes that restore intended behavior (still keep a test + minimal notes).

## Author a Change Proposal (Stage 1)

1. Choose a unique verb-led `change-id` (kebab-case): `add-...`, `update-...`, `remove-...`, `refactor-...`.
2. Scaffold the change folder:
   - `openspec/changes/<change-id>/proposal.md`
   - `openspec/changes/<change-id>/tasks.md`
   - `openspec/changes/<change-id>/design.md` (optional)
   - `openspec/changes/<change-id>/specs/<capability>/spec.md` (deltas)
3. Write deltas:
   - Use exactly one of:
     - `## ADDED Requirements`
     - `## MODIFIED Requirements`
     - `## REMOVED Requirements`
     - `## RENAMED Requirements`
   - Every `### Requirement:` MUST include at least one `#### Scenario:`.
4. Validate:
   - `openspec validate <change-id> --strict --no-interactive`
5. Approval gate:
   - Do not start implementation until the proposal is reviewed/approved (unless the user explicitly asks to proceed immediately).

## Implementation (Stage 2) — When Approved

- Implement tasks sequentially from `tasks.md`.
- Keep specs and tasks in sync: if behavior changes, update deltas first.
- At the end, update every checkbox in `tasks.md` to match reality.

