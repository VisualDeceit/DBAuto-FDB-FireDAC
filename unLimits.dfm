object fmLimits: TfmLimits
  Left = 865
  Top = 254
  Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103' '#1089#1082#1086#1088#1086#1089#1090#1080
  ClientHeight = 666
  ClientWidth = 814
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
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar5: TToolBar
    Left = 0
    Top = 0
    Width = 814
    Height = 38
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar1'
    Color = clBtnFace
    EdgeInner = esNone
    EdgeOuter = esNone
    Images = fmMain.ImageList1
    ParentColor = False
    TabOrder = 0
    object ToolButton12: TToolButton
      Left = 0
      Top = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1092#1072#1081#1083
      AutoSize = True
      Caption = 'ToolButton1'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton12Click
    end
    object ToolButton13: TToolButton
      Left = 39
      Top = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Caption = 'ToolButton13'
      ImageIndex = 11
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton13Click
    end
    object ToolButton1: TToolButton
      Left = 78
      Top = 0
      Hint = #1048#1084#1087#1086#1088#1090
      Caption = 'ToolButton1'
      DropdownMenu = pmImport
      ImageIndex = 16
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton3: TToolButton
      Left = 117
      Top = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' *.DB'
      Caption = 'ToolButton3'
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton3Click
    end
    object ToolButton2: TToolButton
      Left = 156
      Top = 0
      Hint = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1091#1095#1072#1089#1090#1082#1080
      Caption = 'ToolButton2'
      ImageIndex = 29
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton2Click
    end
  end
  object DBG_Limits: TDBGridEh
    Left = 0
    Top = 38
    Width = 814
    Height = 628
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.AutoDropDown = True
    ColumnDefValues.EndEllipsis = True
    Ctl3D = True
    DataSource = fmMain.dsLimits
    DefaultDrawing = False
    DynProps = <>
    Flat = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    OddRowColor = clWhite
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    PopupMenu = pmLimits
    ShowHint = False
    STFilter.InstantApply = False
    STFilter.Location = stflInTitleFilterEh
    TabOrder = 1
    TitleParams.MultiTitle = True
    TitleParams.VTitleMargin = 5
    VertScrollBar.SmoothStep = True
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    OnDrawColumnCell = DBG_LimitsDrawColumnCell
    OnGetCellParams = DBG_LimitsGetCellParams
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Visible = False
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'BEG_KM'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086' || '#1050#1084
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'BEG_PK'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086' || '#1055#1080#1082#1077#1090
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'END_KM'
        Footers = <>
        Title.Caption = #1050#1086#1085#1077#1094' || '#1050#1084
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'END_PK'
        Footers = <>
        Title.Caption = #1050#1086#1085#1077#1094' || '#1055#1080#1082#1077#1090
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SPEED'
        Footers = <>
        Title.Caption = #1057#1082#1086#1088#1086#1089#1090#1100
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'NOTE'
        Footers = <>
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'DIR_KEY'
        Footers = <>
        Visible = False
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SHIFT_KEY'
        Footers = <>
        Visible = False
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object pmLimits: TPopupMenu
    Left = 56
    Top = 104
    object N1: TMenuItem
      Bitmap.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B3908
        7B39087B39087B39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF087B3910CE8410BD6B087B39FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B3918
        D68C10CE84087B39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF087B39087B39087B39087B3918DE9418D68C087B39087B39087B39087B
        39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B3918EFA518EFA518E79C18
        E79418DE9418D68C10CE8410BD6B087B39FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF087B3918EFA518EFA518EFA518E79C18E79418DE9418D68C10CE84087B
        39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B39087B39087B39087B3918
        EFA518E794087B39087B39087B39087B39FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF087B3918EFA518E79C087B39FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B3918
        EFA518EFA5087B39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF087B39087B39087B39087B39FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16429
      OnClick = N1Click
    end
    object N2: TMenuItem
      Bitmap.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF087B39087B39087B39087B39087B39087B39087B39087B39087B39087B
        39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B3910BD6B10BD6B10BD6B10
        BD6B18D68C18DE9418E79418E794087B39FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF087B3910BD6B10BD6B10BD6B18D68C18DE9418E79418E79418E794087B
        39FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF087B39087B39087B39087B3908
        7B39087B39087B39087B39087B39087B39FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = N2Click
    end
  end
  object pmImport: TPopupMenu
    Left = 96
    Top = 104
    object DB1: TMenuItem
      Caption = #1048#1079' *.db'
      OnClick = DB1Click
    end
    object N3: TMenuItem
      Caption = #1048#1079' *.xls'
      OnClick = N3Click
    end
  end
  object ImportDialog: TOpenDialog
    Filter = #1050#1085#1080#1075#1072' Excel (*.xlsx; *xls)|*.xlsx; *xls'
    Left = 200
    Top = 110
  end
end
