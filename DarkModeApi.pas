UNIT DarkModeApi;

interface

// See also https://github.com/adzm/win32-custom-menubar-aero-theme

uses
  Winapi.Windows, Vcl.Forms, Vcl.Menus, DarkModeApi.Types;

function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD;
  pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall; overload;
function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: TDwmWindowAttribute;
  var pvAttribute; cbAttribute: DWORD): HResult; stdcall; overload;
function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: TDwmWindowAttribute;
  var pvAttribute: DWM_WINDOW_CORNER_PREFERENCE; cbAttribute: DWORD): HResult; stdcall; overload;

/// <summary> Enables dark context menus which change automatically depending on the theme.
/// </summary>
procedure AllowDarkModeForApp(allow: BOOL); stdcall;
function AllowDarkModeForWindow(hWnd: HWND; allow: Boolean): Boolean; stdcall;
function CheckBuildNumber(buildNumber: DWORD): Boolean;
function IsWindows10OrGreater(buildNumber: DWORD = 10000): Boolean;
function IsWindows11OrGreater(buildNumber: DWORD = 22000): Boolean;
procedure FlushMenuThemes; stdcall;
function IsDarkModeAllowedForWindow(hWnd: HWND): BOOL; stdcall;
function OpenNcThemeData(hWnd: HWND; pszClassList: LPCWSTR): THandle; stdcall;
procedure RefreshImmersiveColorPolicyState; stdcall;

procedure RefreshTitleBarThemeColor(hWnd: HWND);
function ShouldAppsUseDarkMode: BOOL; stdcall;
function ShouldSystemUseDarkMode: BOOL; stdcall;

function ImmersiveDarkMode: TDwmWindowAttribute;

/// <summary> Checks the system registry to see if Dark mode is enabled </summary>
function IsDarkMode: Boolean;

function IsStyleActive(AHandle: THandle): Boolean;

function UAHWndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM; var LR: LRESULT): BOOL; stdcall;

const
  LOAD_LIBRARY_SEARCH_SYSTEM32 = $00000800;

type

  TDarkMode = class
  protected
  class var
    FMenuInfo: TMenuInfo;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure FillMenuBkg(const AMenu: Vcl.Menus.TMenu); static;
  end;

function SetDarkMode(const AForm: TForm; const AValue: Bool = True): Boolean;

implementation

uses
  System.Classes, Vcl.Controls, System.UITypes, System.UIConsts,
  Winapi.UxTheme, Vcl.Themes, Winapi.Messages, System.Math, System.SysUtils,
  DarkModeApi.Consts, Vcl.StdCtrls, DarkModeApi.Menus,
  System.Win.Registry;

{$R DarkModeApi.res DarkModeApi.rc}

var
  _AllowDarkModeForApp: TAllowDarkModeForApp = nil;
  _AllowDarkModeForWindow: TAllowDarkModeForWindow = nil;
  _FlushMenuThemes: TFlushMenuThemes = nil;
  _GetIsImmersiveColorUsingHighContrast: TGetIsImmersiveColorUsingHighContrast = nil;
  _IsDarkModeAllowedForWindow: TIsDarkModeAllowedForWindow = nil;
  _OpenNcThemeData: TOpenNcThemeData = nil;
  _RefreshImmersiveColorPolicyState: TRefreshImmersiveColorPolicyState = nil;
  _SetPreferredAppMode: TSetPreferredAppMode = nil;
  _SetWindowCompositionAttribute: TSetWindowCompositionAttribute = nil;
  _ShouldAppsUseDarkMode: TShouldAppsUseDarkMode = nil;
  _ShouldSystemUseDarkMode: TShouldSystemUseDarkMode = nil;

  GDarkModeSupported: BOOL = False; // changed type to BOOL
  GDarkModeEnabled: BOOL = False;
  GUxTheme: HMODULE = 0;

function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD;
  pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall; overload; external Dwmapi name 'DwmSetWindowAttribute' delayed
function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: TDwmWindowAttribute;
  var pvAttribute: DWM_WINDOW_CORNER_PREFERENCE; cbAttribute: DWORD): HResult; stdcall; overload; external Dwmapi name 'DwmSetWindowAttribute' delayed

procedure AllowDarkModeForApp(allow: BOOL);
var
  LAppMode, LNewMode: PreferredAppMode;
begin
  if Assigned(_AllowDarkModeForApp) then
    _AllowDarkModeForApp(allow) else
  if Assigned(_SetPreferredAppMode) then
    begin
      if allow then
        LAppMode := PreferredAppMode.AllowDarkMode else
        LAppMode := PreferredAppMode.DefaultMode;
      LNewMode := _SetPreferredAppMode(LAppMode);
    end;
end;

function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: TDwmWindowAttribute;
  var pvAttribute; cbAttribute: DWORD): HResult;
begin
  Result := DwmSetWindowAttribute(hwnd, Ord(dwAttribute), @pvAttribute, cbAttribute);
end;

function IsDarkModeAllowedForWindow(hWnd: HWND): BOOL;
begin
  if Assigned(_IsDarkModeAllowedForWindow) then
    Result := _IsDarkModeAllowedForWindow(hWnd) else
    Result := False;
end;

function OpenNcThemeData(hWnd: HWND; pszClassList: LPCWSTR): THandle;
begin
  if pszClassList = 'SCROLLBAR' then
    begin
      hWnd := 0;
      pszClassList := 'Explorer::ScrollBar';
      Result := _OpenNcThemeData(hWnd, pszClassList);
    end else
    begin
      Result := _OpenNcThemeData(hWnd, pszClassList);
    end;
end;

procedure FixDarkScrollBar;
begin

end;

procedure FlushMenuThemes;
begin
  if Assigned(_FlushMenuThemes) then
    _FlushMenuThemes;
end;

function GetIsImmersiveColorUsingHighContrast(mode: IMMERSIVE_HC_CACHE_MODE): BOOL;
begin
  if Assigned(_GetIsImmersiveColorUsingHighContrast) then
    Result := _GetIsImmersiveColorUsingHighContrast(mode) else
    Result := False;
end;

function ImmersiveDarkMode: TDwmWindowAttribute;
begin
  Result := DWMWA_USE_IMMERSIVE_DARK_MODE_BEFORE_20H1;
  if IsWindows10OrGreater(18985) then
    Result := DWMWA_USE_IMMERSIVE_DARK_MODE
end;

procedure RefreshImmersiveColorPolicyState;
begin
  if Assigned(_RefreshImmersiveColorPolicyState) then
    _RefreshImmersiveColorPolicyState;
end;

function IsDarkMode: Boolean;
var
  LRegistry: TRegistry;
begin
  LRegistry := TRegistry.Create;
  try
    LRegistry.RootKey := HKEY_CURRENT_USER;
    LRegistry.OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize');
    Result := not LRegistry.ReadBool('AppsUseLightTheme');
  finally
    LRegistry.Free;
  end;
end;

function IsStyleActive(AHandle: THandle): Boolean;
var
  LTheme: HTHEME;
begin
  LTheme := GetWindowTheme(AHandle);
  Result := LTheme <> 0;
end;

function ShouldSystemUseDarkMode: BOOL;
begin
  Result := False;
  if Assigned(_ShouldSystemUseDarkMode) then
    Result := _ShouldSystemUseDarkMode;
end;

// See
// https://en.wikipedia.org/wiki/Windows_10_version_history
function CheckBuildNumber(buildNumber: DWORD): Boolean;
begin
  Result := IsWindows10OrGreater(20348) or
            IsWindows10OrGreater(19045) or  //
            IsWindows10OrGreater(19044) or  //
            IsWindows10OrGreater(19043) or  //
            IsWindows10OrGreater(19042) or  //
            IsWindows10OrGreater(19041) or  // 2004
            IsWindows10OrGreater(18363) or  // 1909
            IsWindows10OrGreater(18362) or  // 1903
            IsWindows10OrGreater(17763);    // 1809
end;

function IsWindows10OrGreater(buildNumber: DWORD): Boolean;
begin
  Result := (TOSVersion.Major > 10) or
            ((TOSVersion.Major = 10) and (TOSVersion.Minor = 0) and (DWORD(TOSVersion.Build) >= buildNumber));
end;

function IsWindows11OrGreater(buildNumber: DWORD): Boolean;
begin
  Result := IsWindows10OrGreater(22000) or IsWindows10OrGreater(buildNumber);
end;

function AllowDarkModeForWindow(hWnd: HWND; allow: Boolean): Boolean;
begin
  if GDarkModeSupported then
    Result := _AllowDarkModeForWindow(hWnd, allow) else
    Result := False;
end;

function IsHighContrast: Boolean;
var
  highContrast: HIGHCONTRASTW;
begin
  highContrast.cbSize := SizeOf(highContrast);
  if SystemParametersInfo(SPI_GETHIGHCONTRAST, SizeOf(highContrast), @highContrast, Ord(False)) then
    Result := highContrast.dwFlags and HCF_HIGHCONTRASTON <> 0
  else
    Result := False;
end;

procedure RefreshTitleBarThemeColor(hWnd: HWND);
var
  LUseDark: BOOL;
  LData: TWindowCompositionAttribData;
begin
  LUseDark := _IsDarkModeAllowedForWindow(hWnd) and _ShouldAppsUseDarkMode and not IsHighContrast;
  if TOSVersion.Build < 18362 then
    SetProp(hWnd, 'UseImmersiveDarkModeColors', THandle(LUseDark)) else
  if Assigned(_SetWindowCompositionAttribute) then
    begin
      LData.Attrib := WCA_USEDARKMODECOLORS;
      LData.pvData := @LUseDark;
      LData.cbData := SizeOf(LUseDark);
      _SetWindowCompositionAttribute(hWnd, @LData);
    end;
end;

function ShouldAppsUseDarkMode: BOOL;
begin
  Result := False;
  if Assigned(_ShouldAppsUseDarkMode) then
    Result := _ShouldAppsUseDarkMode;
end;

function IsColorSchemeChangeMessage(AlParam: LPARAM): Boolean; overload;
begin
  Result := False;
  if (AlParam <> 0) and (CompareStringOrdinal(PChar(AlParam), -1, 'ImmersiveColorSet', -1, True) = CSTR_EQUAL) then
  begin
    _RefreshImmersiveColorPolicyState;
    Result := True;
  end;
  _GetIsImmersiveColorUsingHighContrast(IHCM_REFRESH);
end;

function IsColorSchemeChangeMessage(message: UINT; AlParam: LPARAM): Boolean; overload;
begin
  if message = WM_SETTINGCHANGE then
    Result := IsColorSchemeChangeMessage(AlParam)
  else
    Result := False;
end;

var
  GMenuTheme: THandle;
  GMenuBarBackground: HBrush;

procedure UAHDrawMenuNCBottomLine(Handle: HWND);
var
  mbi: TMenuBarInfo;
  rcClient, rcWindow, rcBottomLine: TRect;
  DC: THandle;
begin
  mbi.cbSize := SizeOf(mbi);
  if not GetMenuBarInfo(Handle, Longint(OBJID_MENU), 0, mbi) then
    Exit;

  GetClientRect(Handle, rcClient);
  MapWindowPoints(Handle, 0, rcClient, 2);

  GetWindowRect(Handle, rcWindow);

//  OffsetRect(rcClient, -rcWindow.left, -rcWindow.top);
  rcClient.Offset(-rcWindow.left, -rcWindow.top);

// the rcBar is offset by the window rect
  rcBottomLine := rcClient;
  rcBottomLine.Bottom := rcBottomLine.Top;
  rcBottomLine.Top := rcBottomLine.Top - 1;

  DC := GetWindowDC(Handle);
  FillRect(DC, rcBottomLine, GMenuBarBackground);
  ReleaseDC(Handle, DC);
end;

function UAHWndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM; var LR: LRESULT): BOOL; stdcall;
var
  MessageData: record
  case Integer of
    WM_UAHDRAWMENU: (
      pUDM: PUahMenu;
      rc: TRect;
      mbi: TMenuBarInfo;
      rcWindow: TRect;
    );
    WM_UAHDRAWMENUITEM: (
      pUDMI: PUahDrawMenuItem;
      rc2: array[0..SizeOf(TRect)-1] of Byte;
      g_brItemBackground, g_brItemBackgroundHot, g_brItemBackgroundSelected: HBRUSH;
      pbrBackground: ^HBRUSH;
      menuString: array[0..255] of WideChar;
      mii: TMenuItemInfo;
      dwFlags: DWORD;
      iTextStateID, iBackgroundStateID: Integer;
      opts: DTTOPTS;
    );
    WM_UAHMEASUREMENUITEM: (
      pMmi: PUahMeasureMenuItem;
    );
  end;

begin
  FillChar(MessageData, SizeOf(MessageData), 0);

  case Msg of

    WM_UAHDRAWMENU: begin
      MessageData.pUDM := Pointer(lParam);
      MessageData.rc := Default(TRect);
      MessageData.mbi.cbSize := SizeOf(MessageData.mbi);
      GetMenuBarInfo(hWnd, Longint(OBJID_MENU), 0, MessageData.mbi);
      GetWindowRect(hWnd, MessageData.rcWindow);

      // the rcBar is offset by the window rect
      MessageData.rc := MessageData.mbi.rcBar;
      OffsetRect(MessageData.rc, -MessageData.rcWindow.Left, -MessageData.rcWindow.Top);
      FillRect(MessageData.pUDM.hdc, MessageData.rc, GMenuBarBackground);

      Result := True;
    end;

    WM_UAHDRAWMENUITEM: begin
      MessageData.pUDMI := PUahDrawMenuItem(lParam);

      // ugly colours for illustration purposes
      MessageData.g_brItemBackground := CreateSolidBrush(RGB($C0, $C0, $FF));
        // CreateSolidBrush(TAlphaColorRec.Antiquewhite and not TAlphaColorRec.Alpha);
      MessageData.g_brItemBackgroundHot := CreateSolidBrush(RGB($D0, $D0, $FF));
      MessageData.g_brItemBackgroundSelected := CreateSolidBrush(RGB($E0, $80, $FF));

      MessageData.pbrBackground := @MessageData.g_brItemBackground;

      // get the menu item string
      FillChar(MessageData.menuString, SizeOf(MessageData.menuString), 0);
      MessageData.mii.cbSize := SizeOf(MessageData.mii);
      MessageData.mii.fMask := MIIM_STRING;
      MessageData.mii.dwTypeData := @MessageData.menuString;
      MessageData.mii.cch := Length(MessageData.menuString) - 1;

      GetMenuItemInfo(MessageData.pUDMI.um.hmenu,
        MessageData.pUDMI.umi.iPosition, True, MessageData.mii);

      // get the item state for drawing
      MessageData.dwFlags := DT_CENTER or DT_SINGLELINE or DT_VCENTER;
      MessageData.iTextStateID := 0;
      MessageData.iBackgroundStateID := 0;

      if (MessageData.pUDMI.dis.itemState and ODS_INACTIVE <> 0) or
         (MessageData.pUDMI.dis.itemState and ODS_DEFAULT <> 0) then
        begin
          // normal display
          MessageData.iTextStateID := MPI_NORMAL;
          MessageData.iBackgroundStateID := MPI_NORMAL;
        end;

      if (MessageData.pUDMI.dis.itemState and ODS_HOTLIGHT <> 0) then
        begin
          // hot tracking
          MessageData.iTextStateID := MPI_HOT;
          MessageData.iBackgroundStateID := MPI_HOT;
          MessageData.pbrBackground := @MessageData.g_brItemBackgroundHot;
        end;

      if (MessageData.pUDMI.dis.itemState and ODS_SELECTED <> 0) then
        begin
          // clicked -- MENU_POPUPITEM has no state for this, though MENU_BARITEM does
          MessageData.iTextStateID := MPI_HOT;
          MessageData.iBackgroundStateID := MPI_HOT;
          MessageData.pbrBackground := @MessageData.g_brItemBackgroundSelected;
        end;

      if (MessageData.pUDMI.dis.itemState and ODS_GRAYED <> 0) or
         (MessageData.pUDMI.dis.itemState and ODS_DISABLED <> 0) then
        begin
          // disabled / grey text
          MessageData.iTextStateID := MPI_DISABLED;
          MessageData.iBackgroundStateID := MPI_DISABLED;
        end;

      if (MessageData.pUDMI.dis.itemState and ODS_NOACCEL <> 0) then
        MessageData.dwFlags := MessageData.dwFlags or DT_HIDEPREFIX;

      if GMenuTheme = 0 then
        GMenuTheme := OpenThemeData(hWnd, 'Menu');

      MessageData.opts.dwSize := SizeOf(MessageData.opts);
      MessageData.opts.dwFlags := DTT_TEXTCOLOR;
      MessageData.opts.crText := IfThen(MessageData.iTextStateID <> MPI_DISABLED,
        RGB($00, $00, $20), RGB($40, $40, $40));

      FillRect(MessageData.pUDMI^.um.hdc, MessageData.pUDMI^.dis.rcItem, MessageData.pbrBackground^);

      DrawThemeTextEx(GMenuTheme, MessageData.pUDMI^.um.hdc, MENU_BARITEM, MBI_NORMAL,
        MessageData.menuString, MessageData.mii.cch, MessageData.dwFlags,
        @MessageData.pUDMI^.dis.rcItem, MessageData.opts);

      DeleteObject(MessageData.g_brItemBackground);
      DeleteObject(MessageData.g_brItemBackgroundHot);
      DeleteObject(MessageData.g_brItemBackgroundSelected);

      Result := True;
    end;

    WM_UAHMEASUREMENUITEM: begin
      MessageData.pMmi := PUahMeasureMenuItem(lParam);

      // allow the default window procedure to handle the message
      // since we don't really care about changing the width
      LR := DefWindowProc(hWnd, msg, wParam, lParam);

      // but we can modify it here to make it 1/3rd wider for example
      MessageData.pMmi^.mis.itemWidth := (MessageData.pMmi^.mis.itemWidth * 4) div 3;

      Result := True;
    end;

    WM_THEMECHANGED: begin
      if (GMenuTheme <> 0) then
        begin
          CloseThemeData(GMenuTheme);
          GMenuTheme := 0;
        end;
      // continue processing in main wndproc
      Result := False;
    end;

    WM_NCPAINT,
    WM_NCACTIVATE: begin
      LR := DefWindowProc(hWnd, msg, wParam, lParam);
      UAHDrawMenuNCBottomLine(hWnd);
      Result := True;
    end;

  else
    Result := False;
  end;
end;

//procedure AllowDarkModeForApp(allow: BOOL);
//begin
//  if Assigned(_AllowDarkModeForApp) then
//    _AllowDarkModeForApp(allow) else
//  if Assigned(_SetPreferredAppMode) then
//    _SetPreferredAppMode(PreferredAppMode(IfThen(allow, Ord(AllowDarkMode), Ord(DefaultMode))));
//end;

var
  SaveInitProc: Pointer;

procedure InitDarkMode;
begin
  if SaveInitProc <> nil then
    TProcedure(SaveInitProc);

  GMenuBarBackground := // CreateSolidBrush(RGB($80, $80, $FF));
    CreateSolidBrush(RGB(0, 0, 0)); // Menu Bar background color

  if ((TOSVersion.Major = 10) and (TOSVersion.Minor = 0) and CheckBuildNumber(TOSVersion.Build)) then
    begin
      GUxTheme := LoadLibraryEx('uxtheme.dll', 0, LOAD_LIBRARY_SEARCH_SYSTEM32);
      if GUxTheme <> 0 then
        begin
          @_AllowDarkModeForWindow := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(133));
          @_FlushMenuThemes := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(136));
          @_GetIsImmersiveColorUsingHighContrast := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(106));
          @_IsDarkModeAllowedForWindow := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(137));
          @_OpenNcThemeData := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(49));
          @_RefreshImmersiveColorPolicyState := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(104));
          @_SetWindowCompositionAttribute := GetProcAddress(GetModuleHandle('user32.dll'), 'SetWindowCompositionAttribute');
          @_ShouldAppsUseDarkMode := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(132));

          var P := GetProcAddress(GUxTheme, MAKEINTRESOURCEA(135));
          if TOSVersion.Build < 18362 then
            @_AllowDarkModeForApp := P else
            @_SetPreferredAppMode := P;

          if Assigned(_OpenNcThemeData) and Assigned(_RefreshImmersiveColorPolicyState) and
            Assigned(_ShouldAppsUseDarkMode) and Assigned(_AllowDarkModeForWindow) and
            (Assigned(_AllowDarkModeForApp) or Assigned(_SetPreferredAppMode)) and
            Assigned(_IsDarkModeAllowedForWindow) then
            begin
              GDarkModeSupported := True;
              AllowDarkModeForApp(True);
              _RefreshImmersiveColorPolicyState;
              GDarkModeEnabled := ShouldAppsUseDarkMode and not IsHighContrast;
              FixDarkScrollBar;
            end;

        end;
    end;

//  if ShouldAppsUseDarkMode then
//    begin
//      if IsWindows11OrGreater then
//        TStyleManager.TrySetStyle('Windows11 Modern Dark') else
//      if IsWindows10OrGreater(10000) then
//        TStyleManager.TrySetStyle('Windows10 Dark');
//    end;
end;

procedure DoneDarkMode;
begin
  if GUxTheme <> 0 then
    FreeLibrary(GUxTheme);

  if GMenuTheme <> 0 then
    CloseThemeData(GMenuTheme);

  DeleteObject(GMenuBarBackground);
end;

type
  TWinControlHack = class(TWinControl);

function SetDarkMode(const AForm: TForm; const AValue: Bool): Boolean;
var
  Attr: TDwmWindowAttribute;
  C: TComponent;
  LValue: Bool;
begin
  Result := False;
  if not Assigned(AForm) then
    Exit;

  AllowDarkModeForApp(AValue);
  AllowDarkModeForWindow(AForm.Handle, AValue);
  RefreshImmersiveColorPolicyState;
  FlushMenuThemes;
  SetWindowTheme(AForm.Handle, CDarkModeExplorer, nil);

  if IsWindows10OrGreater(17763) then
    begin
      Attr := ImmersiveDarkMode;

      LValue := AValue;
      DwmSetWindowAttribute(AForm.Handle, Attr, LValue, SizeOf(AValue));
    end;

  AForm.Color      := BackColor;
  AForm.Font.Color := TextColor;

  for C in AForm do
    begin
      if C is TWinControl then
        begin
          if not TWinControlHack(C).ParentColor then
            begin
              TWinControlHack(C).Color := InputBackColor;
              TWinControlHack(C).ParentBackground := True;
            end;

          if C.InheritsFrom(TComboBox) or C.InheritsFrom(TEdit) or
             C.InheritsFrom(TMemo)  then
            SetWindowTheme(TWinControl(C).Handle, CDarkModeControlCFD, nil) else
            SetWindowTheme(TWinControl(C).Handle, CDarkModeExplorer, nil);
        end else
      if C is TMenu then
        TDarkMode.FillMenuBkg(TMenu(C));
    end;

  Result := True;
end;

{ TDarkMode }

class constructor TDarkMode.Create;
begin
  FMenuInfo := Default(TMenuInfo);
end;

class destructor TDarkMode.Destroy;
begin
  DeleteObject(FMenuInfo.hbrBack);
end;

class procedure TDarkMode.FillMenuBkg(const AMenu: TMenu);
begin
  DarkModeApi.Menus.FillMenuBkg(AMenu, FMenuInfo);
end;

initialization

  GMenuTheme := 0;
  GMenuBarBackground := 0;

if not IsLibrary then
  begin
    SaveInitProc := InitProc;
    InitProc := @InitDarkMode;
  end;

finalization
  DoneDarkMode;
end.

