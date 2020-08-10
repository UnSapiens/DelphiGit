object fmRedact: TfmRedact
  Left = 0
  Top = 0
  Caption = #1054#1089#1084#1086#1090#1088
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 256
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 152
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblTreatment: TLabel
      Left = 351
      Top = 55
      Width = 73
      Height = 19
      Caption = #1051#1077#1095#1077#1085#1080#1077' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDiagnosis: TLabel
      Left = 32
      Top = 127
      Width = 71
      Height = 19
      Caption = #1044#1080#1072#1075#1085#1086#1079' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbbChangeMed: TComboBox
      Left = 351
      Top = 16
      Width = 265
      Height = 21
      TabOrder = 0
      Text = #1060#1048#1054' '#1074#1088#1072#1095#1072
    end
    object DateTimePicker: TDateTimePicker
      Left = 32
      Top = 16
      Width = 129
      Height = 21
      Date = 43583.930656284720000000
      Time = 43583.930656284720000000
      TabOrder = 1
    end
    object lblFio: TLabeledEdit
      Left = 32
      Top = 59
      Width = 265
      Height = 21
      EditLabel.Width = 74
      EditLabel.Height = 13
      EditLabel.Caption = #1060#1048#1054' '#1087#1072#1094#1080#1077#1085#1090#1072
      TabOrder = 2
    end
    object lblPolisNumber: TLabeledEdit
      Left = 32
      Top = 99
      Width = 265
      Height = 21
      EditLabel.Width = 69
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1086#1084#1077#1088' '#1087#1086#1083#1080#1089#1072
      TabOrder = 3
    end
    object lblPrice: TLabeledEdit
      Left = 351
      Top = 221
      Width = 144
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #1062#1077#1085#1072
      TabOrder = 4
      OnKeyPress = lblPriceKeyPress
    end
    object DateTimePickerTime: TDateTimePicker
      Left = 167
      Top = 16
      Width = 130
      Height = 21
      Date = 43584.034080752320000000
      Time = 43584.034080752320000000
      Kind = dtkTime
      TabOrder = 5
    end
    object MemoDiagnosis: TMemo
      Left = 32
      Top = 152
      Width = 265
      Height = 98
      Lines.Strings = (
        'MemoDiagnosis')
      TabOrder = 6
    end
    object MemoTreatment: TMemo
      Left = 351
      Top = 80
      Width = 265
      Height = 124
      Lines.Strings = (
        'MemoTreatment')
      TabOrder = 7
    end
    object cbbPatient: TComboBox
      Left = 32
      Top = 57
      Width = 265
      Height = 21
      Style = csDropDownList
      TabOrder = 8
      Visible = False
      OnSelect = cbbPatientSelect
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 256
    Width = 635
    Height = 44
    Align = alBottom
    TabOrder = 1
    object btnClose: TSpeedButton
      Left = 544
      Top = 1
      Width = 90
      Height = 42
      Align = alRight
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnClick = btnCloseClick
      ExplicitLeft = 550
      ExplicitTop = 6
    end
    object btnSubmit: TSpeedButton
      Left = 454
      Top = 1
      Width = 90
      Height = 42
      Align = alRight
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnClick = btnSubmitClick
      ExplicitLeft = 544
    end
  end
end
