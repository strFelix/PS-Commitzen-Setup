[Setup]
AppName=Commitzen Setup
AppVersion=2.2
DefaultDirName={pf}\PS-Commitzen-Setup
OutputDir=.\setup
OutputBaseFilename=setup
PrivilegesRequired=admin

[Files]
Source: "./ps-commitzen-script.ps1"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Code]
var
  StatusFile: String;
  StatusMsg: String;

function ReadStatusFile: String;
var
  FileStream: TFileStream;
  Buffer: AnsiString;
begin
  Result := '';
  if FileExists(StatusFile) then
  begin
    FileStream := TFileStream.Create(StatusFile, fmOpenRead or fmShareDenyWrite);
    try
      SetLength(Buffer, FileStream.Size);
      FileStream.Read(Buffer[1], FileStream.Size);
      Result := String(Buffer); // Converte para String
    finally
      FileStream.Free;
    end;
  end;
end;

procedure InitializeWizard;
begin
  StatusFile := ExpandConstant('{tmp}\install_progress.txt'); // Caminho do arquivo de status
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ScriptRunning: Boolean;
begin
  if CurStep = ssPostInstall then
  begin
    ScriptRunning := True;

    // Loop para atualizar a barra de status
    while ScriptRunning do
    begin
      StatusMsg := ReadStatusFile;
      if StatusMsg <> '' then
        WizardForm.StatusLabel.Caption := StatusMsg; // Atualiza o rótulo com a mensagem

      // Verifica se o script terminou, você pode ajustar a lógica aqui
      ScriptRunning := FileExists(StatusFile); // Continua enquanto o arquivo de status existe

      Sleep(1000); // Atualiza a cada segundo
    end;
  end;
end;

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{tmp}\ps-commitzen-script.ps1"""; Flags: waituntilterminated; StatusMsg: "Instalando dependências, por favor aguarde..."
