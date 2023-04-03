program DarkModeApp;



uses
  Vcl.Forms,
  DarkModeApp.Main in 'DarkModeApp.Main.pas' {FormWindowsSystemMode},
  DarkModeApi in 'DarkModeApi.pas',
  DarkModeApi.Menus in 'DarkModeApi.Menus.pas',
  DarkModeApi.StdCtrls in 'DarkModeApi.StdCtrls.pas',
  DarkModeApi.ComCtrls in 'DarkModeApi.ComCtrls.pas',
  DarkModeApi.Consts in 'DarkModeApi.Consts.pas',
  DarkModeApi.Types in 'DarkModeApi.Types.pas',
  DarkModeApi.Messages in 'DarkModeApi.Messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormWindowsSystemMode, FormWindowsSystemMode);
  Application.Run;
end.
