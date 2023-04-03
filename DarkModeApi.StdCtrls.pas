unit DarkModeApi.StdCtrls;

interface

uses
  Vcl.Controls, Vcl.StdCtrls;

type

  TButton = class(Vcl.StdCtrls.TButton)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

  TCheckBox = class(Vcl.StdCtrls.TCheckBox)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

  TComboBox = class(Vcl.StdCtrls.TComboBox)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

  TEdit = class(Vcl.StdCtrls.TEdit)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

  TMemo = class(Vcl.StdCtrls.TMemo)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

  TRadioButton = class(Vcl.StdCtrls.TRadioButton)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

  TScrollBar = class(Vcl.StdCtrls.TScrollBar)
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  end;

implementation

uses
  Winapi.UxTheme, Vcl.Themes, DarkModeApi, DarkModeApi.Consts;

{ TButton }

procedure TButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and not IsStyleActive(Handle) then
    begin
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

{ TCheckBox }

procedure TCheckBox.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and not IsStyleActive(Handle) then
    begin
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

{ TComboBox }

procedure TComboBox.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and not IsStyleActive(Handle) then
    begin
      SetWindowTheme(Handle, CDarkModeControlCFD, nil);
    end;
end;

{ TEdit }

procedure TEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and not IsStyleActive(Handle) then
    begin
      SetWindowTheme(Handle, CDarkModeControlCFD, nil);
    end;
end;

{ TMemo }

procedure TMemo.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode then
    begin
      SetWindowTheme(Handle, CDarkModeControlCFD, nil);
    end;
end;

{ TRadioButton }

procedure TRadioButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and not IsStyleActive(Handle) then
    begin
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

{ TScrollBar }

procedure TScrollBar.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  if ShouldAppsUseDarkMode and IsStyleActive(Handle) then
    begin
      SetWindowTheme(Handle, CDarkModeExplorer, nil);
    end;
end;

end.
