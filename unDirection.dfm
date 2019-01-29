object fmDirection: TfmDirection
  Left = 474
  Top = 247
  Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
  ClientHeight = 782
  ClientWidth = 558
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
  object DBG_Direction: TDBGridEh
    Left = 0
    Top = 45
    Width = 558
    Height = 737
    Align = alClient
    AutoFitColWidths = True
    ColumnDefValues.AlwaysShowEditButton = True
    ColumnDefValues.AutoDropDown = True
    ColumnDefValues.EndEllipsis = True
    Ctl3D = True
    DataGrouping.Active = True
    DataGrouping.GroupLevels = <
      item
        ColumnName = 'Column_2_CODE'
      end>
    DataSource = DS_DIR
    DynProps = <>
    Flat = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    FooterParams.Color = clWindow
    IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghEnterAsTab, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleParams.MultiTitle = True
    TitleParams.VTitleMargin = 5
    VertScrollBar.Tracking = False
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    OnCellMouseClick = DBG_DirectionCellMouseClick
    OnDrawColumnCell = DBG_DirectionDrawColumnCell
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
        FieldName = 'FNAME'
        Footers = <>
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 192
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CODE'
        Footers = <>
        Title.Caption = #1050#1086#1076
        Width = 56
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'WAY'
        Footers = <>
        Title.Caption = #1055#1091#1090#1100
        Width = 65
      end
      item
        Checkboxes = True
        DblClickNextVal = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'FLAG'
        Footers = <>
        Title.Caption = #1055#1088#1072#1074'.'
        Title.EndEllipsis = True
        Width = 74
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'RAIL_NAME'
        Footers = <>
        Title.Caption = #1046#1044
        Width = 109
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBNavigator1: TDBNavigator
    AlignWithMargins = True
    Left = 1
    Top = 10
    Width = 556
    Height = 25
    Margins.Left = 1
    Margins.Top = 10
    Margins.Right = 1
    Margins.Bottom = 10
    DataSource = DS_DIR
    Align = alTop
    TabOrder = 1
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 96
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
    object N3: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ShortCut = 16451
      Visible = False
      OnClick = N3Click
    end
  end
  object FDT_WRITE_DIR: TFDTransaction
    Options.Isolation = xiSnapshot
    Options.AutoStart = False
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = fmMain.FDC_Base
    Left = 375
    Top = 200
  end
  object FDQ_DIR: TFDQuery
    AfterPost = FDQ_DIRAfterPost
    CachedUpdates = True
    Connection = fmMain.FDC_Base
    Transaction = fmMain.FDT_READ
    UpdateTransaction = FDT_WRITE_DIR
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvFetchGeneratorsPoint, uvGeneratorName, uvCheckRequired]
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.GeneratorName = 'GEN_DIRECTIONS_ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = FDUSQL_DIR
    SQL.Strings = (
      'select * from DIRECTIONS'
      'ORDER by CODE, WAY')
    Left = 376
    Top = 136
    object FDQ_DIRID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere]
      IdentityInsert = True
    end
    object FDQ_DIRFNAME: TStringField
      FieldName = 'FNAME'
      Origin = 'FNAME'
      Size = 25
    end
    object FDQ_DIRCODE: TIntegerField
      FieldName = 'CODE'
      Origin = 'CODE'
    end
    object FDQ_DIRWAY: TIntegerField
      FieldName = 'WAY'
      Origin = 'WAY'
    end
    object FDQ_DIRFLAG: TSmallintField
      DisplayLabel = #1055#1088#1072#1074#1080#1083#1100#1085#1099#1081
      FieldName = 'FLAG'
      Origin = 'FLAG'
      Required = True
    end
    object FDQ_DIRRAIL_KEY: TIntegerField
      FieldName = 'RAIL_KEY'
      Origin = 'RAIL_KEY'
    end
  end
  object FDUSQL_DIR: TFDUpdateSQL
    Connection = fmMain.FDC_Base
    InsertSQL.Strings = (
      'INSERT INTO DIRECTIONS'
      '(FNAME, CODE, WAY, FLAG, RAIL_KEY)'
      
        'VALUES (:NEW_FNAME, :NEW_CODE, :NEW_WAY, :NEW_FLAG, :NEW_RAIL_KE' +
        'Y)')
    ModifySQL.Strings = (
      'UPDATE DIRECTIONS'
      
        'SET FNAME = :NEW_FNAME, CODE = :NEW_CODE, WAY = :NEW_WAY, FLAG =' +
        ' :NEW_FLAG, '
      '  RAIL_KEY = :NEW_RAIL_KEY'
      'WHERE ID = :OLD_ID')
    DeleteSQL.Strings = (
      'DELETE FROM DIRECTIONS'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      'SELECT ID, FNAME, CODE, WAY, FLAG, RAIL_KEY'
      'FROM DIRECTIONS'
      'WHERE ID = :ID')
    Left = 440
    Top = 136
  end
  object DS_DIR: TDataSource
    DataSet = FDQ_DIR
    Left = 320
    Top = 136
  end
end
