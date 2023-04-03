object FormWindowsSystemMode: TFormWindowsSystemMode
  Left = 0
  Top = 0
  Caption = 'FormWindowsSystemMode'
  ClientHeight = 679
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Button1: TButton
    Left = 360
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'Edit1'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 56
    Width = 145
    Height = 23
    TabOrder = 2
    Text = 'ComboBox1'
  end
  object ComboBoxEx1: TComboBoxEx
    Left = 8
    Top = 96
    Width = 145
    Height = 24
    ItemsEx = <>
    TabOrder = 3
    Text = 'ComboBoxEx1'
  end
  object ScrollBar1: TScrollBar
    Left = 780
    Top = 8
    Width = 22
    Height = 377
    Kind = sbVertical
    PageSize = 0
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 8
    Top = 145
    Width = 233
    Height = 136
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object TreeView1: TTreeView
    Left = 257
    Top = 39
    Width = 169
    Height = 137
    Indent = 19
    TabOrder = 6
    Items.NodeData = {
      0303000000200000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000000000001013100200000000000000000000000FFFFFFFFFFFFFFFF000000
      00000000000000000001013200200000000000000000000000FFFFFFFFFFFFFF
      FF00000000000000000000000001013300}
  end
  object ListView1: TListView
    Left = 8
    Top = 288
    Width = 233
    Height = 150
    Columns = <>
    Items.ItemData = {
      05640000000300000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
      0005480065006C006C006F0000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF
      00000000034F006E00650000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF00
      00000003540077006F00}
    TabOrder = 7
  end
  object ProgressBar1: TProgressBar
    Left = 257
    Top = 182
    Width = 169
    Height = 17
    Position = 50
    Smooth = True
    BarColor = clFuchsia
    BackgroundColor = clRed
    SmoothReverse = True
    TabOrder = 8
    StyleElements = []
  end
  object ToggleSwitch1: TToggleSwitch
    Left = 168
    Top = 8
    Width = 73
    Height = 20
    TabOrder = 9
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 176
    Top = 56
    Animate = True
    IndicatorType = aitSectorRing
  end
  object CalendarView1: TCalendarView
    Left = 257
    Top = 239
    Width = 360
    Height = 199
    Date = 45019.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -13
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -20
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object NumberBox1: TNumberBox
    Left = 257
    Top = 205
    Width = 169
    Height = 23
    TabOrder = 12
    Value = 15.000000000000000000
  end
  object CheckBox1: TCheckBox
    Left = 257
    Top = 8
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 13
  end
  object RadioGroup1: TRadioGroup
    Left = 432
    Top = 39
    Width = 185
    Height = 105
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
    Left = 432
    Top = 152
    Width = 185
    Height = 81
    Columns = 2
    ItemHeight = 15
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
    Top = 40
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
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
