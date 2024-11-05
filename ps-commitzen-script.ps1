# Define a política de execução, suprimindo a saída
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue

# Função para verificar se um pacote está instalado
function Is-PackageInstalled {
    param (
        [string]$packageName
    )
    return (scoop list | Select-String $packageName) -ne $null
}

# Instala o Scoop se não estiver instalado
if (-not (Is-PackageInstalled "scoop")) {
    cls
    Write-Host "Instalando o Scoop..." -ForegroundColor Green
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "Scoop já está instalado." -ForegroundColor Green
}

# Instala o Python se não estiver instalado
if (-not (Is-PackageInstalled "python")) {
    Write-Host "`Instalando o Python..." -ForegroundColor Green
    scoop install python
} else {
    Write-Host "`Python já está instalado." -ForegroundColor Green
}

# Instala o pipx se não estiver instalado
if (-not (Is-PackageInstalled "pipx")) {
    Write-Host "`Instalando o pipx..." -ForegroundColor Green
    scoop install pipx
} else {
    Write-Host "`npipx já está instalado." -ForegroundColor Green
}

# Garante que o pipx esteja no PATH
Write-Host "`nConfigurando o pipx no PATH..." -ForegroundColor Green
pipx ensurepath

# Instala o commitizen se não estiver instalado
if (-not (pipx list | Select-String "commitizen")) {
    Write-Host "`Instalando o commitizen..." -ForegroundColor Green
    pipx install commitizen
} else {
    Write-Host "`commitizen já está instalado." -ForegroundColor Green
}

# Atualiza o commitizen
Write-Host "`Atualizando o commitizen..." -ForegroundColor Green
pipx upgrade commitizen

Write-Host "`Instalacao concluida!" -ForegroundColor Green

# Espera por uma entrada do usuário antes de fechar
# Read-Host "Pressione Enter para sair..."
