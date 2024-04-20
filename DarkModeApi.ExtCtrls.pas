unit DarkModeApi.ExtCtrls;

interface

uses
  Vcl.ExtCtrls, Vcl.Controls;

type

  TRadioGroup = class(Vcl.ExtCtrls.TRadioGroup)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

implementation

uses
  Winapi.UxTheme,
  DarkModeApi,
  DarkModeApi.Consts;

{ TRadioGroup }

procedure TRadioGroup.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode // and not IsStyleActive(Handle)
    then
    begin
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

end.
