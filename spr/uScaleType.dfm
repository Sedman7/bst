inherited fmSprScaleType: TfmSprScaleType
  Caption = #1058#1080#1087#1099' '#1087#1088#1080#1073#1086#1088#1086#1074' '#1091#1095#1077#1090#1072' ('#1055#1059')'
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    inherited grBaseDBTableView1: TcxGridDBTableView
      object grBaseDBTableView1idtype: TcxGridDBColumn
        Caption = 'id'
        DataBinding.FieldName = 'idtype'
        Width = 76
      end
      object grBaseDBTableView1kod: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'kod'
        Width = 131
      end
      object grBaseDBTableView1znach: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1089#1095#1077#1090#1095#1080#1082#1072
        DataBinding.FieldName = 'znach'
        Width = 228
      end
      object grBaseDBTableView1note: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'note'
        Width = 419
      end
    end
  end
  inherited qBase: TZQuery
    SQL.Strings = (
      'select * from spr.scaletype order by kod')
  end
  inherited ActionList1: TActionList
    inherited actDel: TAction
      OnExecute = actDelExecute
    end
  end
  inherited cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
  end
end
