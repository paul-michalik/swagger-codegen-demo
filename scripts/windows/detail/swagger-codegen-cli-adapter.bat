@echo off

call "%~dp0abspath.bat" "%~dp0..\.."

setlocal
    set "ProjectName=%~1"
    set "DefFile=%~2"
    set "GenLang=%~3"
    call "%AbsPath%/scripts/windows/swagger-codegen-cli.bat" generate -i %DefFile% -l %GenLang% -o /local/gen/%ProjectName%/%GenLang%
endlocal