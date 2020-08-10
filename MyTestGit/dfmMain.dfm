object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1055#1088#1080#1077#1084#1099
  ClientHeight = 506
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 129
    Width = 976
    Height = 377
    Align = alClient
    TabOrder = 0
    object ADVSgReception: TAdvStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 968
      Height = 369
      Cursor = crDefault
      Align = alClient
      ColCount = 8
      DrawingStyle = gdsClassic
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      PopupMenu = pm1
      ScrollBars = ssBoth
      TabOrder = 0
      OnDblClick = btnClick
      OnSelectCell = ADVSgReceptionSelectCell
      ActiveRowShow = True
      HoverRowCells = [hcNormal, hcSelected]
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      AutoSize = True
      ColumnHeaders.Strings = (
        'ID '#1087#1088#1080#1077#1084#1072
        #1044#1072#1090#1072' '#1087#1088#1080#1077#1084#1072
        #1060#1080#1086' '#1087#1072#1094#1080#1077#1085#1090#1072
        #1053#1086#1084#1077#1088' '#1087#1086#1083#1080#1089#1072
        #1055#1086#1089#1090#1072#1074#1083#1077#1085#1085#1099#1081' '#1076#1080#1072#1075#1085#1086#1079
        #1053#1072#1079#1085#1072#1095#1077#1085#1085#1086#1077' '#1083#1077#1095#1077#1085#1080#1077
        #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1088#1080#1077#1084#1072
        #1042#1088#1072#1095)
      ControlLook.FixedGradientHoverFrom = clGray
      ControlLook.FixedGradientHoverTo = clWhite
      ControlLook.FixedGradientDownFrom = clGray
      ControlLook.FixedGradientDownTo = clSilver
      ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
      ControlLook.DropDownHeader.Font.Color = clWindowText
      ControlLook.DropDownHeader.Font.Height = -11
      ControlLook.DropDownHeader.Font.Name = 'Tahoma'
      ControlLook.DropDownHeader.Font.Style = []
      ControlLook.DropDownHeader.Visible = True
      ControlLook.DropDownHeader.Buttons = <>
      ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
      ControlLook.DropDownFooter.Font.Color = clWindowText
      ControlLook.DropDownFooter.Font.Height = -11
      ControlLook.DropDownFooter.Font.Name = 'Tahoma'
      ControlLook.DropDownFooter.Font.Style = []
      ControlLook.DropDownFooter.Visible = True
      ControlLook.DropDownFooter.Buttons = <>
      Filter = <>
      FilterDropDown.Font.Charset = DEFAULT_CHARSET
      FilterDropDown.Font.Color = clWindowText
      FilterDropDown.Font.Height = -11
      FilterDropDown.Font.Name = 'Tahoma'
      FilterDropDown.Font.Style = []
      FilterDropDown.TextChecked = 'Checked'
      FilterDropDown.TextUnChecked = 'Unchecked'
      FilterDropDownClear = '(All)'
      FilterEdit.TypeNames.Strings = (
        'Starts with'
        'Ends with'
        'Contains'
        'Not contains'
        'Equal'
        'Not equal'
        'Larger than'
        'Smaller than'
        'Clear')
      FixedRowHeight = 22
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      HoverButtons.Buttons = <>
      HoverButtons.Position = hbLeftFromColumnLeft
      HTMLSettings.ImageFolder = 'images'
      HTMLSettings.ImageBaseName = 'img'
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'Tahoma'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'Tahoma'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'Tahoma'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'Tahoma'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurrence'
      SearchFooter.HintFindPrev = 'Find previous occurrence'
      SearchFooter.HintHighlight = 'Highlight occurrences'
      SearchFooter.MatchCaseCaption = 'Match case'
      ShowDesignHelper = False
      SortSettings.DefaultFormat = ssAutomatic
      Version = '8.1.3.0'
      ColWidths = (
        64
        88
        93
        92
        149
        140
        119
        40)
      RowHeights = (
        22
        22
        22
        22
        22
        22
        22
        22
        22
        22)
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 40
    Width = 976
    Height = 54
    Align = alTop
    TabOrder = 1
    object btnDel: TSpeedButton
      Left = 193
      Top = 1
      Width = 96
      Height = 52
      Align = alLeft
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = btnDelClick
      ExplicitLeft = 295
      ExplicitTop = -4
    end
    object btnAdd: TSpeedButton
      Tag = 2
      Left = 97
      Top = 1
      Width = 96
      Height = 52
      Align = alLeft
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = btnClick
      ExplicitLeft = 91
      ExplicitTop = 2
    end
    object btnExcel: TSpeedButton
      Left = 289
      Top = 1
      Width = 104
      Height = 52
      Align = alLeft
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      OnClick = btnExcelClick
      ExplicitLeft = 391
      ExplicitTop = -4
    end
    object btnOpen: TSpeedButton
      Tag = 1
      Left = 1
      Top = 1
      Width = 96
      Height = 52
      Align = alLeft
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnClick = btnClick
      ExplicitLeft = 21
      ExplicitTop = 6
    end
  end
  object pnlInfo: TPanel
    Left = 0
    Top = 0
    Width = 976
    Height = 40
    Align = alTop
    TabOrder = 2
    object lblUser: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 11
      Width = 113
      Height = 25
      Margins.Top = 10
      Align = alLeft
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitHeight = 19
    end
  end
  object pnlSort: TPanel
    Left = 0
    Top = 94
    Width = 976
    Height = 35
    Align = alTop
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 544
      Height = 33
      Align = alLeft
      TabOrder = 0
      object lblAfter: TLabel
        Left = 1
        Top = 1
        Width = 113
        Height = 31
        Align = alLeft
        Caption = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1057' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 19
      end
      object lblPrev: TLabel
        Left = 300
        Top = 1
        Width = 34
        Height = 31
        Align = alLeft
        Caption = #1055#1054' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 19
      end
      object DateTimePickerPrev: TDateTimePicker
        Left = 334
        Top = 1
        Width = 186
        Height = 31
        Align = alLeft
        Date = 43584.193931261570000000
        Time = 43584.193931261570000000
        TabOrder = 0
        OnChange = Sorted
      end
      object DateTimePickerAfter: TDateTimePicker
        Left = 114
        Top = 1
        Width = 186
        Height = 31
        Align = alLeft
        Date = 43584.194361631950000000
        Time = 43584.194361631950000000
        TabOrder = 1
        OnChange = Sorted
      end
    end
    object cbbUser: TComboBox
      AlignWithMargins = True
      Left = 548
      Top = 4
      Width = 128
      Height = 27
      Align = alLeft
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = #1041#1077#1079' '#1092#1080#1083#1100#1090#1088#1072
      OnSelect = Sorted
      Items.Strings = (
        #1041#1077#1079' '#1092#1080#1083#1100#1090#1088#1072)
    end
  end
  object que_sql: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 584
    Top = 400
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=MyDatabase.dat;Pers' +
      'ist Security Info=False;Jet OLEDB:Database Password=1;Jet OLEDB:' +
      'Compact Without Replica Repair=True'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 512
    Top = 400
  end
  object dlgSave_Export: TSaveDialog
    Left = 420
    Top = 395
  end
  object pm1: TPopupMenu
    Left = 340
    Top = 395
    object N1: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnClick = btnClick
    end
    object N2: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
      OnClick = btnDelClick
    end
  end
end
