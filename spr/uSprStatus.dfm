inherited fmSprStatus: TfmSprStatus
  Caption = #1057#1090#1072#1090#1091#1089#1099
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    inherited grBaseDBTableView1: TcxGridDBTableView
      object grBaseDBTableView1idstatus: TcxGridDBColumn
        Caption = 'id'
        DataBinding.FieldName = 'idstatus'
        Width = 133
      end
      object grBaseDBTableView1kod: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'kod'
        Width = 173
      end
      object grBaseDBTableView1znach: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'znach'
        Width = 548
      end
    end
  end
  inherited cxGroupBox1: TcxGroupBox
    ExplicitWidth = 868
  end
  inherited qBase: TZQuery
    Active = True
    SQL.Strings = (
      'select * from spr.status')
  end
  inherited cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
  end
end
