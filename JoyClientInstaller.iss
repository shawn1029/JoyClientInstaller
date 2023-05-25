#define MyAppName "MyJoyClient Service"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher ""
#define MyAppURL ""
#define MyAppExeName "MyJoyClient.exe"

#define MyAppSourceDir "..\src_app"
#define MySetupResourceDir "..\setup_resources"


[Setup]
AppName={#MyAppName}
AppVerName={#MyAppName}
DefaultDirName={pf}\MyAppName

[Tasks]
;安裝NET 6環境
Name:"NET_6"; Description: "安裝.NET 6執行環境"
;安裝AnyDesk
Name:"AnyDesk"; Description: "安裝AnyDesk"
;安裝MyJoyClient Service
;安裝DeployAgent
;設定IP

[Files]
;Source: "MYPROG.EXE"; DestDir: "{app}"
;Filename: "{dotnet}"; Parameters: "publish MyService\MyService.dll"; WorkingDir: "{app}"; Flags: runhidden
;Filename: "{cmd}"; Parameters: "/C sc create MyService binPath= ""{app}\MyService\MyService.exe"""; Flags: runhidden

[Code]
var
  Checkbox: TNewCheckBox;

procedure InitializeWizard;
begin
  Checkbox := TNewCheckBox.Create(WizardForm);
  Checkbox.Parent := WizardForm;
  Checkbox.Left := ScaleX(16);
  Checkbox.Top := ScaleY(100);
  Checkbox.Caption := 'Install Option';

  // 可以将用户选择的值存储到一个安装过程中的变量中
  WizardForm.Values['InstallOption'] := '0';
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  // 用户点击 "下一步" 按钮时更新变量的值
  if CurPageID = wpSelectTasks then
  begin
    if Checkbox.Checked then
      WizardForm.Values['InstallOption'] := '1'
    else
      WizardForm.Values['InstallOption'] := '0';
  end;

  Result := True;
end;


function IsDotNet6Installed: Boolean;
var
  ResultCode: Integer;
begin
  // 检查 .NET 6 运行时是否已安装
  Exec('dotnet', '--version', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Result := (ResultCode = 0);
end;