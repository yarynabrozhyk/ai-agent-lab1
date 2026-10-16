---
name: "git-init"
description: "Safely inspect or initialize Git for the project, update .gitignore without destroying existing rules, and report repository status."
argument-hint: "Check Git and prepare safe repository metadata"
agent: "Build Engineer"
tools: [read, search, edit, execute]
---

# Git Initialization

Follow the rules in the [Build Engineer agent](../agents/build-engineer.agent.md).

## Prerequisites

- Work from the repository root.
- Inspect the repository tree, `.git` state, existing `.gitignore`, and
  `git status`.
- Do not reset, rewrite, delete, or overwrite Git history.

## Actions

1. Determine whether the directory is already a Git repository.
2. If it is not, initialize Git without changing existing project files.
3. Create `.gitignore` if absent, or safely extend it if present, preserving
   all existing rules. Include CMake/build output and platform-generated files.
4. Display the final Git status and summarize every file changed by this
   prompt.

## Expected outputs

- A valid repository state, whether newly initialized or already present.
- A safe `.gitignore` containing relevant generated-output rules.
- Clear `git status` output and a concise change summary.

## Verification and error handling

- Verify `.git` and `.gitignore` state after the operation.
- Treat any Git command failure, unexpected file change, or permission error as
  a blocking error and report the command and output.
- Never hide errors, force-push, expose secrets, or claim success without the
  final status check.
- Repeated invocation must preserve history and avoid duplicate ignore rules.
