; Script de exemplo para Inno Setup
[Setup]
; Defina o nome do aplicativo e versão
AppName=Glide-Commitzen-Setup
AppVersion=1.0
DefaultDirName={pf}\ScoopPipxCommitizen
DefaultGroupName=ScoopPipxCommitizen

; Diretório de saída para o arquivo .exe gerado
OutputDir=.\setup
OutputBaseFilename=SetupScoopPipxCommitizen

; Crie um ícone no menu iniciar (opcional)
CreateAppDir=no

[Files]
; Adicione o script PowerShell (exemplo: install.ps1)
Source: ".\ps-commitzen-script.ps1"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; Executa o script PowerShell com uma barra de progresso durante a instalação
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{tmp}\ps-commitzen-script.ps1.ps1"""; Flags: waituntilterminated runascurrentuser; StatusMsg: "Instalando dependências, por favor aguarde..."
