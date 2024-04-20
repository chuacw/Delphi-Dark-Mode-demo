unit DarkModeApi.CheckLst;

interface

uses
  Vcl.CheckLst, Vcl.Controls;

type

  TCheckListBox = class(Vcl.CheckLst.TCheckListBox)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

implementation

uses
  Winapi.UxTheme,
  DarkModeApi,
  DarkModeApi.Consts;


{ TCheckListBox }

procedure TCheckListBox.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode // and not TStyleManager.ActiveStyle.Enabled
    then
    begin
//      Value := True;
//      DwmSetWindowAttribute(Handle, ImmersiveDarkMode, Value,
//        SizeOf(Value));
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

end.
