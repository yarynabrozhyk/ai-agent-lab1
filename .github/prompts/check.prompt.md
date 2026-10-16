---
name: "check"
description: "Read-only verification of the Build Engineer project structure, customization files, CMake build, tests, CI scripts, workflow, and Git status."
argument-hint: "Run all project and automation checks without modifying files"
agent: "Build Engineer"
tools: [read, search, execute]
---

# Check

Follow the [Build Engineer agent](../agents/build-engineer.agent.md). This is
a read-only command and must not modify project files.

## Prerequisites

- Work from the repository root.
- Inspect the full project tree and Git status.
- Confirm required agent, skill, prompt, source, CMake, test, script, and
  workflow paths before running dependent checks.

## Actions

1. Validate the Build Engineer manifest and exactly three skill directories.
2. Validate all six prompt files and their references.
3. Validate the CMake configuration and out-of-source build.
4. Verify compilation, `BasicAddition` discovery, and CTest results.
5. Inspect `ci.sh`, `ci.bat`, and the workflow matrix, script invocations, and
   artifact uploads.
6. Display final Git status and report every check result.

## Expected outputs

- A pass/fail result for each structural, build, test, CI, and Git check.
- Relevant command output for failures.
- No changed files caused by this command.

## Verification and error handling

- Do not create, edit, delete, clean, or hide any project file.
- Treat any failed required check as a failure and stop dependent checks.
- Report exact paths, commands, and outputs; never substitute a success-shaped
  fallback or claim success without evidence.
- If a hosted GitHub run is unavailable, report local/static results separately.
