object fmSvet: TfmSvet
  Left = 515
  Top = 235
  Caption = #1057#1074#1077#1090#1086#1092#1086#1088#1099
  ClientHeight = 742
  ClientWidth = 432
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
  object ToolBar4: TToolBar
    Left = 0
    Top = 0
    Width = 432
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
    object ToolButton6: TToolButton
      Left = 0
      Top = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100
      AutoSize = True
      Caption = 'ToolButton1'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton6Click
    end
    object ClaerAll: TToolButton
      Left = 39
      Top = 0
      Hint = #1054#1095#1080#1089#1090#1082#1072' '#1090#1072#1073#1083#1080#1094#1099
      Caption = 'ClaerAll'
      ImageIndex = 11
      ParentShowHint = False
      ShowHint = True
      OnClick = ClaerAllClick
    end
    object ImportFromDB: TToolButton
      Left = 78
      Top = 0
      Hint = #1048#1084#1087#1086#1088#1090' '#1080#1079' DB'
      Caption = 'ImportFromDB'
      ImageIndex = 16
      ParentShowHint = False
      ShowHint = True
      OnClick = ImportFromDBClick
    end
  end
  object DBG_Svet: TDBGridEh
    Left = 0
    Top = 83
    Width = 432
    Height = 659
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.AutoDropDown = True
    ColumnDefValues.EndEllipsis = True
    Ctl3D = True
    DataSource = DS_SV
    DefaultDrawing = False
    DynProps = <>
    EvenRowColor = clWindow
    Flat = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    EmptyDataInfo.Active = True
    EmptyDataInfo.Text = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
    OddRowColor = clWindow
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghEnterAsTab, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentFont = False
    STFilter.InstantApply = False
    STFilter.Location = stflInTitleFilterEh
    TabOrder = 1
    TitleParams.MultiTitle = True
    TitleParams.VTitleMargin = 5
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    OnDrawColumnCell = DBG_SvetDrawColumnCell
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
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'KOORD'
        Footers = <>
        Title.Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072
        Width = 108
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
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBNavigator1: TDBNavigator
    AlignWithMargins = True
    Left = 1
    Top = 48
    Width = 430
    Height = 25
    Margins.Left = 1
    Margins.Top = 10
    Margins.Right = 1
    Margins.Bottom = 10
    DataSource = DS_SV
    Align = alTop
    ConfirmDelete = False
    TabOrder = 2
  end
  object DS_SV: TDataSource
    DataSet = FDQ_SV
    Left = 200
    Top = 176
  end
  object FDQ_SV: TFDQuery
    AfterPost = FDQ_SVAfterPost
    AfterDelete = FDQ_SVAfterDelete
    CachedUpdates = True
    MasterSource = fmMain.DS_DIR
    MasterFields = 'ID'
    Connection = fmMain.FDC_Base
    Transaction = fmMain.FDT_READ
    UpdateTransaction = FDT_WRITE_SV
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired]
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.GeneratorName = 'GEN_LIGHT_SIGNALS_ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = FDUSQL_SV
    SQL.Strings = (
      'SELECT LS.*,'
      'LS.KOORD * SH.Flag + SH.FValue AS  LIN_koord'
      'FROM  LIGHT_SIGNALS LS'
      'LEFT OUTER JOIN Shift SH'
      'ON  (LS.Shift_KEY = Sh.ID)'
      'WHERE  LS.Dir_key= :ID'
      'ORDER BY LS.KOORD')
    Left = 256
    Top = 176
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQ_SVID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere]
      IdentityInsert = True
    end
    object FDQ_SVDIR_KEY: TIntegerField
      FieldName = 'DIR_KEY'
      Origin = 'DIR_KEY'
    end
    object FDQ_SVSHIFT_KEY: TIntegerField
      FieldName = 'SHIFT_KEY'
      Origin = 'SHIFT_KEY'
    end
    object FDQ_SVFNAME: TStringField
      FieldName = 'FNAME'
      Origin = 'FNAME'
      Size = 10
    end
    object FDQ_SVKOORD: TIntegerField
      FieldName = 'KOORD'
      Origin = 'KOORD'
    end
    object FDQ_SVSPEED: TIntegerField
      FieldName = 'SPEED'
      Origin = 'SPEED'
    end
    object FDQ_SVLIN_KOORD: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'LIN_KOORD'
      Origin = 'LIN_KOORD'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDUSQL_SV: TFDUpdateSQL
    Connection = fmMain.FDC_Base
    InsertSQL.Strings = (
      'INSERT INTO LIGHT_SIGNALS'
      '(DIR_KEY, SHIFT_KEY, FNAME, KOORD, SPEED)'
      'VALUES (:ID, :NEW_SHIFT_KEY, :NEW_FNAME, :NEW_KOORD, :NEW_SPEED)')
    ModifySQL.Strings = (
      'UPDATE LIGHT_SIGNALS'
      
        'SET DIR_KEY = :NEW_DIR_KEY, SHIFT_KEY = :NEW_SHIFT_KEY, FNAME = ' +
        ':NEW_FNAME, '
      '  KOORD = :NEW_KOORD, SPEED = :NEW_SPEED'
      'WHERE ID = :OLD_ID'
      '')
    DeleteSQL.Strings = (
      'DELETE FROM LIGHT_SIGNALS'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      'SELECT ID, DIR_KEY, SHIFT_KEY, FNAME, KOORD, SPEED'
      'FROM LIGHT_SIGNALS'
      'WHERE ID = :ID')
    Left = 324
    Top = 176
  end
  object FDT_WRITE_SV: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = fmMain.FDC_Base
    Left = 255
    Top = 240
  end
  object FDCmd: TFDCommand
    Connection = fmMain.FDC_Base
    Transaction = FDT_WRITE_SV
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    Left = 252
    Top = 304
  end
end
