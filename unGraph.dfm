object fmGraph: TfmGraph
  Left = 261
  Top = 335
  Caption = #1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
  ClientHeight = 499
  ClientWidth = 1370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1370
    Height = 52
    ParentCustomHint = False
    AutoSize = True
    ButtonHeight = 52
    ButtonWidth = 39
    Caption = 'ToolBar1'
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GradientEndColor = clGreen
    GradientStartColor = clHighlight
    HotTrackColor = clGreen
    Images = fmMain.ImageList1
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object btn1: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = 'btn1'
      ImageIndex = 32
      OnClick = btn1Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 480
    Width = 1370
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Text = #8240
        Width = 100
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = '1:100'
        Width = 100
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    PopupMenu = PopupMenu1
    SizeGrip = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 52
    Width = 1370
    Height = 428
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 1368
      Height = 426
      HorzScrollBar.Increment = 100
      HorzScrollBar.Tracking = True
      VertScrollBar.Visible = False
      Align = alClient
      DoubleBuffered = True
      Color = clBtnFace
      ParentColor = False
      ParentDoubleBuffered = False
      TabOrder = 0
      OnCanResize = ScrollBox1CanResize
      object PaintBox1: TPaintBox
        Left = 3
        Top = 3
        Width = 2000
        Height = 400
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnMouseUp = PaintBox1MouseUp
        OnPaint = PaintBox1Paint
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 793
    Top = 94
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 545
    Top = 54
  end
end
