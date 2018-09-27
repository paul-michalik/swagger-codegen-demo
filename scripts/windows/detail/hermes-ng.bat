@echo off

call "%~dp0abspath.bat" "%~dp0..\.."

setlocal
    call "%AbsPath%/scripts/windows/swagger-codegen-cli-adapter.bat" hermes-ng http://10.65.132.43:10100/v0/hermes.yaml cpprest
    call "%AbsPath%/scripts/windows/swagger-codegen-cli-adapter.bat" hermes-ng http://10.65.132.43:10100/v0/hermes.yaml go
    call "%AbsPath%/scripts/windows/swagger-codegen-cli-adapter.bat" hermes-ng http://10.65.132.43:10100/v0/hermes.yaml csharp-dotnet2
endlocal