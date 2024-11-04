# Caminho para o arquivo de status (Inno Setup lerá este arquivo)
$statusFile = "$env:TEMP\install_progress.txt"

# Função para registrar status
function Update-Status {
    param (
        [string]$message
    )
    $message | Out-File -FilePath $statusFile -Encoding UTF8
    Start-Sleep -Seconds 1  # Pausa para garantir que o Inno Setup tenha tempo de ler a atualização
}

# Verifica se está sendo executado como administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Update-Status "Execute este script como administrador."
    Exit
}

# Instalação do Scoop
Update-Status "Instalando Scoop..."
$env:SCOOP='C:\scoop'  # Alterne este caminho se desejar instalar em outro diretório
if (-not (Test-Path -Path $env:SCOOP)) {
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Update-Status "Scoop instalado com sucesso."
} else {
    Update-Status "Scoop já está instalado."
}

# Adiciona buckets extras (opcional, caso precise de ferramentas específicas)
Update-Status "Adicionando buckets extras..."
scoop bucket add extras
scoop bucket add main
Update-Status "Buckets extras adicionados."

# Instalação do Python com Scoop (necessário para Pipx)
Update-Status "Instalando Python..."
scoop install python
Update-Status "Python instalado com sucesso."

# Instalação do Pipx
Update-Status "Instalando Pipx..."
if (-not (Get-Command pipx -ErrorAction SilentlyContinue)) {
    scoop install pipx
    pipx ensurepath
    # Adiciona o diretório pipx ao PATH
    $pipxPath = [System.Environment]::GetEnvironmentVariable("USERPROFILE") + "\.local\bin"
    [System.Environment]::SetEnvironmentVariable("Path", $pipxPath + ";" + $env:Path, [System.EnvironmentVariableTarget]::Machine)
    Update-Status "Pipx instalado com sucesso."
} else {
    Update-Status "Pipx já está instalado."
}

# Instalação do Commitizen
Update-Status "Instalando Commitizen..."
pipx ensurepath
pipx install commitizen
pipx upgrade commitizen
Update-Status "Commitizen instalado e atualizado."

Update-Status "Instalação concluída!"
Write-Host "Instalação concluída!"

# Mantenha o console aberto
Read-Host -Prompt "Pressione Enter para fechar o PowerShell"

# Remove o arquivo de status ao final para sinalizar a conclusão
Remove-Item $statusFile -ErrorAction SilentlyContinue
