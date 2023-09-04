inherited fmOwnersNew: TfmOwnersNew
  Caption = 'fmOwnersNew'
  ClientHeight = 271
  ClientWidth = 439
  ExplicitWidth = 455
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 13
  inherited Edit1: TEdit
    Left = 184
    Top = 40
    Height = 17
    Visible = True
    ExplicitLeft = 184
    ExplicitTop = 40
    ExplicitHeight = 17
  end
  inherited cxGroupBox1: TcxGroupBox
    ExplicitWidth = 439
    Width = 439
  end
  object cxButton2: TcxButton [2]
    Left = 224
    Top = 215
    Width = 106
    Height = 25
    Action = actSave
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object cxButton3: TcxButton [3]
    Left = 344
    Top = 215
    Width = 90
    Height = 25
    Action = actCancel
    Anchors = [akRight, akBottom]
    TabOrder = 3
  end
  object cxCheckClose: TcxCheckBox [4]
    Left = 224
    Top = 242
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    State = cbsChecked
    TabOrder = 4
  end
  object Panel1: TPanel [5]
    Left = 8
    Top = 40
    Width = 169
    Height = 193
    BevelEdges = []
    BevelInner = bvRaised
    BevelKind = bkFlat
    BevelOuter = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 5
    object cxLabel1: TcxLabel
      Left = 8
      Top = 8
      Caption = #1060#1072#1084#1080#1083#1080#1103
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 48
      Caption = #1048#1084#1103
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 88
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    end
    object Fam: TcxTextEdit
      Left = 8
      Top = 24
      TabOrder = 3
      Width = 153
    end
    object Name: TcxTextEdit
      Left = 8
      Top = 64
      TabOrder = 4
      Width = 153
    end
    object sName: TcxTextEdit
      Left = 8
      Top = 108
      TabOrder = 5
      Width = 153
    end
    object cxLabel4: TcxLabel
      Left = 8
      Top = 144
      Caption = #1058#1077#1083#1077#1092#1086#1085
    end
    object phone: TcxTextEdit
      Left = 8
      Top = 160
      TabOrder = 7
      Width = 153
    end
  end
  inherited qBase: TZQuery
    Left = 288
    Top = 72
  end
  inherited dsBase: TDataSource
    Left = 336
    Top = 72
  end
end
