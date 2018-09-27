@echo off

setlocal
    call "%~dp0build.bat" %* || exit /b 1
    ( pushd "%BuildDir%" ^
    && call ctest --verbose --build-config %BuildType% ^
    && popd ) || exit /b 1
endlocal

