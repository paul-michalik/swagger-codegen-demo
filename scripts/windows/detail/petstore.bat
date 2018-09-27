@echo off

call "%~dp0abspath.bat" "%~dp0..\.."

setlocal
    call "%AbsPath%/scripts/windows/swagger-codegen-cli-adapter.bat" petstore http://petstore.swagger.io/v2/swagger.json cpprest
    call "%AbsPath%/scripts/windows/swagger-codegen-cli-adapter.bat" petstore http://petstore.swagger.io/v2/swagger.json go
    call "%AbsPath%/scripts/windows/swagger-codegen-cli-adapter.bat" petstore http://petstore.swagger.io/v2/swagger.json csharp-dotnet2
endlocal