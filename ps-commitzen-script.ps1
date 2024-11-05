# Define a política de execução, suprimindo a saída
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue

# Função para verificar se um pacote está instalado
function Is-PackageInstalled {
    param (
        [string]$packageName
    )
    return (scoop list | Select-String $packageName) -ne $null
}

# Função para verificar se o Scoop está instalado
function Is-ScoopInstalled {
    return Test-Path "$env:USERPROFILE\scoop"
}

cls

# Instala o Scoop se não estiver instalado
if (-not (Is-ScoopInstalled)) {
    Write-Host "Instalando o Scoop..." -ForegroundColor Green
    try {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        # Write-Host "Scoop instalado com sucesso." -ForegroundColor Green
    } catch {
        Write-Host "Erro ao instalar o Scoop: $_" -ForegroundColor Red
    }
} else {
    cls
    Write-Host "Scoop ja esta instalado." -ForegroundColor Green
} 

# Função para instalar um pacote usando scoop
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

# Instala o Python se não estiver instalado
Install-Package "python" "`nInstalando o Python..." "Python ja esta instalado."

# Instala o pipx se não estiver instalado
Install-Package "pipx" "`nInstalando o pipx..." "Pipx ja esta instalado."

# Garante que o pipx esteja no PATH
Write-Host "`nConfigurando o pipx no PATH..." -ForegroundColor Green
pipx ensurepath

# Instala o commitizen se não estiver instalado
if (-not (pipx list | Select-String "commitizen")) {
    Write-Host "`nInstalando o commitizen..." -ForegroundColor Green
    pipx install commitizen
} else {
    Write-Host "`nCommitizen ja esta instalado." -ForegroundColor Green
}

# Atualiza o commitzen
Write-Host "`nAtualizando o commitizen..." -ForegroundColor Green
pipx upgrade commitizen

Write-Host "`nInstalacao concluida!" -ForegroundColor Green

# Aguarda 5 segundos antes de finalizar
# Read-Host -prompt "`nPressione Enter para finalizar..."
Write-Host "`nO script sera finalizado em 5 segundos..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
