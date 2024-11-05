@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0ps-commitzen-script.ps1"
if %errorlevel% neq 0 (
    echo Um ou mais erros ocorreram durante a execução do script. Verifique as mensagens acima.
) else (
    echo Script executado com sucesso.
)
