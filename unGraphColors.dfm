object fmGraphColors: TfmGraphColors
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 309
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 8
    Width = 28
    Height = 18
    Caption = #1060#1086#1085
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 100
    Top = 8
    Width = 41
    Height = 18
    Caption = #1059#1082#1083#1086#1085
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object pnl1: TPanel
    Left = 56
    Top = 5
    Width = 25
    Height = 25
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    OnClick = pnl1Click
  end
  object pnl6: TPanel
    Left = 148
    Top = 5
    Width = 25
    Height = 25
    Color = clOlive
    ParentBackground = False
    TabOrder = 1
    OnClick = pnl6Click
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 36
    Width = 153
    Height = 129
    Caption = #1054#1089#1100
    TabOrder = 2
    object lbl3: TLabel
      Left = 24
      Top = 75
      Width = 66
      Height = 15
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 52
      Top = 24
      Width = 36
      Height = 15
      Caption = #1051#1080#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 40
      Top = 49
      Width = 50
      Height = 15
      Caption = #1058#1086#1083#1097#1080#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 101
      Width = 81
      Height = 15
      Caption = #1042#1099#1089#1086#1090#1072' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object pnl2: TPanel
      Left = 94
      Top = 19
      Width = 43
      Height = 20
      Color = clCream
      ParentBackground = False
      TabOrder = 0
      OnClick = pnl2Click
    end
    object pnl3: TPanel
      Left = 97
      Top = 72
      Width = 40
      Height = 20
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      OnClick = pnl3Click
    end
    object Edit1: TEdit
      Left = 96
      Top = 45
      Width = 28
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 124
      Top = 45
      Width = 16
      Height = 21
      Associate = Edit1
      Min = 1
      Max = 5
      Position = 1
      TabOrder = 3
      OnChangingEx = UpDown1ChangingEx
    end
    object Edit2: TEdit
      Left = 96
      Top = 98
      Width = 28
      Height = 21
      TabOrder = 4
      Text = '14'
    end
    object UpDown2: TUpDown
      Left = 124
      Top = 98
      Width = 16
      Height = 21
      Associate = Edit2
      Min = 9
      Max = 20
      Position = 14
      TabOrder = 5
      OnChangingEx = UpDown2ChangingEx
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 171
    Width = 153
    Height = 129
    Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077
    TabOrder = 3
    object Label3: TLabel
      Left = 24
      Top = 75
      Width = 66
      Height = 15
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 52
      Top = 24
      Width = 36
      Height = 15
      Caption = #1051#1080#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 40
      Top = 49
      Width = 50
      Height = 15
      Caption = #1058#1086#1083#1097#1080#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 9
      Top = 101
      Width = 81
      Height = 15
      Caption = #1042#1099#1089#1086#1090#1072' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Edit3: TEdit
      Left = 96
      Top = 45
      Width = 28
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object UpDown3: TUpDown
      Left = 124
      Top = 45
      Width = 16
      Height = 21
      Associate = Edit3
      Min = 1
      Max = 5
      Position = 1
      TabOrder = 1
      OnChangingEx = UpDown3ChangingEx
    end
    object Edit4: TEdit
      Left = 96
      Top = 98
      Width = 28
      Height = 21
      TabOrder = 2
      Text = '14'
    end
    object UpDown4: TUpDown
      Left = 124
      Top = 98
      Width = 16
      Height = 21
      Associate = Edit4
      Min = 9
      Max = 20
      Position = 14
      TabOrder = 3
      OnChangingEx = UpDown4ChangingEx
    end
    object pnl4: TPanel
      Left = 94
      Top = 20
      Width = 43
      Height = 19
      Color = clRed
      ParentBackground = False
      TabOrder = 4
      OnClick = pnl4Click
    end
    object pnl5: TPanel
      Left = 96
      Top = 72
      Width = 41
      Height = 20
      Color = clRed
      ParentBackground = False
      TabOrder = 5
      OnClick = pnl5Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 176
    Top = 36
    Width = 153
    Height = 129
    Caption = #1057#1090#1072#1085#1094#1080#1103
    TabOrder = 4
    object Label7: TLabel
      Left = 24
      Top = 75
      Width = 66
      Height = 15
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 52
      Top = 24
      Width = 36
      Height = 15
      Caption = #1051#1080#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 40
      Top = 49
      Width = 50
      Height = 15
      Caption = #1058#1086#1083#1097#1080#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 9
      Top = 101
      Width = 81
      Height = 15
      Caption = #1042#1099#1089#1086#1090#1072' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Edit5: TEdit
      Left = 96
      Top = 45
      Width = 28
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object UpDown5: TUpDown
      Left = 124
      Top = 45
      Width = 16
      Height = 21
      Associate = Edit5
      Min = 1
      Max = 5
      Position = 1
      TabOrder = 1
      OnChangingEx = UpDown5ChangingEx
    end
    object Edit6: TEdit
      Left = 96
      Top = 98
      Width = 28
      Height = 21
      TabOrder = 2
      Text = '14'
    end
    object UpDown6: TUpDown
      Left = 124
      Top = 98
      Width = 16
      Height = 21
      Associate = Edit6
      Min = 9
      Max = 20
      Position = 14
      TabOrder = 3
      OnChangingEx = UpDown6ChangingEx
    end
    object pnl7: TPanel
      Left = 94
      Top = 19
      Width = 43
      Height = 20
      Color = clLime
      ParentBackground = False
      TabOrder = 4
      OnClick = pnl7Click
    end
    object pnl8: TPanel
      Left = 96
      Top = 70
      Width = 42
      Height = 20
      Color = clLime
      ParentBackground = False
      TabOrder = 5
      OnClick = pnl8Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 176
    Top = 171
    Width = 153
    Height = 129
    Caption = #1057#1074#1077#1090#1086#1092#1086#1088
    TabOrder = 5
    object Label11: TLabel
      Left = 24
      Top = 75
      Width = 66
      Height = 15
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 52
      Top = 24
      Width = 36
      Height = 15
      Caption = #1051#1080#1085#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 40
      Top = 49
      Width = 50
      Height = 15
      Caption = #1058#1086#1083#1097#1080#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 9
      Top = 101
      Width = 81
      Height = 15
      Caption = #1042#1099#1089#1086#1090#1072' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Edit7: TEdit
      Left = 96
      Top = 45
      Width = 28
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object UpDown7: TUpDown
      Left = 124
      Top = 45
      Width = 16
      Height = 21
      Associate = Edit7
      Min = 1
      Max = 5
      Position = 1
      TabOrder = 1
      OnChangingEx = UpDown7ChangingEx
    end
    object Edit8: TEdit
      Left = 96
      Top = 98
      Width = 28
      Height = 21
      TabOrder = 2
      Text = '14'
    end
    object UpDown8: TUpDown
      Left = 124
      Top = 98
      Width = 16
      Height = 21
      Associate = Edit8
      Min = 9
      Max = 20
      Position = 14
      TabOrder = 3
      OnChangingEx = UpDown8ChangingEx
    end
    object pnl9: TPanel
      Left = 94
      Top = 19
      Width = 43
      Height = 20
      Color = clTeal
      ParentBackground = False
      TabOrder = 4
      OnClick = pnl9Click
    end
    object pnl10: TPanel
      Left = 96
      Top = 72
      Width = 41
      Height = 20
      Color = clTeal
      ParentBackground = False
      TabOrder = 5
      OnClick = pnl10Click
    end
  end
  object dlgColor1: TColorDialog
    Left = 208
    Top = 65528
  end
end
