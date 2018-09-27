@echo off

rem ==============================================
rem Convert given path to absolute path with Unix token separators
rem Set the name volume to which current directory is mapped to "/local" and export as "%LocPath%"
rem ==============================================

setlocal
pushd "%~1"
set "AbsPath=%cd%"
set "AbsPath=%AbsPath:\=/%"
popd
endlocal & set "AbsPath=%AbsPath%" & set "LocPath=/local"