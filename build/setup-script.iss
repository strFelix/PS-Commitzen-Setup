[Setup]
AppName=Commitzen Installer
AppVersion=3.1
DefaultDirName={userdocs}\commitzen
DefaultGroupName=Commitzen
OutputDir=../
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest
SetupIconFile=./icons/icon1.ico

[Files]
Source: "./ps-commitzen-script.ps1"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "./debug.bat"; DestDir: "{tmp}"; Flags: ignoreversion

[Run]
Filename: "{tmp}\debug.bat"; StatusMsg: "Configurando o ambiente de desenvolvimento..."; Flags: runminimized

[Code]
procedure InitializeWizard;
begin
  WizardForm.ProgressGauge.Style := npbstMarquee;
  WizardForm.ProgressGauge.Position := 0;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    WizardForm.ProgressGauge.Style := npbstMarquee;
    WizardForm.StatusLabel.Caption := 'Finalizando a instalação...'; // Nova mensagem de status
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

procedure DeinitializeSetup;
begin
  // Ações adicionais podem ser adicionadas aqui, como ocultar a barra
end;
