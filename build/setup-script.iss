[Setup]
AppName=Commitzen
AppVersion=3.3
DefaultDirName={userdocs}\commitzen
DefaultGroupName=Commitzen
OutputDir=../
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest
SetupIconFile=./icons/icon1.ico
ShowLanguageDialog=yes
WizardSmallImageFile=./icons/banner.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: "./ps-commitzen-script.ps1"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "./debug.bat"; DestDir: "{tmp}"; Flags: ignoreversion

[Run]
Filename: "{tmp}\debug.bat"; StatusMsg: "{code:GetStatusMsg}"; Flags: runminimized

[Code]
// Variaveis para as mensagens de status em ingles e portugues
var
  StatusMsgConfig: String;
  StatusMsgFinish: String;

procedure InitializeWizard;
begin
  // Define as mensagens com base no idioma escolhido
  if ActiveLanguage = 'english' then begin
    StatusMsgConfig := 'Setting up the development environment...';
    StatusMsgFinish := 'Completing the installation...';
  end
  else if ActiveLanguage = 'portuguese' then begin
    StatusMsgConfig := 'Configurando o ambiente de desenvolvimento...';
    StatusMsgFinish := 'Finalizando a instalação...';
  end;

  WizardForm.ProgressGauge.Style := npbstMarquee;
  WizardForm.ProgressGauge.Position := 0;
end;

// Funcao para definir a mensagem de status no run
function GetStatusMsg(Param: String): String;
begin
  Result := StatusMsgConfig;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    WizardForm.ProgressGauge.Style := npbstMarquee;
    WizardForm.StatusLabel.Caption := StatusMsgFinish;  // Mensagem de finalizacao
  end;
end;

procedure CurStepFinished(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    WizardForm.ProgressGauge.Style := npbstNormal;
    WizardForm.ProgressGauge.Position := 100;
  end;
end;
