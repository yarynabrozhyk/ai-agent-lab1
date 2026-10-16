---
name: github-actions
description: "Use when creating or verifying cross-platform GitHub Actions CI for a C++ CMake project on Windows, Linux, and macOS with script-based builds and artifacts."
---

# GitHub Actions

## When to use

Use this skill when the project needs reproducible CI for Windows, Ubuntu
Linux, and macOS, or when an existing workflow must be checked without moving
build logic into YAML.

## Required inputs

- Repository root and CMake project targets.
- Supported operating-system labels and runner architecture.
- Paths for `ci.sh`, `ci.bat`, and the workflow under `.github/workflows/`.
- Artifact names and the executable paths produced by each platform build.
- Permission to add or extend workflow files without removing existing jobs.

## Procedure

1. Inspect repository files, Git status, existing scripts, workflows, and
   executable naming conventions.
2. Create or safely extend `ci.sh` for Linux/macOS and `ci.bat` for Windows.
   Each script must configure an out-of-source CMake build, build the
   application and tests, run CTest, and leave executable output for upload.
3. Create or safely extend `ci.yml` with an operating-system matrix containing
   Windows, Ubuntu Linux, and macOS runners.
4. Make workflow steps invoke the platform script rather than duplicating the
   complete build logic in YAML. Keep YAML responsible for checkout,
   prerequisites, script invocation, artifact upload, and job reporting.
5. Configure artifact upload paths for the platform-specific executable and
   retain test failures as job failures.
6. Validate YAML structure, script syntax, executable permissions where
   applicable, and all referenced paths. Review the diff before reporting.

## Expected outputs

- `ci.sh` for Linux/macOS and `ci.bat` for Windows.
- `.github/workflows/ci.yml` with a three-platform matrix.
- Scripts that build the application, run tests, and produce executables.
- Workflow steps that invoke scripts and upload build artifacts.
- Verification evidence for workflow structure and referenced files.

## Verification and success criteria

- The matrix includes Windows, Ubuntu Linux, and macOS.
- Each matrix job invokes the correct script for its runner.
- The scripts configure, compile, run CTest, and produce the expected
  executable.
- Artifact upload paths match actual platform outputs.
- YAML and script validation succeeds; CI failures remain visible.
- If CI cannot be run locally, distinguish static validation from hosted-run
  verification and do not claim the hosted workflow passed.

## Example invocation

```text
Use github-actions to add script-driven CMake CI for Windows, Ubuntu, and
macOS, run tests in each script, upload the resulting executables, and verify
the workflow without overwriting existing automation.
```

## Typical errors and handling

- **Invalid YAML:** report the location and correct only the syntax or
  structure causing the failure.
- **Wrong shell or permissions:** use the platform-appropriate invocation and
  ensure ci.sh is executable on Unix runners.
- **Missing executable or artifact path:** inspect the CMake target output and
  update the path to match; do not upload arbitrary files.
- **Script test failure:** preserve the nonzero exit status so CI fails and
  report the command output.
- **Unavailable hosted-run validation:** perform static checks and local
  script checks where possible, clearly labeling what remains unverified.
- **Repeated execution:** extend existing workflows and scripts safely, never
  delete jobs or files, and avoid duplicate steps or artifact names.
