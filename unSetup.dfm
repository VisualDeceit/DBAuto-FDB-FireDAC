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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 327
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 239
      Width = 92
      Height = 18
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086': '
    end
    object btReserv: TButton
      Left = 158
      Top = 259
      Width = 118
      Height = 35
      Caption = #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btReservClick
    end
    object Edit1: TEdit
      Left = 9
      Top = 263
      Width = 121
      Height = 26
      TabOrder = 1
      Text = '10'
      OnKeyPress = Edit1KeyPress
    end
    object RadioGroup1: TRadioGroup
      Left = 19
      Top = 160
      Width = 121
      Height = 73
      Caption = #1057#1086#1073#1099#1090#1080#1077
      ItemIndex = 0
      Items.Strings = (
        #1055#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
        #1055#1088#1080' '#1074#1099#1093#1086#1076#1077)
      TabOrder = 2
    end
    object GroupBox2: TGroupBox
      Left = 19
      Top = 25
      Width = 190
      Height = 120
      Caption = #1056#1077#1079#1077#1088#1074#1085#1072#1103' '#1082#1086#1087#1080#1103
      TabOrder = 3
      object Button1: TButton
        Left = 21
        Top = 32
        Width = 156
        Height = 33
        Caption = #1057#1086#1079#1076#1072#1090#1100
        TabOrder = 0
      end
      object Button2: TButton
        Left = 21
        Top = 71
        Width = 156
        Height = 33
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
        TabOrder = 1
      end
    end
  end
end
