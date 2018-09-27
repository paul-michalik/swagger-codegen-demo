@echo off

call "%~dp0path.bat" "%~dp0..\..\.."
setlocal
    docker run --rm -v %AbsPath%:%LocPath% swaggerapi/swagger-codegen-cli %*
endlocal