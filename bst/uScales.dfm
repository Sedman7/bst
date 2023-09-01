inherited fmScales: TfmScales
  Caption = #1055#1088#1080#1073#1086#1088#1099' '#1091#1095#1077#1090#1072
  ClientHeight = 477
  ClientWidth = 725
  ExplicitWidth = 741
  ExplicitHeight = 515
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    Top = 112
    Width = 725
    Height = 349
    ExplicitTop = 112
    ExplicitWidth = 725
    ExplicitHeight = 349
    inherited grBaseDBTableView1: TcxGridDBTableView
      object grBaseDBTableView1idscale: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'idscale'
        Width = 61
      end
      object grBaseDBTableView1scalenumber: TcxGridDBColumn
        Caption = #1053#1086#1084#1077#1088
        DataBinding.FieldName = 'scalenumber'
        Width = 71
      end
      object grBaseDBTableView1idobject: TcxGridDBColumn
        Caption = #1054#1073#1098#1077#1082#1090
        DataBinding.FieldName = 'idobject'
        Width = 113
      end
      object grBaseDBTableView1scaletype: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1089#1095#1077#1090#1095#1080#1082#1072
        DataBinding.FieldName = 'scaletype'
        Width = 114
      end
      object grBaseDBTableView1kvt: TcxGridDBColumn
        Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103
        DataBinding.FieldName = 'kvt'
        Width = 102
      end
      object grBaseDBTableView1note: TcxGridDBColumn
        DataBinding.FieldName = 'note'
        Width = 83
      end
      object grBaseDBTableView1dateview: TcxGridDBColumn
        DataBinding.FieldName = 'dateview'
        Width = 83
      end
      object grBaseDBTableView1status: TcxGridDBColumn
        DataBinding.FieldName = 'status'
        Width = 84
      end
    end
  end
  inherited cxDBNavigator1: TcxDBNavigator
    Top = 459
    ExplicitTop = 327
  end
  inherited cxGroupBox1: TcxGroupBox
    Width = 725
  end
  inherited qBase: TZQuery
    Active = True
    SQL.Strings = (
      'select * from main.scales'
      'where status = 0')
    Left = 440
    Top = 8
  end
  inherited dsBase: TDataSource
    Left = 488
    Top = 8
  end
  inherited cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
  end
end
