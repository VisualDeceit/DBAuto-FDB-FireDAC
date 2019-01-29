object fmTrains: TfmTrains
  Left = 562
  Top = 326
  BorderStyle = bsSizeToolWin
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1086#1077#1079#1076#1086#1074
  ClientHeight = 310
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 4
    Top = 3
    Width = 389
    Height = 302
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 0
    object DBG_Trains: TDBGridEh
      Left = 6
      Top = 5
      Width = 371
      Height = 284
      AutoFitColWidths = True
      ColumnDefValues.AlwaysShowEditButton = True
      ColumnDefValues.AutoDropDown = True
      ColumnDefValues.EndEllipsis = True
      Ctl3D = True
      DataSource = fmMain.dsTrains
      DefaultDrawing = False
      DynProps = <>
      Flat = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'RussianRail G Pro Extended'
      Font.Style = []
      FooterParams.Color = clWindow
      IndicatorOptions = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
      ParentCtl3D = False
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleParams.MultiTitle = True
      TitleParams.VTitleMargin = 5
      VertScrollBar.VisibleMode = sbAlwaysShowEh
      OnDrawColumnCell = DBG_TrainsDrawColumnCell
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'dir_name'
          Footers = <>
          Title.Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
          Title.EndEllipsis = True
          Width = 114
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'NUMBER'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088
          Title.EndEllipsis = True
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Train_ID'
          Footers = <>
          Visible = False
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'DIR_KEY'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 116
    Top = 91
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
    end
  end
end
