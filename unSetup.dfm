object fmSetup: TfmSetup
  Left = 508
  Top = 261
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 435
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 18
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 353
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 15
      Top = 27
      Width = 214
      Height = 143
      Caption = #1056#1077#1079#1077#1088#1074#1085#1072#1103' '#1082#1086#1087#1080#1103
      TabOrder = 0
      object Label1: TLabel
        Left = 20
        Top = 28
        Width = 96
        Height = 18
        Caption = 'M'#1072#1093' '#1082#1086#1083#1080'-'#1074#1086': '
      end
      object Button1: TButton
        Left = 20
        Top = 57
        Width = 174
        Height = 33
        Caption = #1057#1086#1079#1076#1072#1090#1100
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 20
        Top = 96
        Width = 173
        Height = 33
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
        TabOrder = 1
        OnClick = Button2Click
      end
      object Edit1: TEdit
        Left = 122
        Top = 25
        Width = 71
        Height = 26
        TabOrder = 2
        Text = '10'
        OnKeyPress = Edit1KeyPress
      end
    end
  end
  object OpenDialog1: TOpenDialog
    FileName = 
      'D:\_PROGRAMS\Delphi\DBAuto\DBAuto FDB+FireDAC\backup\BASE 2019-0' +
      '7-11 08-21-56.nbk'
    Filter = '*.nbk|*.nbk'
    Left = 280
    Top = 48
  end
end
