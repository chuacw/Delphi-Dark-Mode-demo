unit DarkModeApi.WinXCalendars;

interface

uses
  Vcl.WinXCalendars, Vcl.Controls;

type

  TCalendarView = class(Vcl.WinXCalendars.TCalendarView)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

implementation

uses
  Winapi.UxTheme, Winapi.Windows, DarkModeApi.Types,
  DarkModeApi,
  DarkModeApi.Consts;

{ TCalendarView }

procedure TCalendarView.CreateWindowHandle(const Params: TCreateParams);
var
  Value: BOOL;
begin
  inherited;
  if ShouldAppsUseDarkMode // and not TStyleManager.ActiveStyle.Enabled
    then
    begin
      Value := True;
      DwmSetWindowAttribute(Handle, ImmersiveDarkMode, Value,
        SizeOf(Value));
      SetWindowTheme(Handle, CModeExplorer, nil);
    end;
end;

end.
