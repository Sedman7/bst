object fmLogin: TfmLogin
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 152
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxLogin: TcxTextEdit
    Left = 8
    Top = 24
    TabOrder = 0
    Width = 153
  end
  object cxPass: TcxTextEdit
    Left = 167
    Top = 24
    TabOrder = 1
    Width = 139
  end
  object cxButEnter0: TcxButton
    Left = 32
    Top = 119
    Width = 168
    Height = 25
    Caption = #1042#1093#1086#1076
    TabOrder = 2
    OnClick = cxButEnter0Click
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 9
    Caption = #1051#1086#1075#1080#1085
  end
  object cxLabel2: TcxLabel
    Left = 185
    Top = 8
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object cxServer: TEdit
    Left = 8
    Top = 70
    Width = 228
    Height = 21
    TabOrder = 5
    Text = '188.225.76.242'
  end
  object cxLabel3: TcxLabel
    Left = 8
    Top = 55
    Caption = #1057#1077#1088#1074#1077#1088
  end
  object cxPort: TEdit
    Left = 242
    Top = 70
    Width = 64
    Height = 21
    TabOrder = 7
    Text = '5432'
  end
  object cxLabel4: TcxLabel
    Left = 242
    Top = 51
    Caption = #1055#1086#1088#1090
  end
  object cxButton1: TcxButton
    Left = 231
    Top = 119
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 9
    OnClick = cxButton1Click
  end
end
