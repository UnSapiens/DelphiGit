object fmAutorization: TfmAutorization
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  ClientHeight = 184
  ClientWidth = 185
  Color = clBtnFace
  Constraints.MinHeight = 188
  Constraints.MinWidth = 187
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 184
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 193
    ExplicitHeight = 186
    DesignSize = (
      185
      184)
    object lbl1: TLabel
      Left = 32
      Top = 105
      Width = 3
      Height = 13
    end
    object lblUserName: TLabel
      Left = 32
      Top = 15
      Width = 93
      Height = 13
      Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    end
    object edtPass: TLabeledEdit
      Left = 32
      Top = 78
      Width = 137
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1086#1083#1100
      PasswordChar = '*'
      TabOrder = 0
      OnEnter = edtPassEnter
    end
    object btn1: TButton
      Left = 32
      Top = 152
      Width = 65
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1042#1086#1081#1090#1080
      TabOrder = 1
      OnClick = btn1Click
    end
    object btnExit: TButton
      Left = 103
      Top = 152
      Width = 66
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 2
      OnClick = btnExitClick
    end
    object cbbUserName: TComboBox
      Left = 32
      Top = 34
      Width = 137
      Height = 21
      TabOrder = 3
    end
  end
end
