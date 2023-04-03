unit DarkModeApi.ComCtrls;

interface

uses
  Vcl.Controls, Vcl.ComCtrls, Winapi.Messages;

type

  TComboBoxEx = class(Vcl.ComCtrls.TComboBoxEx)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

// The background is overwritten by the OS
//  TProgressBar = class(Vcl.ComCtrls.TProgressBar)
//  protected
//    procedure WMEraseBkGnd(var Message: TWmEraseBkgnd); Message WM_ERASEBKGND;
//  end;

implementation

uses
  Winapi.UxTheme, Vcl.Themes, DarkModeApi, DarkModeApi.Consts, Winapi.Windows,
  Winapi.CommCtrl;

{ TComboBoxEx }

procedure TComboBoxEx.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and not TStyleManager.ActiveStyle.Enabled then
    begin
//      Value := True;
//      DwmSetWindowAttribute(Handle, DWMWA_USE_IMMERSIVE_DARK_MODE, Value,
//        SizeOf(Value));
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

{ TProgressBar }

//procedure TProgressBar.WMEraseBkGnd(var Message: TWmEraseBkgnd);
//var
//  LBrush: HBRUSH;
//begin
//  LBrush := CreateSolidBrush(RGB(0, 0, 0));
//  FillRect(Message.DC, ClientRect, LBrush);
//  DeleteObject(LBrush);
//  Message.Result := 1;
//end;

end.
