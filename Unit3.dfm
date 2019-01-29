object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077
  ClientHeight = 366
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 100
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099': '
  end
  object Label2: TLabel
    Left = 8
    Top = 27
    Width = 94
    Height = 13
    Caption = #1044#1086#1089#1090#1091#1087#1085#1072' '#1074#1077#1088#1089#1080#1103': '
  end
  object Label3: TLabel
    Left = 108
    Top = 8
    Width = 16
    Height = 13
    Caption = '1.0'
  end
  object Label4: TLabel
    Left = 176
    Top = 61
    Width = 105
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103': '
  end
  object Label5: TLabel
    Left = 8
    Top = 87
    Width = 182
    Height = 13
    Caption = #1044#1086#1089#1090#1091#1087#1085#1072' '#1085#1086#1074#1072#1103' '#1074#1077#1088#1089#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 8
    Top = 141
    Width = 61
    Height = 13
    Caption = #1063#1090#1086' '#1085#1086#1074#1086#1075#1086':'
  end
  object Button1: TButton
    Left = 8
    Top = 56
    Width = 145
    Height = 25
    Caption = #1057#1082#1072#1095#1072#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 109
    Width = 381
    Height = 17
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 8
    Top = 160
    Width = 381
    Height = 184
    TabOrder = 2
  end
  object IdHTTP1: TIdHTTP
    OnWork = IdHTTP1Work
    OnWorkBegin = IdHTTP1WorkBegin
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 352
    Top = 8
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 288
    Top = 8
  end
end
