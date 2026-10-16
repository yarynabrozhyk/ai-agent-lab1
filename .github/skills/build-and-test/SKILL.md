---
name: build-and-test
description: "Use when configuring, compiling, and testing a C++ project with CMake, GoogleTest, and CTest, including the BasicAddition unit test."
---

# Build and Test

## When to use

Use this skill after project scaffolding, or when an existing C++ project needs
an out-of-source CMake build and verified GoogleTest/CTest coverage.

## Required inputs

- Repository root and source layout.
- C++ standard and target name, if different from the project defaults.
- Build directory that is outside source directories.
- Available CMake, C++ compiler, and GoogleTest acquisition strategy.

## Procedure

1. Inspect existing CMake files, source files, tests, Git status, and available
   build tools before editing.
2. Generate or safely extend `CMakeLists.txt` with the project declaration,
   C++ standard, Hello World executable, and test configuration.
3. Create a small addition function with a stable interface suitable for unit
   testing.
4. Create a GoogleTest test named `BasicAddition` that verifies the addition
   function with representative operands.
5. Integrate GoogleTest and register the test executable with CTest using
   `enable_testing()` and `add_test`.
6. Configure an out-of-source build, compile the application and test target,
   list tests, and run CTest with failure details.
7. Review the diff and preserve all unrelated user changes.

## Expected outputs

- A valid CMakeLists.txt.
- A simple addition implementation and a GoogleTest case named
  `BasicAddition`.
- A CTest registration for the test executable.
- A successful build directory containing the application and test executable.
- CMake and CTest output proving discovery and execution.

## Verification and success criteria

- CMake configuration exits successfully.
- The Hello World application and test target compile successfully.
- CTest discovers `BasicAddition`.
- CTest runs the test and reports passing results.
- The expected executable files exist in the build output.
- Report exact commands and results; never infer success from file presence
  alone.

## Example invocation

```text
Use build-and-test to configure an out-of-source CMake build, add the
BasicAddition GoogleTest, register it with CTest, and verify the build and test
results without deleting existing files.
```

## Typical errors and handling

- **CMake or compiler unavailable:** report the missing tool and stop before
  claiming a successful build.
- **GoogleTest download or discovery failure:** report the dependency error;
  use the repository's approved dependency method rather than silently
  substituting a different framework.
- **CMake configuration failure:** capture the relevant output, fix only the
  identified configuration issue, and reconfigure.
- **Test discovery or failure:** stop, report the failing test and output, and
  do not mark the build successful.
- **Existing CMake conflict:** extend compatible targets; ask before changing
  incompatible project behavior.
- **Repeated execution:** reuse or safely reconfigure the build directory and
  avoid deleting source files or unrelated build data.
