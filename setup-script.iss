[Setup]
AppName=Commitzen Setup
AppVersion=2.1
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
Filename: "{tmp}\debug.bat"; StatusMsg: "Executando script do PowerShell..."; Flags: shellexec runminimized

[Code]
const
  ProgressBarStep = 10;

var
  Progress: Integer;

procedure InitializeWizard;
begin
  Progress := 0;
  WizardForm.ProgressGauge.Position := 0;
  WizardForm.ProgressGauge.Style := npbstMarquee;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    WizardForm.ProgressGauge.Style := npbstNormal;
    while Progress < 100 do
    begin
      Sleep(500); // Ajuste o tempo conforme necessário
      Progress := Progress + ProgressBarStep;
      WizardForm.ProgressGauge.Position := Progress;
    end;
  end;
end;

procedure CurStepFinished(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    WizardForm.ProgressGauge.Position := 100;
  end;
end;

procedure DeinitializeSetup;
begin
end;
