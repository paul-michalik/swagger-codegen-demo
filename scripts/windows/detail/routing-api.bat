@echo off

call "%~dp0abspath.bat" "%~dp0..\..\.."

setlocal
    call "%AbsPath%/scripts/windows/detail/swagger-codegen-cli.bat" -i "%AbsPath%/openapi/routing-api/v0/routing_service.yaml" -l cpprest -o "%AbsPath%/gen/cpprest/routing-api/v0"
endlocal