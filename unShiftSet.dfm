object fmShiftSet: TfmShiftSet
  Left = 450
  Top = 269
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1091#1095#1072#1089#1090#1082#1086#1074
  ClientHeight = 175
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 12
    Height = 18
    Caption = #1057
  end
  object Label2: TLabel
    Left = 112
    Top = 16
    Width = 17
    Height = 18
    Caption = #1087#1086
  end
  object DBLookupComboboxEh1: TDBLookupComboboxEh
    Left = 11
    Top = 47
    Width = 198
    Height = 25
    AutoSize = False
    Ctl3D = True
    ParentCtl3D = False
    DynProps = <>
    DataField = ''
    EditButtons = <>
    KeyField = 'Shift_ID'
    ListField = 'Shift_Name'
    ListSource = fmMain.dsShift
    TabOrder = 0
    Visible = True
  end
  object Edit1: TEdit
    Left = 32
    Top = 8
    Width = 73
    Height = 26
    TabOrder = 1
    Text = '1'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 136
    Top = 8
    Width = 73
    Height = 26
    TabOrder = 2
    Text = '1'
    OnKeyPress = Edit2KeyPress
  end
  object Button1: TButton
    Left = 16
    Top = 88
    Width = 193
    Height = 33
    Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 136
    Width = 193
    Height = 33
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 4
    OnClick = Button2Click
  end
end
