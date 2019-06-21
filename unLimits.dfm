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
    object TB_ClearAll: TToolButton
      Left = 39
      Top = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Caption = 'TB_ClearAll'
      ImageIndex = 11
      ParentShowHint = False
      ShowHint = True
      OnClick = TB_ClearAllClick
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
      Visible = False
      OnClick = ToolButton2Click
    end
  end
  object DBG_Limits: TDBGridEh
    Left = 0
    Top = 83
    Width = 814
    Height = 583
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.AutoDropDown = True
    ColumnDefValues.EndEllipsis = True
    Ctl3D = True
    DataSource = DS_LIM
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
    EmptyDataInfo.Active = True
    EmptyDataInfo.Text = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
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
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'BEG_KM'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086' || '#1050#1084
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'BEG_PK'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086' || '#1055#1080#1082#1077#1090
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'END_KM'
        Footers = <>
        Title.Caption = #1050#1086#1085#1077#1094' || '#1050#1084
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'END_PK'
        Footers = <>
        Title.Caption = #1050#1086#1085#1077#1094' || '#1055#1080#1082#1077#1090
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'SPEED'
        Footers = <>
        Title.Caption = #1057#1082#1086#1088#1086#1089#1090#1100
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'NOTE'
        Footers = <>
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'DIR_KEY'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'SHIFT_KEY'
        Footers = <>
        Visible = False
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBNavigator1: TDBNavigator
    AlignWithMargins = True
    Left = 1
    Top = 48
    Width = 812
    Height = 25
    Margins.Left = 1
    Margins.Top = 10
    Margins.Right = 1
    Margins.Bottom = 10
    DataSource = DS_LIM
    Align = alTop
    ConfirmDelete = False
    TabOrder = 2
  end
  object pmLimits: TPopupMenu
    Left = 40
    Top = 160
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
    end
  end
  object pmImport: TPopupMenu
    Left = 96
    Top = 160
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
    Top = 158
  end
  object DS_LIM: TDataSource
    DataSet = FDQ_LIM
    Left = 344
    Top = 184
  end
  object FDQ_LIM: TFDQuery
    Active = True
    AfterPost = FDQ_LIMAfterPost
    CachedUpdates = True
    MasterSource = fmDirection.DS_DIR
    MasterFields = 'ID'
    Connection = fmMain.FDC_Base
    Transaction = fmMain.FDT_READ
    UpdateTransaction = FDT_WRITE_LIM
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired]
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.GeneratorName = 'GEN_LIGHT_SIGNALS_ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = FDUSQL_LIM
    SQL.Strings = (
      'SELECT L.*,'
      
        '(L.beg_km * 1000+ L.beg_pk*100)* SH.Flag+ SH.FValue AS  LIN_koor' +
        'd,'
      
        '((L.beg_km * 1000 +  L.beg_pk * 100)*SH.Flag+ SH.FValue)/1000 AS' +
        '  LIN_BEG_KM,'
      
        '(((L.beg_km * 1000 +  L.beg_pk * 100)*SH.Flag+ SH.FValue) - (((L' +
        '.beg_km*1000 +  L.beg_pk* 100)*SH.Flag+ SH.FValue)/1000)*1000)/1' +
        '00  AS LIN_BEG_PK,'
      
        '((L.end_km * 1000 +  L.end_pk * 100)*SH.Flag+ SH.FValue)/1000  A' +
        'S LIN_END_KM,'
      
        '(((L.end_km * 1000 +  L.end_pk * 100)*SH.Flag+ SH.FValue) - (((L' +
        '.end_km*1000 +  L.end_pk* 100)*SH.Flag+ SH.FValue)/1000)*1000)/1' +
        '00  AS LIN_END_PK'
      'FROM  Limits L'
      'LEFT OUTER JOIN Shift SH'
      'ON  (L.Shift_KEY = Sh.ID)'
      'WHERE  L.dir_key = :id'
      'ORDER BY  L.beg_km, L.beg_pk')
    Left = 400
    Top = 184
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQ_LIMID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere]
      IdentityInsert = True
    end
    object FDQ_LIMBEG_KM: TIntegerField
      FieldName = 'BEG_KM'
      Origin = 'BEG_KM'
    end
    object FDQ_LIMBEG_PK: TIntegerField
      FieldName = 'BEG_PK'
      Origin = 'BEG_PK'
    end
    object FDQ_LIMEND_KM: TIntegerField
      FieldName = 'END_KM'
      Origin = 'END_KM'
    end
    object FDQ_LIMEND_PK: TIntegerField
      FieldName = 'END_PK'
      Origin = 'END_PK'
    end
    object FDQ_LIMSPEED: TSmallintField
      FieldName = 'SPEED'
      Origin = 'SPEED'
    end
    object FDQ_LIMNOTE: TStringField
      FieldName = 'NOTE'
      Origin = 'NOTE'
      Size = 30
    end
    object FDQ_LIMDIR_KEY: TIntegerField
      FieldName = 'DIR_KEY'
      Origin = 'DIR_KEY'
    end
    object FDQ_LIMSHIFT_KEY: TIntegerField
      FieldName = 'SHIFT_KEY'
      Origin = 'SHIFT_KEY'
    end
    object FDQ_LIMLIN_KOORD: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_KOORD'
      Origin = 'LIN_KOORD'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQ_LIMLIN_BEG_KM: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_BEG_KM'
      Origin = 'LIN_BEG_KM'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQ_LIMLIN_BEG_PK: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_BEG_PK'
      Origin = 'LIN_BEG_PK'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQ_LIMLIN_END_KM: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_END_KM'
      Origin = 'LIN_END_KM'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQ_LIMLIN_END_PK: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_END_PK'
      Origin = 'LIN_END_PK'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDUSQL_LIM: TFDUpdateSQL
    Connection = fmMain.FDC_Base
    InsertSQL.Strings = (
      'insert into Limits'
      
        '  (BEG_KM, BEG_PK, END_KM, END_PK, SPEED, NOTE, DIR_KEY, SHIFT_K' +
        'EY)'
      'values'
      
        '  (:BEG_KM, :BEG_PK, :END_KM, :END_PK, :SPEED, :NOTE, :DIR_KEY, ' +
        ':SHIFT_KEY)')
    ModifySQL.Strings = (
      'update Limits'
      'set'
      '  BEG_KM = :BEG_KM,'
      '  BEG_PK = :BEG_PK,'
      '  END_KM = :END_KM,'
      '  END_PK = :END_PK,'
      '  SPEED = :SPEED,'
      '  NOTE = :NOTE,'
      '  DIR_KEY = :DIR_KEY,'
      '  SHIFT_KEY = :SHIFT_KEY'
      'where'
      '  ID = :OLD_ID')
    DeleteSQL.Strings = (
      'delete from Limits'
      'where'
      '  ID = :OLD_ID')
    FetchRowSQL.Strings = (
      'Select '
      'from Limits '
      'where'
      '  ID = :ID')
    Left = 468
    Top = 184
  end
  object FDT_WRITE_LIM: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = fmMain.FDC_Base
    Left = 399
    Top = 248
  end
  object FDCmd: TFDCommand
    Connection = fmMain.FDC_Base
    Transaction = FDT_WRITE_LIM
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    Left = 396
    Top = 312
  end
end
