@echo off

setlocal
call "%~dp0bootstrap.bat" %*

set "CMakeGeneratorName=Visual Studio 15 2017 Win64"

if "%Platform%"=="x86" (
    if "%Toolset%"=="v140" set "CMakeGeneratorName=Visual Studio 14 2015"
    if "%Toolset%"=="v141" set "CMakeGeneratorName=Visual Studio 15 2017"
)

if "%Platform%"=="x64" (
    if "%Toolset%"=="v140" set "CMakeGeneratorName=Visual Studio 14 2015 Win64"
    if "%Toolset%"=="v141" set "CMakeGeneratorName=Visual Studio 15 2017 Win64"
)


set "BuildDir=%~dp0..\..\products\cmake.msbuild.windows.%Platform%.%Toolset%"
set "InstallDir=%~dp0..\..\install\windows.%Platform%.%Toolset%"
if not exist "%BuildDir%" mkdir "%BuildDir%"
pushd "%BuildDir%"

call cmake.exe -G "%CMakeGeneratorName%" ^
-DCMAKE_INSTALL_PREFIX="%InstallDir%" ^
-DVCPKG_TARGET_TRIPLET=%VcPkgTriplet% ^
-DCMAKE_TOOLCHAIN_FILE="%VcPkgDir%\scripts\buildsystems\vcpkg.cmake" ^
"%~dp0..\.."


popd
endlocal & set "BuildDir=%BuildDir%" & set "BuildType=%BuildType%"