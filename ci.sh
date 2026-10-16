#!/usr/bin/env bash
set -euo pipefail

build_dir="${BUILD_DIR:-build-ci}"

cmake -S . -B "$build_dir"
cmake --build "$build_dir" --parallel
ctest --test-dir "$build_dir" -N
ctest --test-dir "$build_dir" -R '^BasicAddition$' --output-on-failure
