---
name: project-scaffold
description: "Use when scaffolding or safely refreshing a minimal cross-platform C++ Hello World project, including src files, README.md, and .gitignore."
---

# Project Scaffold

## When to use

Use this skill when the Build Engineer must create the initial portable C++
application layout. It is responsible for project documentation and source
scaffolding only; use `build-and-test` for CMake and GoogleTest work.

## Required inputs

- Repository root.
- Application name and intended C++ standard, or the project defaults.
- Confirmation that existing files must be preserved.
- Optional existing README.md and .gitignore conventions to extend.

## Procedure

1. Inspect the repository tree, Git status, existing README.md, and
   .gitignore before editing.
2. Create `src/` only if it does not exist.
3. Add the minimal C++ application source with a clear `main` entry point that
   prints `Hello, World!` and returns success.
4. Prepare README.md with prerequisites, the project layout, and build/test
   pointers. Extend existing content instead of replacing it.
5. Prepare .gitignore with CMake and platform build outputs, while preserving
   existing ignore rules.
6. Review the diff and confirm that no unrelated files changed.

## Expected outputs

- `src/` exists.
- A source file under `src/` contains the application entry point and Hello
  World behavior.
- README.md documents the project without removing existing useful content.
- .gitignore excludes generated build output without ignoring source files.

## Verification and success criteria

- Confirm the source path exists and contains `main`.
- Confirm the application entry point is unique and returns a successful status.
- Confirm README.md and .gitignore are present and readable.
- Confirm Git status shows only intended scaffold changes.
- Do not claim success if any required path or verification check fails.

## Example invocation

```text
Use project-scaffold to create a minimal C++ Hello World scaffold in the
repository root, preserving all existing files and reporting the diff.
```

## Typical errors and handling

- **Existing source or documentation conflict:** inspect and extend it; stop
  for guidance if replacing content would be necessary.
- **Permission or path error:** report the exact path and stop.
- **Unexpected Git changes:** do not revert them; stop and ask for guidance.
- **Missing compiler:** scaffold files may still be prepared, but report that
  runtime compilation must be performed after a compiler is installed.
- **Repeated execution:** treat matching files as existing assets, verify them,
  and make only missing or explicitly requested updates. Never delete files.
