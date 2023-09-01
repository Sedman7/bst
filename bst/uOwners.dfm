inherited fmOwners: TfmOwners
  Caption = #1046#1080#1083#1100#1094#1099'/'#1042#1083#1072#1076#1077#1083#1100#1094#1099
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    Top = 88
    Height = 473
    ExplicitTop = 88
    ExplicitHeight = 473
    inherited grBaseDBTableView1: TcxGridDBTableView
      object grBaseDBTableView1idowner: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'idowner'
        Width = 90
      end
      object grBaseDBTableView1idobject: TcxGridDBColumn
        Caption = #1054#1073#1098#1077#1082#1090
        DataBinding.FieldName = 'idobject'
        Width = 159
      end
      object grBaseDBTableView1fam: TcxGridDBColumn
        Caption = #1060#1072#1084#1080#1083#1080#1103
        DataBinding.FieldName = 'fam'
        Width = 159
      end
      object grBaseDBTableView1name: TcxGridDBColumn
        Caption = #1048#1084#1103
        DataBinding.FieldName = 'name'
        Width = 160
      end
      object grBaseDBTableView1sname: TcxGridDBColumn
        Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        DataBinding.FieldName = 'sname'
        Width = 158
      end
      object grBaseDBTableView1phone: TcxGridDBColumn
        Caption = #1058#1077#1083#1077#1092#1086#1085
        DataBinding.FieldName = 'phone'
        Width = 159
      end
      object grBaseDBTableView1ownertype: TcxGridDBColumn
        Caption = #1057#1090#1072#1090#1091#1089
        DataBinding.FieldName = 'ownertype'
        Width = 159
      end
    end
  end
  inherited qBase: TZQuery
    SQL.Strings = (
      'select * '
      'from main.owners')
    Left = 944
    Top = 136
  end
  inherited dsBase: TDataSource
    Left = 984
    Top = 136
  end
  inherited ActionList1: TActionList
    Left = 952
  end
  inherited cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
  end
end
