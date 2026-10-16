---
name: "create-project"
description: "Use the project-scaffold skill to create a safe, minimal cross-platform C++ Hello World application and documentation."
argument-hint: "Scaffold the C++ Hello World project"
agent: "Build Engineer"
tools: [read, search, edit, execute]
---

# Create Project

Follow the [Build Engineer agent](../agents/build-engineer.agent.md) and the
[project-scaffold skill](../skills/project-scaffold/SKILL.md).

## Prerequisites

- Confirm the repository root and inspect Git status.
- Confirm existing files will be preserved.
- Load and follow the complete project-scaffold skill.

## Actions

1. Apply the project-scaffold procedure.
2. Create the minimal cross-platform C++ Hello World structure, including
   `src/` and the application source entry point.
3. Prepare or safely extend README.md and `.gitignore`.
4. Do not create CMake, test, workflow, script, or build artifacts in this
   command.

## Expected outputs

- A `src/` directory and portable Hello World source file.
- README.md and `.gitignore` prepared without removing useful existing content.
- A report of files created or updated.

## Verification and error handling

- Verify the source file exists and contains the application entry point.
- Review `git diff` and `git status` for unrelated changes.
- Stop and report conflicts, permissions, or failed checks; do not silently
  recover or delete files.
- Repeated execution must verify compatible existing files and avoid duplicates.
