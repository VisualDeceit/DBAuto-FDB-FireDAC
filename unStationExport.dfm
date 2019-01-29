object fmstationExport: TfmstationExport
  Left = 412
  Top = 357
  BorderStyle = bsToolWindow
  Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1087#1086' '#1087#1077#1088#1077#1075#1086#1085#1091
  ClientHeight = 91
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 151
    Top = 12
    Width = 40
    Height = 18
    Caption = '('#1082#1084'/'#1095')'
  end
  object Edit1: TEdit
    Left = 23
    Top = 8
    Width = 121
    Height = 26
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    Text = '120'
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 17
    Top = 48
    Width = 177
    Height = 33
    Caption = #1047#1072#1076#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
end
