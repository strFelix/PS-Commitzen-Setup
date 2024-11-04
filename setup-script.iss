[Setup]
AppName=Commitzen
AppVersion=1.0
DefaultDirName={pf}\setup
DefaultGroupName=setup
OutputDir=.
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes

[Files]
Source: ".\ps-commitzen-script.ps1"; DestDir: "{app}"; Flags: ignoreversion

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\ps-commitzen-script.ps1"""; Flags: runhidden waituntilterminated

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    MsgBox('A instalação foi concluída com sucesso!', mbInformation, MB_OK);
  end;
end;
