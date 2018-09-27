@echo off

call "%~dp0abspath.bat" "%~dp0..\.."
setlocal
    docker run --rm -v %AbsPath%:/local swaggerapi/swagger-codegen-cli %*
endlocal