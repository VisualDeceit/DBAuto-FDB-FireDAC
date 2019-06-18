object fmStations: TfmStations
  Left = 215
  Top = 224
  Caption = #1057#1090#1072#1085#1094#1080#1080
  ClientHeight = 534
  ClientWidth = 867
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Stations: TDBGridEh
    Left = 0
    Top = 83
    Width = 867
    Height = 451
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.AutoDropDown = True
    ColumnDefValues.EndEllipsis = True
    Ctl3D = True
    DataSource = DS_ST
    DefaultDrawing = False
    DynProps = <>
    Flat = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    EmptyDataInfo.Active = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghEnterAsTab, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleParams.MultiTitle = True
    TitleParams.VTitleMargin = 5
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    OnDrawColumnCell = DBG_StationsDrawColumnCell
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
        FieldName = 'DIR_KEY'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'FNAME'
        Footers = <>
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Title.TitleButton = True
        Width = 203
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'KOORD'
        Footers = <>
        Title.Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072
        Title.TitleButton = True
        Width = 114
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
        FieldName = 'SHIFT_KEY'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'LIN_KOORD'
        Footers = <>
        Title.TitleButton = True
        Visible = False
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 867
    Height = 38
    Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar1'
    Images = fmMain.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object ToolButton3: TToolButton
      Left = 0
      Top = 0
      Hint = #1048#1084#1087#1086#1088#1090' '#1080#1079' DB'
      Caption = 'ToolButton3'
      ImageIndex = 16
      OnClick = ToolButton3Click
    end
    object ToolButton1: TToolButton
      Left = 39
      Top = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090'...'
      AutoSize = True
      Caption = 'ToolButton1'
      DropdownMenu = PopupMenu2
      ImageIndex = 7
    end
    object ToolButton2: TToolButton
      Left = 78
      Top = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Caption = 'ToolButton2'
      ImageIndex = 11
      OnClick = ToolButton2Click
    end
    object ToolButton4: TToolButton
      Left = 117
      Top = 0
      Hint = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1091#1095#1072#1089#1090#1082#1080
      Caption = 'ToolButton4'
      ImageIndex = 29
      OnClick = ToolButton4Click
    end
  end
  object DBNavigator1: TDBNavigator
    AlignWithMargins = True
    Left = 1
    Top = 48
    Width = 865
    Height = 25
    Margins.Left = 1
    Margins.Top = 10
    Margins.Right = 1
    Margins.Bottom = 10
    DataSource = DS_ST
    Align = alTop
    ConfirmDelete = False
    TabOrder = 2
  end
  object PopupMenu1: TPopupMenu
    Left = 106
    Top = 171
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
  object PopupMenu2: TPopupMenu
    Left = 176
    Top = 168
    object N3: TMenuItem
      Caption = #1074' '#1090#1072#1073#1083#1080#1094#1091' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1081
      OnClick = N3Click
    end
    object db1: TMenuItem
      Caption = #1074' '#1092#1072#1081#1083' *.db'
      OnClick = db1Click
    end
  end
  object DS_ST: TDataSource
    DataSet = FDQ_ST
    Left = 400
    Top = 168
  end
  object FDQ_ST: TFDQuery
    AfterPost = FDQ_STAfterPost
    AfterDelete = FDQ_STAfterDelete
    CachedUpdates = True
    MasterSource = fmDirection.DS_DIR
    MasterFields = 'ID'
    Connection = fmMain.FDC_Base
    Transaction = fmMain.FDT_READ
    UpdateTransaction = FDT_WRITE_ST
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired]
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.GeneratorName = 'GEN_LIGHT_SIGNALS_ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = FDUSQL_ST
    SQL.Strings = (
      'SELECT S.*,'
      '(S.Koord * SH.Flag+ SH.FValue) AS  LIN_KOORD'
      'FROM  Stations S'
      'LEFT OUTER JOIN Shift SH'
      'ON  (S.Shift_KEY = Sh.ID)'
      'WHERE  S.Dir_key = :ID'
      'ORDER BY KOORD')
    Left = 456
    Top = 168
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQ_STID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere]
      IdentityInsert = True
    end
    object FDQ_STDIR_KEY: TIntegerField
      FieldName = 'DIR_KEY'
      Origin = 'DIR_KEY'
    end
    object FDQ_STSHIFT_KEY: TIntegerField
      FieldName = 'SHIFT_KEY'
      Origin = 'SHIFT_KEY'
    end
    object FDQ_STFNAME: TStringField
      FieldName = 'FNAME'
      Origin = 'FNAME'
      Size = 10
    end
    object FDQ_STKOORD: TIntegerField
      FieldName = 'KOORD'
      Origin = 'KOORD'
    end
    object FDQ_STSPEED: TIntegerField
      FieldName = 'SPEED'
      Origin = 'SPEED'
    end
    object FDQ_STLIN_KOORD: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_KOORD'
      Origin = 'LIN_KOORD'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQ_STBEG_KM: TIntegerField
      FieldName = 'BEG_KM'
      Origin = 'BEG_KM'
    end
    object FDQ_STBEG_PK: TIntegerField
      FieldName = 'BEG_PK'
      Origin = 'BEG_PK'
    end
    object FDQ_STEND_KM: TIntegerField
      FieldName = 'END_KM'
      Origin = 'END_KM'
    end
    object FDQ_STEND_PK: TIntegerField
      FieldName = 'END_PK'
      Origin = 'END_PK'
    end
  end
  object FDUSQL_ST: TFDUpdateSQL
    Connection = fmMain.FDC_Base
    InsertSQL.Strings = (
      'INSERT INTO STATIONS'
      '(DIR_KEY, FNAME, KOORD, BEG_KM, BEG_PK, '
      '  END_KM, END_PK, SPEED, SHIFT_KEY)'
      
        'VALUES (:ID, UPPER(:NEW_FNAME), :NEW_KOORD, :NEW_BEG_KM, :NEW_BE' +
        'G_PK, '
      '  :NEW_END_KM, :NEW_END_PK, :NEW_SPEED, :NEW_SHIFT_KEY)')
    ModifySQL.Strings = (
      'UPDATE STATIONS'
      
        'SET DIR_KEY = :NEW_DIR_KEY, FNAME = UPPER(:NEW_FNAME), KOORD = :' +
        'NEW_KOORD, '
      
        '  BEG_KM = :NEW_BEG_KM, BEG_PK = :NEW_BEG_PK, END_KM = :NEW_END_' +
        'KM, '
      
        '  END_PK = :NEW_END_PK, SPEED = :NEW_SPEED, SHIFT_KEY = :NEW_SHI' +
        'FT_KEY'
      'WHERE ID = :OLD_ID')
    DeleteSQL.Strings = (
      'DELETE FROM STATIONS'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      
        'SELECT ID, DIR_KEY, FNAME, KOORD, BEG_KM, BEG_PK, END_KM, END_PK' +
        ', SPEED, '
      '  SHIFT_KEY'
      'FROM STATIONS'
      'WHERE ID = :ID')
    Left = 604
    Top = 168
  end
  object FDT_WRITE_ST: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = fmMain.FDC_Base
    Left = 527
    Top = 168
  end
  object FDCmd: TFDCommand
    Connection = fmMain.FDC_Base
    Transaction = FDT_WRITE_ST
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    Left = 452
    Top = 232
  end
end
