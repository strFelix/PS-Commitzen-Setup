# Define a politica de execucao
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue

function Is-PackageInstalled {
    param ([string]$packageName)
    return (scoop list | Select-String $packageName) -ne $null
}

function Is-ScoopInstalled {
    return Test-Path "$env:USERPROFILE\scoop"
}

cls

# Instala o Scoop se nao estiver instalado
if (-not (Is-ScoopInstalled)) {
    Write-Host "Instalando o Scoop..." -ForegroundColor Green
    try {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    } catch {
        Write-Host "Erro ao instalar o Scoop: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Scoop ja esta instalado." -ForegroundColor Green
}

function Install-Package {
    param (
        [string]$packageName,
        [string]$installMessage,
        [string]$alreadyInstalledMessage
    )

    if (-not (Is-PackageInstalled $packageName)) {
        Write-Host "$installMessage" -ForegroundColor Green
        scoop install $packageName
    } else {
        Write-Host "$alreadyInstalledMessage" -ForegroundColor Green
    }
}

Install-Package "python" "`nInstalando o Python..." "Python ja esta instalado."
Install-Package "pipx" "`nInstalando o pipx..." "Pipx ja esta instalado."

Write-Host "`nConfigurando o pipx no PATH..." -ForegroundColor Green
pipx ensurepath

if (-not (pipx list | Select-String "commitizen")) {
    Write-Host "`nInstalando o commitizen..." -ForegroundColor Green
    pipx install commitizen
} else {
    Write-Host "`nCommitizen ja esta instalado." -ForegroundColor Green
}

Write-Host "`nAtualizando o commitizen..." -ForegroundColor Green
pipx upgrade commitizen

Write-Host "`n--- Resumo da Instalacao ---" -ForegroundColor Cyan
Write-Host "Scoop: Instalado"
Write-Host "Python: Instalado"
Write-Host "Pipx: Instalado"
Write-Host "Commitizen: Instalado e atualizado" -ForegroundColor Cyan

Write-Host "`nInstalacao concluida!" -ForegroundColor Green
Write-Host "O script sera finalizado em 5 segundos..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
