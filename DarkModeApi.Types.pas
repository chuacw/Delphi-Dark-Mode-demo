unit DarkModeApi.Types;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Winapi.Windows;

type

  TWinRoundType = (wrtDEFAULT = 0, wrtDONOTROUND = 1, wrtROUND = 2, wrtROUNDSMALL = 3);

  PLRESULT = ^LRESULT;

  TDwmWindowAttribute = (
    DWMWA_NCRENDERING_ENABLED = 1,
    DWMWA_NCRENDERING_POLICY,
    DWMWA_TRANSITIONS_FORCEDISABLED,
    DWMWA_ALLOW_NCPAINT,
    DWMWA_CAPTION_BUTTON_BOUNDS,
    DWMWA_NONCLIENT_RTL_LAYOUT,
    DWMWA_FORCE_ICONIC_REPRESENTATION,
    DWMWA_FLIP3D_POLICY,
    DWMWA_EXTENDED_FRAME_BOUNDS,
    DWMWA_HAS_ICONIC_BITMAP,
    DWMWA_DISALLOW_PEEK,
    DWMWA_EXCLUDED_FROM_PEEK,
    DWMWA_CLOAK,
    DWMWA_CLOAKED,
    DWMWA_FREEZE_REPRESENTATION,
    DWMWA_PASSIVE_UPDATE_MODE,
    DWMWA_USE_HOSTBACKDROPBRUSH,
    DWMWA_USE_IMMERSIVE_DARK_MODE_BEFORE_20H1 = 19,
    DWMWA_USE_IMMERSIVE_DARK_MODE = 20,
    DWMWA_WINDOW_CORNER_PREFERENCE = 33,
    DWMWA_BORDER_COLOR,
    DWMWA_CAPTION_COLOR,
    DWMWA_TEXT_COLOR,
    DWMWA_VISIBLE_FRAME_BORDER_THICKNESS,
    DWMWA_SYSTEMBACKDROP_TYPE,
    DWMWA_LAST
  );

  DWM_WINDOW_CORNER_PREFERENCE = (
    DWMWCP_DEFAULT      = 0,
    DWMWCP_DONOTROUND   = 1,
    DWMWCP_ROUND        = 2,
    DWMWCP_ROUNDSMALL   = 3
  );

  IMMERSIVE_HC_CACHE_MODE = (
    IHCM_USE_CACHED_VALUE,
    IHCM_REFRESH
  );

  PreferredAppMode = (
    DefaultMode,
    AllowDarkMode,
    ForceDarkMode,
    ForceLightMode,
    ModeMax
  );

  WINDOWCOMPOSITIONATTRIB = (
    WCA_UNDEFINED = 0,
    WCA_NCRENDERING_ENABLED = 1,
    WCA_NCRENDERING_POLICY = 2,
    WCA_TRANSITIONS_FORCEDISABLED = 3,
    WCA_ALLOW_NCPAINT = 4,
    WCA_CAPTION_BUTTON_BOUNDS = 5,
    WCA_NONCLIENT_RTL_LAYOUT = 6,
    WCA_FORCE_ICONIC_REPRESENTATION = 7,
    WCA_EXTENDED_FRAME_BOUNDS = 8,
    WCA_HAS_ICONIC_BITMAP = 9,
    WCA_THEME_ATTRIBUTES = 10,
    WCA_NCRENDERING_EXILED = 11,
    WCA_NCADORNMENTINFO = 12,
    WCA_EXCLUDED_FROM_LIVEPREVIEW = 13,
    WCA_VIDEO_OVERLAY_ACTIVE = 14,
    WCA_FORCE_ACTIVEWINDOW_APPEARANCE = 15,
    WCA_DISALLOW_PEEK = 16,
    WCA_CLOAK = 17,
    WCA_CLOAKED = 18,
    WCA_ACCENT_POLICY = 19,
    WCA_FREEZE_REPRESENTATION = 20,
    WCA_EVER_UNCLOAKED = 21,
    WCA_VISUAL_OWNER = 22,
    WCA_HOLOGRAPHIC = 23,
    WCA_EXCLUDED_FROM_DDA = 24,
    WCA_PASSIVEUPDATEMODE = 25,
    WCA_USEDARKMODECOLORS = 26,
    WCA_LAST = 27
  );
  TWindowCompositionAttrib = WINDOWCOMPOSITIONATTRIB;

  WINDOWCOMPOSITIONATTRIBDATA = record
    Attrib: TWindowCompositionAttrib;
    pvData: Pointer;
    cbData: SIZE_T;
  end;
  TWindowCompositionAttribData = WINDOWCOMPOSITIONATTRIBDATA;
  PWindowCompositionAttribData = ^TWindowCompositionAttribData;

  // describes the sizes of the menu bar or menu item
  tagUAHMENUITEMMETRICS = record
    case Integer of
      0: (
        rgsizeBar: array[0..1] of record
          cx, cy: DWORD;
        end;
      );
      1: (
        rgsizePopup: array[0..3] of record
          cx, cy: DWORD;
        end;
      );
  end;
  UAHMENUITEMMETRICS = tagUAHMENUITEMMETRICS;
  TUahMenuItemMetrics = UAHMENUITEMMETRICS;
  PUahMenuItemMetrics = ^TUahMenuItemMetrics;

  UAHMENUPOPUPMETRICS = record
    rgcx: array [0..3] of DWORD;
    fUpdateMaxWidths: DWORD; // 2 bits used, padded to full DWORD
  end;
  TUahMenuPopupMetrics = UAHMENUPOPUPMETRICS;
  PUahMenuPopupMetrics = ^TUahMenuPopupMetrics;

  UAHMENU = record
    hmenu: HMENU;
    hdc: HDC;
    dwFlags: DWORD; // no idea what these mean, it's either 0x00000a00 or sometimes 0x00000a10
  end;
  TUahMenu = UAHMENU;
  PUahMenu = ^TUahMenu;

  UAHMENUITEM = record
    iPosition: Integer; // 0-based position of menu item in menubar
    umim: TUahMenuItemMetrics;
    umpm: TUahMenuPopupMetrics;
  end;
  TUahMenuItem = UAHMENUITEM;
  PUahMenuItem = ^TUahMenuItem;

  UAHDRAWMENUITEM = record
    dis: TDrawItemStruct; // itemID looks uninitialized
    um: TUahMenu;
    umi: TUahMenuItem;
  end;
  TUahDrawMenuItem = UAHDRAWMENUITEM;
  PUahDrawMenuItem = ^TUahDrawMenuItem;

  UAHMEASUREMENUITEM = record
    mis: TMeasureItemStruct;
    um: TUahMenu;
    umi: TUahMenuItem;
  end;
  TUahMeasureMenuItem = UAHMEASUREMENUITEM;
  PUahMeasureMenuItem = ^TUahMeasureMenuItem;

  TRtlGetNtVersionNumbers = procedure(var major, minor, build: DWORD); stdcall;
  TSetWindowCompositionAttribute = function(hWnd: HWND; pData: PWindowCompositionAttribData): BOOL; stdcall;
  TShouldAppsUseDarkMode = function: BOOL; stdcall;
  TAllowDarkModeForWindow = function(hWnd: HWND; allow: BOOL): BOOL; stdcall;
  TAllowDarkModeForApp = function(allow: BOOL): BOOL; stdcall;
  TFlushMenuThemes = procedure; stdcall;
  TRefreshImmersiveColorPolicyState = procedure; stdcall;
  TIsDarkModeAllowedForWindow = function(hWnd: HWND): BOOL; stdcall;
  TGetIsImmersiveColorUsingHighContrast = function(mode: IMMERSIVE_HC_CACHE_MODE): BOOL; stdcall;
  TOpenNcThemeData = function(hWnd: HWND; pszClassList: LPCWSTR): THandle; stdcall;
  TShouldSystemUseDarkMode = function: BOOL; stdcall;
  TSetPreferredAppMode = function(appMode: PreferredAppMode): PreferredAppMode; stdcall;
  TIsDarkModeAllowedForApp = function: BOOL; stdcall;

implementation

end.
