@echo off
setlocal

set "BUILD_DIR=%BUILD_DIR%"
if "%BUILD_DIR%"=="" set "BUILD_DIR=build-ci"

cmake -S . -B "%BUILD_DIR%" -G "Visual Studio 17 2022" -A x64
if errorlevel 1 exit /b %errorlevel%

cmake --build "%BUILD_DIR%" --config Release --parallel
if errorlevel 1 exit /b %errorlevel%

ctest --test-dir "%BUILD_DIR%" -C Release -N
if errorlevel 1 exit /b %errorlevel%

ctest --test-dir "%BUILD_DIR%" -C Release -R "^BasicAddition$" --output-on-failure
if errorlevel 1 exit /b %errorlevel%

exit /b 0
