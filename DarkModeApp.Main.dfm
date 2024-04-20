object FormWindowsSystemMode: TFormWindowsSystemMode
  Left = 0
  Top = 0
  Margins.Left = 7
  Margins.Top = 7
  Margins.Right = 7
  Margins.Bottom = 7
  Caption = 'FormWindowsSystemMode'
  ClientHeight = 1528
  ClientWidth = 1519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 216
  TextHeight = 37
  object Button1: TButton
    Left = 810
    Top = 18
    Width = 169
    Height = 56
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Caption = 'Button1'
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 18
    Top = 18
    Width = 272
    Height = 45
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    TabOrder = 1
    Text = 'Edit1'
  end
  object ComboBox1: TComboBox
    Left = 18
    Top = 126
    Width = 326
    Height = 45
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    TabOrder = 2
    Text = 'ComboBox1'
  end
  object ComboBoxEx1: TComboBoxEx
    Left = 18
    Top = 216
    Width = 326
    Height = 46
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    ItemsEx = <>
    ItemHeight = 40
    TabOrder = 3
    Text = 'ComboBoxEx1'
  end
  object ScrollBar1: TScrollBar
    Left = 1755
    Top = 18
    Width = 50
    Height = 848
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Kind = sbVertical
    PageSize = 0
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 18
    Top = 326
    Width = 524
    Height = 306
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object TreeView1: TTreeView
    Left = 578
    Top = 88
    Width = 381
    Height = 308
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Indent = 43
    TabOrder = 6
    Items.NodeData = {
      070300000009540054007200650065004E006F00640065002100000000000000
      00000000FFFFFFFFFFFFFFFF0000000000000000000000000001013100000021
      0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000000
      010132000000210000000000000000000000FFFFFFFFFFFFFFFF000000000000
      0000000000000001013300}
  end
  object ListView1: TListView
    Left = 18
    Top = 648
    Width = 524
    Height = 338
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Columns = <>
    Items.ItemData = {
      05640000000300000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
      0005480065006C006C006F0000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF
      00000000034F006E00650000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF00
      00000003540077006F00}
    TabOrder = 7
  end
  object ProgressBar1: TProgressBar
    Left = 578
    Top = 410
    Width = 381
    Height = 38
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Position = 50
    Smooth = True
    BarColor = clFuchsia
    BackgroundColor = clRed
    SmoothReverse = True
    TabOrder = 8
    StyleElements = []
  end
  object ToggleSwitch1: TToggleSwitch
    Left = 378
    Top = 18
    Width = 155
    Height = 45
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    SwitchHeight = 45
    SwitchWidth = 113
    TabOrder = 9
    ThumbWidth = 34
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 396
    Top = 126
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Animate = True
    IndicatorType = aitSectorRing
  end
  object CalendarView1: TCalendarView
    Left = 578
    Top = 538
    Width = 810
    Height = 448
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Date = 45019.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -45
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -29
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -45
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object NumberBox1: TNumberBox
    Left = 578
    Top = 461
    Width = 381
    Height = 45
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    TabOrder = 12
    Value = 15.000000000000000000
    SpinButtonOptions.ButtonWidth = 38
  end
  object CheckBox1: TCheckBox
    Left = 578
    Top = 18
    Width = 219
    Height = 38
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Caption = 'CheckBox1'
    TabOrder = 13
  end
  object RadioGroup1: TRadioGroup
    Left = 972
    Top = 88
    Width = 416
    Height = 236
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Caption = 'RadioGroup1'
    Columns = 2
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
    TabOrder = 14
  end
  object CheckListBox1: TCheckListBox
    Left = 972
    Top = 342
    Width = 416
    Height = 182
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Columns = 2
    ItemHeight = 38
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
    TabOrder = 15
  end
  object MainMenu1: TMainMenu
    Left = 456
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
      object N11: TMenuItem
        Caption = '1'
      end
      object N12: TMenuItem
        Caption = '2'
      end
      object N31: TMenuItem
        Caption = '3'
      end
      object N32: TMenuItem
        Caption = '4'
      end
      object N51: TMenuItem
        Caption = '5'
      end
      object N52: TMenuItem
        Caption = '6'
      end
      object N71: TMenuItem
        Caption = '7'
      end
    end
  end
end
