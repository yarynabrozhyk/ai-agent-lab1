---
name: "create-actions"
description: "Use the github-actions skill to create script-driven CMake CI for Ubuntu, Windows, and macOS with tests and build artifacts."
argument-hint: "Create and validate cross-platform GitHub Actions CI"
agent: "Build Engineer"
tools: [read, search, edit, execute]
---

# Create Actions

Follow the [Build Engineer agent](../agents/build-engineer.agent.md) and the
[github-actions skill](../skills/github-actions/SKILL.md).

## Prerequisites

- Confirm the CMake project and test pass locally or record the blocking
  prerequisite.
- Inspect existing workflows, scripts, Git status, and executable paths.
- Load and follow the complete github-actions skill.

## Actions

1. Create or safely extend `ci.sh` for Linux/macOS and `ci.bat` for Windows.
2. Ensure each script configures and builds CMake, runs CTest, and produces
   executable output.
3. Create or safely extend `.github/workflows/ci.yml` with an
   `ubuntu-latest`, `windows-latest`, and `macos-latest` matrix.
4. Make workflow jobs invoke the platform-appropriate scripts rather than
   duplicating the complete build logic in YAML.
5. Upload the platform-specific executable artifacts.

## Expected outputs

- `ci.sh`, `ci.bat`, and a three-platform CI workflow.
- Script-driven build, test, executable generation, and artifact upload steps.
- Static validation results and any local workflow checks performed.

## Verification and error handling

- Verify matrix labels, script references, test execution, executable paths,
  and artifact paths.
- Preserve nonzero script and test exit codes so CI failures remain visible.
- Stop on invalid YAML, script errors, missing paths, or unexpected changes.
- Clearly distinguish static/local validation from a hosted GitHub run.
- Repeated runs must extend compatible automation without deleting jobs or
  creating duplicate steps.
