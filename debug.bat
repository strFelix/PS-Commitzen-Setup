@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0ps-commitzen-script.ps1"
if %errorlevel% neq 0 (
    echo Ocorreu um erro. Verifique o script.
    pause
)
