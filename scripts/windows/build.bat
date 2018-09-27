@echo off

setlocal
call "%~dp0configure.bat" %*
call cmake.exe --build "%BuildDir%" --config %BuildType%
endlocal & set "BuildDir=%BuildDir%" & set "BuildType=%BuildType%"

