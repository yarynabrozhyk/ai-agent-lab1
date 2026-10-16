# Repository Copilot Instructions

## Repository context

This repository is Laboratory Work No. 1, Variant 1: a planned cross-platform
C++ project using CMake, GoogleTest/CTest, and GitHub Actions for Windows,
Linux, and macOS. The current implementation is the Copilot customization
layer and its documentation. The application source, `CMakeLists.txt`, tests,
CI scripts, workflow, and build output are not yet present.

## Build, test, and lint commands

The application has not been scaffolded in the current repository state, so
there is no runnable build, test, or lint command yet. Do not report planned
commands as executed results. No lint tool or lint configuration is currently
defined.

After the CMake project is generated, use an out-of-source build directory and
the corresponding commands (adjust `build` only if the generated project
documents a different directory):

```sh
cmake -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure
```

To run only the required CTest case:

```sh
ctest --test-dir build -R '^BasicAddition$' --output-on-failure
```

Before running the suite, verify discovery with `ctest --test-dir build -N`.
The required evidence is successful configuration, compilation of the Hello
World and test targets, discovery of `BasicAddition`, and a passing CTest run.

The planned CI scripts are `ci.sh` for Linux/macOS and `ci.bat` for Windows.
They must perform configuration, compilation, and CTest execution. The
workflow must invoke those scripts rather than duplicate their complete build
logic. Local/static workflow checks and hosted GitHub Actions results must be
reported separately.

## Architecture

The repository uses a layered VS Code Copilot customization workflow:

1. [`build-engineer.agent.md`](agents/build-engineer.agent.md) is the
   workspace custom agent. It defines the Build Engineer role, safety
   constraints, expected project outputs, and verification criteria.
2. The skills under [`skills/`](skills/) contain focused procedures:
   [`project-scaffold`](skills/project-scaffold/SKILL.md) creates the C++
   source and project documentation, [`build-and-test`](skills/build-and-test/SKILL.md)
   creates the CMake and GoogleTest/CTest build, and
   [`github-actions`](skills/github-actions/SKILL.md) creates script-driven
   cross-platform CI and artifact uploads.
3. The prompts under [`prompts/`](prompts/) expose those procedures as
   explicit VS Code commands. A prompt reference is instructional; it does
   not automatically execute another prompt.
4. [`init.prompt.md`](prompts/init.prompt.md) is the orchestrator. It explicitly
   follows the prompt procedures in this exact order:
   `git-init → create-project → create-build → create-actions → check`.
5. [`check.prompt.md`](prompts/check.prompt.md) is the final read-only
   verification step for customization files, generated project files, build,
   tests, CI, and Git status.

The design and operational details are documented in
[`docs/architecture.md`](../docs/architecture.md) and
[`docs/usage.md`](../docs/usage.md).

## Repository-specific conventions

- Keep workspace customizations in `.github/`: agents in `agents/`, skills in
  `skills/<name>/SKILL.md`, prompts in `prompts/*.prompt.md`, and always-on
  instructions in this file.
- Preserve the existing Markdown structure and use relative links when
  documenting repository files.
- Treat the Build Engineer manifest as the governing project-specific
  behavior. Follow its role, planned skills, command names, exact `init`
  order, and success criteria.
- Inspect the repository and `git status` before every edit. Preserve
  unrelated user changes and make focused updates.
- Repeated operations must extend or verify compatible files without creating
  duplicate steps, targets, ignore rules, or artifact names.
- Keep generated build output out of source directories and exclude it through
  `.gitignore`.
- Never delete existing files, reset or rewrite Git history, force-push, or
  perform destructive recovery.
- Never expose, print, store, or commit secrets, credentials, tokens, or
  private keys.
- Stop at the first required failure, show the command/path/relevant output,
  and do not use silent fallbacks or claim success from file presence alone.
- Distinguish planned or static validation from an actually executed local
  build/test and from a hosted CI result.

## Verification expectations

When implementation work is requested, success requires evidence that the
expected files exist, CMake configures out of source, the application and test
targets compile, CTest discovers and passes `BasicAddition`, and the CI
workflow contains Windows, Linux, and macOS jobs invoking the appropriate
scripts. Always report the final Git status and the checks actually performed.
