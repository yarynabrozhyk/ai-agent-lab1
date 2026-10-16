@echo off
setlocal

set "BUILD_DIR=%BUILD_DIR%"
if "%BUILD_DIR%"=="" set "BUILD_DIR=build-ci"

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" set "VSWHERE=%ProgramFiles%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
    echo Could not find vswhere.exe.
    exit /b 1
)

for /f "usebackq delims=" %%I in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationVersion`) do set "VS_VERSION=%%I"
if not defined VS_VERSION (
    echo Could not find a Visual Studio installation with C++ tools.
    exit /b 1
)

for /f "tokens=1 delims=." %%I in ("%VS_VERSION%") do set "VS_MAJOR=%%I"
if "%VS_MAJOR%"=="18" set "VS_GENERATOR=Visual Studio 18 2026"
if "%VS_MAJOR%"=="17" set "VS_GENERATOR=Visual Studio 17 2022"
if not defined VS_GENERATOR (
    echo Unsupported Visual Studio version: %VS_VERSION%
    exit /b 1
)

echo Using Visual Studio %VS_VERSION% with CMake generator "%VS_GENERATOR%".
cmake -S . -B "%BUILD_DIR%" -G "%VS_GENERATOR%" -A x64
if errorlevel 1 exit /b %errorlevel%

cmake --build "%BUILD_DIR%" --config Release --parallel
if errorlevel 1 exit /b %errorlevel%

ctest --test-dir "%BUILD_DIR%" -C Release -N
if errorlevel 1 exit /b %errorlevel%

ctest --test-dir "%BUILD_DIR%" -C Release -R "^BasicAddition$" --output-on-failure
if errorlevel 1 exit /b %errorlevel%

exit /b 0
