[Setup]
AppName=Commitzen
AppVersion=2.3
DefaultDirName={userdocs}\commitzen
DefaultGroupName=Commitzen
OutputDir=./setup
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest

[Files]
Source: "ps-commitzen-script.ps1"; DestDir: "{tmp}"; Flags: ignoreversion
Source: "debug.bat"; DestDir: "{tmp}"; Flags: ignoreversion

[Run]
Filename: "{tmp}\debug.bat"; StatusMsg: "Executando script do PowerShell..."; Flags: runminimized

[Code]
procedure InitializeWizard;
begin
  // Configura a barra de progresso para o estilo marquee (animação contínua)
  WizardForm.ProgressGauge.Style := npbstMarquee;
  WizardForm.ProgressGauge.Position := 0; // Certifique-se de que a posição começa em 0
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // A barra de progresso permanece em estilo marquee enquanto o script é executado
    WizardForm.ProgressGauge.Style := npbstMarquee;
  end;
end;

procedure CurStepFinished(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Para a barra de progresso ao terminar e define para 100%
    WizardForm.ProgressGauge.Style := npbstNormal;
    WizardForm.ProgressGauge.Position := 100;
  end;
end;

procedure DeinitializeSetup;
begin
  // Finaliza a barra de progresso
end;
