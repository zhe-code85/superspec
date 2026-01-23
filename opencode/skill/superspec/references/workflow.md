# SuperSpec Detailed Workflow

## Phase 1: Initiation & Brainstorming

**Trigger**: User requests a new feature or project.

1.  **Context Check**:
    -   Is there an existing OpenSpec?
    -   If yes, prepare to update it.
    -   If no, prepare to scaffold a new one.

2.  **Superpowers Brainstorm (Requirement Decomposition)**:
    -   **Action**: Invoke `task(subagent_type="oracle")` with a "Brainstorming" persona.
    -   **Prompt**: "Act as `superpowers:brainstorm`. Analyze the user's request: '[User Request]'. Decompose this into: 1. Core user problems 2. Technical constraints 3. Potential edge cases 4. A list of atomic features. Summarize the requirements for an OpenSpec."
    -   **Goal**: Turn vague ideas into structured requirements *before* writing the spec.

3.  **Scaffold Proposal**:
    -   Use the output from the brainstorming session.
    -   Run `/openspec-proposal` to create the spec file (e.g., `specs/XXX-name.md`).
    -   Ensure the spec includes the `<!-- OPENSPEC -->` header.

## Phase 2: Superpowered Planning

**Goal**: Convert the structured requirements into a solid engineering plan.

1.  **Consult Oracle (Architecture)**:
    -   Invoke `oracle` to review the newly created Spec.
    -   *Prompt*: "Analyze this OpenSpec proposal. Identify architectural implications, security risks, and suggest a detailed testing strategy."
2.  **Update Spec**:
    -   Fill in the `## Implementation Plan` and `## Verification Plan` sections of the spec based on Oracle's advice.
3.  **User Approval**:
    -   **STOP**. Present the plan to the user.
    -   Do not write implementation code until the user approves the Spec/Plan.

## Phase 3: Execution (The Superpowers Loop)

**Goal**: Implement the plan with senior-level quality.

1.  **Todo Creation**:
    -   Create a detailed Todo list mapping 1:1 to the spec's implementation plan.
2.  **The Loop (Repeat for each task)**:
    -   **Implement**: Write the code/tests for the current task.
    -   **Verify (Self)**: Run linters, type checkers, and tests.
    -   **Review (Superpowers)**:
        -   **Action**: Invoke `task(subagent_type="superpowers:code-reviewer")`.
        -   *Prompt*: "I have implemented [Task X]. Please review the changes in [Files] against the OpenSpec requirements. Look for bugs, style violations, and potential regressions."
    -   **Fix**: Apply fixes suggested by the code reviewer.
    -   **Mark Complete**: Only when the reviewer approves and tests pass.

## Phase 4: Verification & Archival (The Verification Gate)

**Goal**: Prove it works before closing.

1.  **Mandatory Verification Gate**:
    -   **Run Full Suite**: Execute all relevant tests (`pytest`, `npm test`, etc.).
    -   **Check Diagnostics**: Run `lsp_diagnostics` on all modified files. Zero errors allowed.
    -   **Manual Verification**: If automated tests are insufficient, ask the user to manually verify critical paths or provide a script to demonstrate functionality.
    -   **STOP Condition**: If ANY check fails, go back to Phase 3.

2.  **Archive**:
    -   Only after the Verification Gate is passed.
    -   Run `/openspec-archive` to move the spec to the completed state.

3.  **Report**:
    -   Inform the user of success.
    -   Provide a summary of the work done and the verification results.
