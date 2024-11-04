# Define a política de execução, suprimindo a saída
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction SilentlyContinue

# Instala o Scoop
Write-Host "Instalando o Scoop..."
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Instala o pipx
Write-Host "Instalando o pipx..."
scoop install pipx

# Garante que o pipx esteja no PATH
Write-Host "Configurando o pipx no PATH..."
pipx ensurepath

# Instala o commitizen
Write-Host "Instalando o commitizen..."
pipx ensurepath
pipx install commitizen
pipx upgrade commitizen

Write-Host "Instalação concluída!"
