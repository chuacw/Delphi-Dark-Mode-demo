unit DarkModeApp.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Winapi.UxTheme, Vcl.StdCtrls, Vcl.ComCtrls, DarkModeApi.Types,
  DarkModeApi.ComCtrls, Vcl.WinXCtrls, Vcl.NumberBox, Vcl.WinXCalendars,
  Vcl.CheckLst, Vcl.ExtCtrls;

type

  TFormWindowsSystemMode = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Button1: TButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBoxEx1: TComboBoxEx;
    ScrollBar1: TScrollBar;
    Memo1: TMemo;
    N11: TMenuItem;
    N12: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N71: TMenuItem;
    TreeView1: TTreeView;
    ListView1: TListView;
    ProgressBar1: TProgressBar;
    ToggleSwitch1: TToggleSwitch;
    ActivityIndicator1: TActivityIndicator;
    CalendarView1: TCalendarView;
    NumberBox1: TNumberBox;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
    CheckListBox1: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  protected
    FForceDarkMode: Boolean;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;

  { Private declarations }
  public
  { Public declarations }
    /// <summary> Set to true to force dark mode, or let it detect system
    /// preferences instead.
    /// </summary>
    property ForceDarkMode: Boolean read FForceDarkMode write FForceDarkMode;
  end;

var
  FormWindowsSystemMode: TFormWindowsSystemMode;

implementation

uses
  DarkModeApi.Consts, DarkModeApi;

{$R *.dfm}

{ TFormWindowsSystemMode }

procedure TFormWindowsSystemMode.CreateWindowHandle(
  const Params: TCreateParams);
begin
  inherited;

  var Value: LongBool := IsDarkMode or ForceDarkMode;
  if Value then
    begin
      DwmSetWindowAttribute(Handle, ImmersiveDarkMode, Value, SizeOf(Value));
      AllowDarkModeForWindow(Handle, Value);
      AllowDarkModeForApp(Value);
    end else
    begin
      DwmSetWindowAttribute(Handle, 0, @Value, SizeOf(Value));
    end;

//  if IsWindows10OrGreater(22000) then
//    begin
//      var Pref: UInt32 := Ord(FRound);
//      DarkModeApi.DwmSetWindowAttribute(Handle, DWMWA_WINDOW_CORNER_PREFERENCE, Pref,
//        SizeOf(Pref));
//    end;
end;

procedure TFormWindowsSystemMode.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormWindowsSystemMode.FormCreate(Sender: TObject);
var
  LEnableDarkMode: Boolean;
  Value: LongBool;
begin
  ForceDarkMode := True;
  LEnableDarkMode := IsDarkMode or ForceDarkMode;
  if LEnableDarkMode then
    begin
      Value := True;
      DwmSetWindowAttribute(Handle, ImmersiveDarkMode, Value,
        SizeOf(Value));

      AllowDarkModeForWindow(Handle, Value);
      AllowDarkModeForApp(Value);

      SetDarkMode(Self, IsDarkModeAllowedForWindow(Handle));

    end;
end;

procedure TFormWindowsSystemMode.WndProc(var Message: TMessage);
var
  LEnableDarkMode: Boolean;
begin
  LEnableDarkMode := IsDarkMode or ForceDarkMode;
  if LEnableDarkMode and
    UAHWndProc(Handle, Message.Msg, Message.WParam, Message.LParam, Message.Result) then
    begin
      Exit;
    end;
  inherited;
end;

end.
