unit DarkModeApi.Menus;

interface

uses
  Winapi.Windows, Vcl.Menus;

type

  TMainMenu = class(Vcl.Menus.TMainMenu)
  protected
    FMenuInfo: TMenuInfo;
    function GetHandle: HMENU; override;
  public
    destructor Destroy; override;
  end;

  TMenuItem = class(Vcl.Menus.TMenuItem)
  protected
    FMenuInfo: TMenuInfo;
    procedure MenuChanged(Rebuild: Boolean); override;
  public
    destructor Destroy; override;
  end;

procedure FillMenuBkg(const AHandle: THandle; var vMenuInfo: TMenuInfo); overload;
procedure FillMenuBkg(const AMenu: TMenu; var vMenuInfo: TMenuInfo); overload;

implementation

uses
  DarkModeApi, DarkModeApi.Consts, DarkModeApi.Types;

procedure FillMenuBkg(const AHandle: THandle; var vMenuInfo: TMenuInfo);
begin
  vMenuInfo.cbSize  := SizeOf(TMenuInfo);
  vMenuInfo.fMask   := MIM_BACKGROUND or MIM_APPLYTOSUBMENUS or MIM_STYLE;
  if vMenuInfo.hbrBack <> Default(HBRUSH) then
    begin
      DeleteObject(vMenuInfo.hbrBack);
      vMenuInfo.hbrBack := Default(HBRUSH);
    end;
  if vMenuInfo.hbrBack = Default(HBRUSH) then
    vMenuInfo.hbrBack := CreateSolidBrush(InputBackColor);

  SetMenuInfo(AHandle, vMenuInfo);
end;

procedure FillMenuBkg(const AMenu: TMenu; var vMenuInfo: TMenuInfo);
begin
  if Assigned(AMenu) then
    SetMenuInfo(AMenu.Handle, vMenuInfo);
end;

procedure FillMenuBkg(const AMenuItem: TMenuItem; var vMenuInfo: TMenuInfo); overload;
begin
  if Assigned(AMenuItem) then
    SetMenuInfo(AMenuItem.Handle, vMenuInfo);
end;

{ TMainMenu }

destructor TMainMenu.Destroy;
begin
  inherited;
  DeleteObject(FMenuInfo.hbrBack);
end;

function TMainMenu.GetHandle: HMENU;
var
  Pref: UInt32;
begin
  Result := inherited;

//  if IsWindows10OrGreater then
//    begin
//      Pref := Ord(DWMWCP_ROUND);
//      DwmSetWindowAttribute(Result, DWMWA_WINDOW_CORNER_PREFERENCE, Pref, SizeOf(Pref));
//      FlushMenuThemes;
//
//      FMenuInfo.cyMax := 50;
//      FillMenuBkg(Result, FMenuInfo);
//    end;
end;

{ TMenuItem }

destructor TMenuItem.Destroy;
begin
  inherited;
  DeleteObject(FMenuInfo.hbrBack);
end;

procedure TMenuItem.MenuChanged(Rebuild: Boolean);
var
  Value: LongBool;
begin
  if ShouldAppsUseDarkMode then
    begin
      AllowDarkModeForApp(True);
      Value := True;
      DwmSetWindowAttribute(Handle, DWMWA_USE_IMMERSIVE_DARK_MODE, Value,
        SizeOf(Value));

      FillMenuBkg(Self, FMenuInfo);
    end;

  FlushMenuThemes;
  inherited;
end;

end.
