# Build Engineer Architecture

## Purpose

This repository defines a workspace-scoped AI agent for Laboratory Work No. 1,
Variant 1. The target deliverable is a cross-platform C++ Hello World project
using CMake, GoogleTest/CTest, and GitHub Actions for Windows, Linux, and
macOS.

The repository contains the agent, skills, prompts, documentation, C++ source,
CMake files, GoogleTest/CTest test, CI scripts, and workflow. Build output is
generated out of source and remains excluded from version control.

## Components and responsibilities

### Build Engineer manifest

The [Build Engineer manifest](../.github/agents/build-engineer.agent.md)
defines the role, required outputs, safe editing rules, planned skills,
planned commands, orchestration order, error handling, and success criteria.
It is the governing project-specific instruction for the workflow.

### Skills

The three skills provide focused, reusable procedures:

- [`project-scaffold`](../.github/skills/project-scaffold/SKILL.md) handles the
  `src/` layout, Hello World entry point, README.md, and `.gitignore`.
- [`build-and-test`](../.github/skills/build-and-test/SKILL.md) handles
  CMakeLists.txt, the addition function, the `BasicAddition` GoogleTest, CTest
  registration, compilation, and test execution.
- [`github-actions`](../.github/skills/github-actions/SKILL.md) handles
  `ci.sh`, `ci.bat`, the operating-system matrix, workflow script invocation,
  and executable artifact uploads.

### Prompt commands

The six prompt files expose focused operations in VS Code:

- [`git-init`](../.github/prompts/git-init.prompt.md) prepares or checks Git.
- [`create-project`](../.github/prompts/create-project.prompt.md) follows the
  project-scaffold skill.
- [`create-build`](../.github/prompts/create-build.prompt.md) follows the
  build-and-test skill.
- [`create-actions`](../.github/prompts/create-actions.prompt.md) follows the
  github-actions skill.
- [`check`](../.github/prompts/check.prompt.md) performs read-only validation.
- [`init`](../.github/prompts/init.prompt.md) explicitly follows the other
  prompt procedures in sequence; a textual slash-command reference alone does
  not execute another prompt.

## Init orchestration sequence

The `init` orchestrator must execute and verify these steps in exactly this
order:

1. **git-init** - inspect the repository, safely initialize Git if needed,
   update `.gitignore`, and display status.
2. **create-project** - scaffold the C++ Hello World source structure.
3. **create-build** - configure CMake, add GoogleTest/CTest, build, and run
   `BasicAddition`.
4. **create-actions** - create platform-specific CI scripts and the
   Windows/Linux/macOS workflow with artifact uploads.
5. **check** - perform read-only structural, build, test, CI, and Git
   verification.

Each step is a prerequisite for the next. The orchestrator must stop
immediately when a required step fails and must not invoke itself recursively.

## Error handling

- Inspect Git status and relevant files before editing.
- Report command failures, missing tools, invalid configuration, failed tests,
  and unexpected changes explicitly with their paths and relevant output.
- Preserve existing files and user changes; do not silently overwrite,
  delete, or revert unrelated work.
- Do not use destructive recovery, reset history, rewrite history, or
  force-push.
- Retry only after a targeted, documented correction.
- Distinguish static or local validation from a hosted GitHub Actions result.
- Never substitute file existence for actual build or test evidence.

## Security rules

- Never expose, print, store, or commit secrets, credentials, tokens, or
  private key material.
- Use GitHub Actions secrets only by reference when a future implementation
  requires them.
- Do not force-push or perform destructive Git operations.
- Keep generated build output out of source directories and exclude it through
  `.gitignore`.

## Success criteria

The workflow may report success only after evidence confirms that:

1. Required project and customization files exist without deleting existing
   files.
2. CMake configures an out-of-source build successfully.
3. The Hello World and test targets compile.
4. CTest discovers and passes `BasicAddition`.
5. CI scripts build, test, and produce expected executables.
6. The workflow contains Windows, Linux, and macOS jobs, invokes the
   platform-appropriate scripts, and uploads the intended artifacts.
7. Final Git status and all verification output are reported accurately.

These criteria are defined now; they are not a claim that the application or
CI has already been generated or tested.
