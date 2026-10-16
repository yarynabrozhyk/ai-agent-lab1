# Build Engineer Usage

## Current state

The Build Engineer agent, its skills, and its prompt commands are available in
the repository. The C++ application, CMake configuration, tests, CI scripts,
workflow, and build output are not yet generated. The commands below describe
the planned workflow and must be validated when executed.

## Select the custom agent in VS Code

1. Open the repository folder in VS Code.
2. Open GitHub Copilot Chat.
3. Choose **Build Engineer** in the agent picker. It is defined by
   [`.github/agents/build-engineer.agent.md`](../.github/agents/build-engineer.agent.md).
4. Start a **Local Agent** session.
5. Confirm that the workspace is the intended repository before allowing file
   edits.

The agent is designed for explicit, safe project automation. It must preserve
existing files and stop when a required check fails.

## Invoke `/init`

In the Build Engineer Local Agent session:

1. Type `/init` in the chat input.
2. Select the `init` prompt from the prompt suggestions, or run it through
   **Chat: Run Prompt...**.
3. The orchestrator must explicitly follow these prompt procedures in order:
   `git-init → create-project → create-build → create-actions → check`.
4. Review the output after every step. If a required step fails, the workflow
   must stop and report the failing command, path, and relevant error.

The `/init` command has not been run for this project yet. Successful
generation, compilation, testing, and CI execution remain to be validated.

## Invoke `/check`

Use `/check` in a Build Engineer Local Agent session after project files have
been generated:

1. Type `/check` and select the `check` prompt.
2. Confirm that it is operating from the repository root.
3. Review its read-only checks for the agent, skills, prompts, source tree,
   CMake configuration, tests, scripts, workflow, and Git status.
4. Treat any failed required check as a failure; do not infer success from
   partial output.

`/check` is intended not to modify project files. Its results should clearly
separate static inspection, local build/test results, and hosted CI results.

## Planned CMake and CTest verification

When `/create-build` is executed, the planned validation is:

1. Configure an out-of-source CMake build directory.
2. Compile the Hello World application and GoogleTest target.
3. List or otherwise verify CTest discovery.
4. Run CTest and confirm that `BasicAddition` passes.
5. Confirm the expected executable files exist in the build output.

The exact generator, compiler, dependency acquisition method, build directory,
and command output depend on the target environment. No successful CMake,
compilation, or CTest result is claimed until the commands run and produce
evidence.

## Planned GitHub Actions verification

When `/create-actions` is executed, the planned validation is:

1. Confirm `ci.sh` and `ci.bat` configure and build with CMake.
2. Confirm both scripts run CTest and preserve failure exit codes.
3. Confirm `.github/workflows/ci.yml` defines an operating-system matrix with
   `ubuntu-latest`, `windows-latest`, and `macos-latest`.
4. Confirm each runner invokes the appropriate script rather than duplicating
   complete build logic in YAML.
5. Confirm artifact upload paths match the executables produced by each build.
6. Run available local syntax or script checks.
7. Review the hosted GitHub Actions run, if available, and report its actual
   status.

Static workflow inspection or local checks do not prove that hosted CI has
passed. A hosted result must be identified separately and must not be invented.

## Safety reminders

- Do not reset or rewrite Git history.
- Do not force-push or expose secrets.
- Do not delete existing files or hide errors.
- Repeated invocations should reuse compatible files and avoid duplicate or
  destructive modifications.
- Report success only after all required verification criteria pass.
