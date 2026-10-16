---
name: "init"
description: "Orchestrate complete Build Engineer setup in order: git-init, create-project, create-build, create-actions, then check."
argument-hint: "Initialize and verify the complete C++ CI/CD project"
agent: "Build Engineer"
tools: [read, search, edit, execute]
---

# Initialize Project

Follow the [Build Engineer agent](../agents/build-engineer.agent.md). This
orchestrator must explicitly follow the instructions in each referenced prompt
file; writing a slash command reference does not execute that command.

## Prerequisites

- Start at the repository root.
- Inspect Git status and preserve all existing work.
- Load the referenced prompt files and their linked skills before executing.

## Actions and exact order

Execute these prompt procedures sequentially, waiting for verification after
each one:

1. Follow [`git-init`](./git-init.prompt.md).
2. Follow [`create-project`](./create-project.prompt.md).
3. Follow [`create-build`](./create-build.prompt.md).
4. Follow [`create-actions`](./create-actions.prompt.md).
5. Follow [`check`](./check.prompt.md).

Do not invoke this `init` prompt recursively. Do not reorder, skip, or merge
steps. The `check` step remains read-only.

## Expected outputs

- A safely initialized Git repository and suitable `.gitignore`.
- A cross-platform C++ Hello World project.
- A verified CMake/GoogleTest/CTest build with `BasicAddition`.
- Script-driven Windows/Linux/macOS GitHub Actions CI with artifact uploads.
- Final read-only verification results and accurate Git status.

## Verification and error handling

- After every step, verify its expected outputs before starting the next.
- If a required step fails, stop immediately, clearly report the step,
  command, path, and relevant error output, and do not claim success.
- Never reset history, force-push, expose secrets, delete existing files, or
  perform destructive recovery.
- Repeated execution must reuse compatible files and avoid duplicate or
  destructive modifications.
- Report success only after all five steps and the final `check` verification
  pass.
