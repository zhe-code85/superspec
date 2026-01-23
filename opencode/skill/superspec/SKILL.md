---
name: superspec
description: End-to-end workflow for new projects, features, or requirements. Combines strict OpenSpec lifecycle (Proposal -> Apply -> Archive) with Superpowers rigorous engineering (Brainstorm -> Oracle Planning -> Code Reviewer -> Verification Gate). Use this skill when the user asks to "start a new project", "add a new requirement", "implement a feature", or explicitly mentions "superspec".
---

# SuperSpec Workflow

This skill orchestrates a rigorous, professional engineering workflow that adheres to **OpenSpec** standards while leveraging **Superpowers** for quality assurance.

## Core Philosophy

1.  **Think Before You Act**: Use **Superpowers Brainstorming** to decompose vague requirements into concrete action items.
2.  **Spec First**: No code is written without an approved OpenSpec proposal.
3.  **Measure Twice**: Use `oracle` for architectural planning before implementation.
4.  **Review Loop**: Every logical unit of work must be reviewed by the `superpowers:code-reviewer` agent.
5.  **Verify to Complete**: Strict verification gate. Work is not done until it is proven to work.
6.  **Clean Finish**: Lifecycle is strictly managed via OpenSpec state transitions.

## Workflow Overview

1.  **Initiation**: Brainstorm and decompose requirements (`superpowers:brainstorm`).
2.  **Proposal**: Scaffold an OpenSpec proposal based on the brainstorm output.
3.  **Planning**: Fill the spec using high-level reasoning (`oracle`).
4.  **Execution**: Implement with continuous code review (`superpowers:code-reviewer`) and unit verification.
5.  **Completion**: **Mandatory Verification Gate** before Archiving.

## Detailed Instructions

For the detailed execution steps, see [WORKFLOW.md](references/workflow.md).

## Tools Used

-   **Superpowers**: 
    -   `task(subagent_type="oracle", prompt="Act as superpowers:brainstorm...")` for Requirement Decomposition
    -   `task(subagent_type="superpowers:code-reviewer")` for Code Quality
-   **OpenSpec**: `/openspec-proposal`, `/openspec-apply`, `/openspec-archive`
-   **Planning**: `task(subagent_type="oracle")`

## When to Stop

-   If the user rejects the proposal/plan: **Stop** and revise.
-   If `code-reviewer` finds critical issues: **Stop** and fix before proceeding.
-   If verification fails: **Stop**. Do not archive. Fix the issues.
