# Define a política de execução
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Instala o Scoop
Write-Host "Instalando o Scoop..."
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Instala o pipx
Write-Host "Instalando o pipx..."
scoop install pipx

# Garante que o pipx esteja no PATH
Write-Host "Configurando o pipx no PATH..."
pipx ensurepath

# Instala o commitizen
Write-Host "Instalando o commitizen..."
pipx install commitizen

# Atualiza o commitizen para a versão mais recente
Write-Host "Atualizando o commitizen..."
pipx upgrade commitizen

Write-Host "Instalação concluída!"
