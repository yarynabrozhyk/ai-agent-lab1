---
name: "create-build"
description: "Use the build-and-test skill to configure CMake, add GoogleTest and CTest, and create and verify the BasicAddition unit test."
argument-hint: "Create and verify the CMake build and BasicAddition test"
agent: "Build Engineer"
tools: [read, search, edit, execute]
---

# Create Build

Follow the [Build Engineer agent](../agents/build-engineer.agent.md) and the
[build-and-test skill](../skills/build-and-test/SKILL.md).

## Prerequisites

- Confirm the project scaffold and Git status.
- Inspect available CMake, compiler, and GoogleTest dependency support.
- Load and follow the complete build-and-test skill.

## Actions

1. Generate or safely extend `CMakeLists.txt`.
2. Add a simple addition function.
3. Create a GoogleTest unit test named `BasicAddition`.
4. Integrate the test with CTest.
5. Configure and build out of source, then discover and run the tests.

## Expected outputs

- CMakeLists.txt with application and test targets.
- Addition implementation and `BasicAddition` GoogleTest source.
- CTest registration and a verified build directory.
- Exact configure, build, discovery, and test results.

## Verification and error handling

- Verify compilation succeeds and `BasicAddition` is discovered and passes.
- Verify expected application and test executables exist.
- Stop on missing tools, dependency errors, configuration failures, or test
  failures; report relevant output and do not claim success.
- Preserve existing compatible configuration and make repeated runs safe.
