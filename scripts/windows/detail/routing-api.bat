@echo off

call "%~dp0path.bat" "%~dp0..\..\.."

setlocal
    call "%AbsPath%/scripts/windows/detail/swagger-codegen-cli.bat" generate -i "%LocPath%/openapi/routing-api/v0/routing_service.yaml" -l cpprest -o "%LocPath%/gen/cpprest/routing-api/v0"
endlocal