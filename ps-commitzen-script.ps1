# Verifica se está sendo executado como administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Execute este script como administrador."
    Exit
}

# Instalação do Scoop
Write-Host "Instalando Scoop..."
$env:SCOOP='C:\scoop'  # Alterne este caminho se desejar instalar em outro diretório
if (-not (Test-Path -Path $env:SCOOP)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "Scoop já está instalado."
}

# Adiciona buckets extras (opcional, caso precise de ferramentas específicas)
scoop bucket add extras
scoop bucket add main

# Instalação do Python com Scoop (necessário para Pipx)
Write-Host "Instalando Python..."
scoop install python

# Instalação do Pipx
Write-Host "Instalando Pipx..."
if (-not (Get-Command pipx -ErrorAction SilentlyContinue)) {
    scoop install pipx
    pipx ensurepath
    # Adiciona o diretório pipx ao PATH
    $pipxPath = [System.Environment]::GetEnvironmentVariable("USERPROFILE") + "\.local\bin"
    [System.Environment]::SetEnvironmentVariable("Path", $pipxPath + ";" + $env:Path, [System.EnvironmentVariableTarget]::Machine)
} else {
    Write-Host "Pipx já está instalado."
}

# Instalação do Commitizen
Write-Host "Instalando Commitizen..."
pipx ensurepath
pipx install commitizen
pipx upgrade commitizen

Write-Host "Instalação concluída!"
