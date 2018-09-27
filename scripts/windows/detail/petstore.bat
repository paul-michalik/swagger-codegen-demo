@echo off

call "%~dp0path.bat" "%~dp0..\..\.."

setlocal
    call "%AbsPath%/scripts/windows/detail/swagger-codegen-cli.bat" generate -i "http://petstore.swagger.io/v2/swagger.json" -l cpprest -o "%LocPath%/gen/cpprest/petstore"
endlocal