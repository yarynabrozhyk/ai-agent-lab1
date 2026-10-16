# Laboratory Work No. 1: Designing an AI Agent for Development and CI/CD Automation

## Student information

- **Student name:** Yaryna Brozhyk
- **Academic group:** KI-409
- **Variant:** 1
- **Programming language:** C++
- **Build system:** CMake
- **Testing:** GoogleTest / CTest
- **Target operating systems:** Windows, Linux, and macOS

## Project description and purpose

This project defines an AI-assisted workflow for creating and verifying a
cross-platform C++ Hello World application. It includes the application
source, CMake build, `BasicAddition` GoogleTest unit test registered with CTest,
and script-driven GitHub Actions for Windows, Linux, and macOS.

## AI agent overview

The **Build Engineer** custom agent is a workspace-scoped VS Code agent defined
in [`.github/agents/build-engineer.agent.md`](.github/agents/build-engineer.agent.md).
It coordinates safe project creation and verification while preserving
existing files and Git history. The agent must stop when a required check
fails and must not claim success without evidence.

## Skills

The agent uses three reusable skills:

- [`project-scaffold`](.github/skills/project-scaffold/SKILL.md) - creates the
  portable C++ source structure, README.md, and `.gitignore`.
- [`build-and-test`](.github/skills/build-and-test/SKILL.md) - configures
  CMake, adds GoogleTest and CTest integration, and verifies `BasicAddition`.
- [`github-actions`](.github/skills/github-actions/SKILL.md) - creates
  script-driven CI for Windows, Linux, and macOS and uploads build artifacts.

## Prompt commands

The reusable commands are stored in [`.github/prompts/`](.github/prompts/):

- [`/git-init`](.github/prompts/git-init.prompt.md) - safely inspect or
  initialize Git and prepare `.gitignore`.
- [`/create-project`](.github/prompts/create-project.prompt.md) - invoke the
  project scaffolding procedure.
- [`/create-build`](.github/prompts/create-build.prompt.md) - create and verify
  the CMake and GoogleTest/CTest build.
- [`/create-actions`](.github/prompts/create-actions.prompt.md) - create and
  validate script-driven cross-platform GitHub Actions CI.
- [`/check`](.github/prompts/check.prompt.md) - perform read-only project and
  automation verification.
- [`/init`](.github/prompts/init.prompt.md) - orchestrate the complete sequence:
  `git-init → create-project → create-build → create-actions → check`.

## Selecting and invoking the Build Engineer

1. Open this repository in VS Code with GitHub Copilot Chat enabled.
2. Open the Chat view and select **Build Engineer** from the agent picker.
3. Start a Local Agent session, then type `/init` or choose `init` from the
   prompt list.
4. For read-only verification, invoke `/check` after the project has been
   generated.
5. Review each command's output and stop to investigate any reported failure.

For the detailed design, see [`docs/architecture.md`](docs/architecture.md).
For operational instructions, see [`docs/usage.md`](docs/usage.md).

## Build and test

Configure and build out of source with CMake:

```sh
cmake -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure
```

Run only the `BasicAddition` test with:

```sh
ctest --test-dir build -R '^BasicAddition$' --output-on-failure
```

The platform CI entry points are [`ci.sh`](ci.sh) and [`ci.bat`](ci.bat).
They configure, build, and test the project before the workflow uploads the
resulting Hello World executable.
