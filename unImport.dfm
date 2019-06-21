object fmImport: TfmImport
  Left = 487
  Top = 232
  BorderStyle = bsSingle
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 630
  ClientWidth = 1173
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 48
    Width = 185
    Height = 577
    Align = alCustom
    Caption = #1060#1080#1083#1100#1090#1088
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 10
      Top = 20
      Width = 167
      Height = 261
      Caption = #1055#1086' '#1086#1073#1098#1077#1082#1090#1072#1084
      TabOrder = 0
      object clbFilterObjects: TCheckListBox
        Left = 8
        Top = 24
        Width = 145
        Height = 225
        Enabled = False
        ItemHeight = 18
        Items.Strings = (
          #1044'-'#1082' '#1057#1040#1059#1058
          #1044'-'#1082' '#1058#1050#1057
          #1052#1086#1089#1090
          #1054#1087'.'#1084#1077#1089#1090#1086
          #1055#1077#1088#1077#1077#1079#1076
          #1055#1083#1072#1090#1092#1086#1088#1084#1072
          #1057#1074#1077#1090#1086#1092#1086#1088
          #1057#1090#1072#1085#1094#1080#1103
          #1057#1090#1088#1077#1083#1082#1072
          #1058#1086#1088#1084#1086#1079
          #1058#1091#1085#1085#1077#1083#1100
          #1058#1091#1087#1080#1082)
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnClick = clbFilterObjectsClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 288
      Width = 169
      Height = 281
      Caption = #1055#1086' '#1087#1091#1090#1103#1084
      TabOrder = 1
      object clbFilterPath: TCheckListBox
        Left = 8
        Top = 24
        Width = 153
        Height = 249
        Columns = 3
        Enabled = False
        ItemHeight = 18
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '13'
          '14'
          '15'
          '16'
          '17'
          '18'
          '19'
          '20'
          '21'
          '22'
          '23'
          '24'
          '25'
          '26'
          '27'
          '28'
          '29'
          '30')
        PopupMenu = PopupMenu2
        TabOrder = 0
        OnClick = clbFilterPathClick
      end
    end
  end
  object Panel1: TPanel
    Left = 192
    Top = 56
    Width = 705
    Height = 569
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 1
    object StringGrid1: TStringGrid
      Left = 17
      Top = 12
      Width = 689
      Height = 553
      ColCount = 10
      Ctl3D = False
      DefaultDrawing = False
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnContextPopup = StringGrid1ContextPopup
      OnDrawCell = StringGrid1DrawCell
      OnMouseDown = StringGrid1MouseDown
    end
  end
  object GroupBox4: TGroupBox
    Left = 904
    Top = 48
    Width = 265
    Height = 577
    Caption = #1048#1084#1087#1086#1088#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object GroupBox5: TGroupBox
      Left = 8
      Top = 352
      Width = 249
      Height = 73
      Caption = #1044#1080#1072#1087#1072#1079#1086#1085
      TabOrder = 0
      object Label1: TLabel
        Left = 116
        Top = 28
        Width = 9
        Height = 18
        Caption = '_'
      end
      object Edit1: TEdit
        Left = 16
        Top = 32
        Width = 90
        Height = 26
        TabOrder = 0
        Text = '1'
      end
      object Edit2: TEdit
        Left = 136
        Top = 32
        Width = 90
        Height = 26
        TabOrder = 1
        Text = '1'
      end
    end
    object Button1: TButton
      Left = 8
      Top = 480
      Width = 249
      Height = 49
      Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 200
      Width = 249
      Height = 145
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1089#1074#1077#1090#1086#1092#1086#1088#1086#1074
      TabOrder = 2
      object Label2: TLabel
        Left = 8
        Top = 24
        Width = 140
        Height = 18
        Caption = #1042#1093#1086#1076#1085#1086#1081', '#1074#1099#1093#1086#1076#1085#1086#1081
      end
      object Label3: TLabel
        Left = 8
        Top = 80
        Width = 79
        Height = 18
        Caption = #1055#1088#1086#1093#1086#1076#1085#1086#1081
      end
      object Edit3: TEdit
        Left = 16
        Top = 48
        Width = 121
        Height = 26
        TabOrder = 0
        Text = '40'
      end
      object Edit4: TEdit
        Left = 16
        Top = 104
        Width = 121
        Height = 26
        TabOrder = 1
        Text = '60'
      end
    end
    object DBG_Dir: TDBGridEh
      Left = 3
      Top = 20
      Width = 259
      Height = 157
      DataSource = fmMain.dsDirections
      DynProps = <>
      TabOrder = 3
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
          FieldName = 'FNAME'
          Footers = <>
          Title.Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
          Width = 199
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'CODE'
          Footers = <>
          Visible = False
        end
        item
          Alignment = taLeftJustify
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'WAY'
          Footers = <>
          Title.Caption = #1055#1091#1090#1100
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'FLAG'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1173
    Height = 38
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar1'
    Images = fmMain.ImageList1
    TabOrder = 3
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100
      Caption = 'ToolButton1'
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton1Click
    end
    object ToolButton3: TToolButton
      Left = 39
      Top = 0
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1091#1095#1072#1089#1090#1082#1080
      Caption = 'ToolButton3'
      ImageIndex = 9
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton3Click
    end
    object ToolButton2: TToolButton
      Left = 78
      Top = 0
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1086#1073#1098#1077#1082#1090#1099
      Caption = 'ToolButton2'
      ImageIndex = 10
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton2Click
    end
  end
  object ImportDialog: TOpenDialog
    Filter = #1050#1085#1080#1075#1072' Excel (*.xlsx; *xls)|*.xlsx; *xls'
    Left = 752
    Top = 118
  end
  object PopupMenu1: TPopupMenu
    Left = 168
    Top = 208
    object N1: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1105' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      OnClick = N2Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 176
    Top = 272
    object MenuItem1: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      OnClick = MenuItem1Click
    end
    object MenuItem2: TMenuItem
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1105' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      OnClick = MenuItem2Click
    end
  end
  object PopupMenu3: TPopupMenu
    AutoHotkeys = maManual
    BiDiMode = bdRightToLeftNoAlign
    OwnerDraw = True
    ParentBiDiMode = False
    Left = 752
    Top = 152
    object N3: TMenuItem
      Tag = 12
      Caption = #1057#1090#1072#1085#1094#1080#1103' '#1085#1077' '#1074#1099#1073#1088#1072#1085#1072
      Default = True
      Enabled = False
      OnDrawItem = N3DrawItem
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1093#1086#1076#1085#1086#1081
      OnClick = N5Click
      OnDrawItem = N5DrawItem
      OnMeasureItem = N7MeasureItem
    end
    object N6: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1099#1093#1086#1076#1085#1086#1081
      OnClick = N6Click
      OnDrawItem = N5DrawItem
      OnMeasureItem = N7MeasureItem
    end
  end
  object PopupMenu4: TPopupMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    Left = 752
    Top = 192
    object N7: TMenuItem
      Caption = #1042#1093#1086#1076#1085#1086#1081' '
      OnDrawItem = N7DrawItem
      OnMeasureItem = N7MeasureItem
    end
    object N8: TMenuItem
      Tag = 12
      Caption = #1042#1099#1093#1086#1076#1085#1086#1081
      OnDrawItem = N7DrawItem
      OnMeasureItem = N7MeasureItem
    end
  end
  object PopupMenu5: TPopupMenu
    OwnerDraw = True
    Left = 752
    Top = 232
    object N9: TMenuItem
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1089#1090#1072#1085#1094#1080#1102
      OnClick = N9Click
      OnDrawItem = N5DrawItem
      OnMeasureItem = N7MeasureItem
    end
    object N10: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Visible = False
      OnClick = N10Click
      OnDrawItem = N5DrawItem
      OnMeasureItem = N7MeasureItem
    end
  end
end
