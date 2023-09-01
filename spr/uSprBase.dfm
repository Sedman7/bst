inherited fmSprBase: TfmSprBase
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    Top = 88
    Height = 473
    ExplicitTop = 88
    ExplicitWidth = 868
    ExplicitHeight = 473
    inherited grBaseDBTableView1: TcxGridDBTableView
      OnEditChanged = grBaseDBTableView1EditChanged
    end
  end
  inherited cxGroupBox1: TcxGroupBox
    inherited cxButEdit: TcxButton
      Visible = False
    end
  end
  inherited qBase: TZQuery
    Left = 48
  end
  inherited dsBase: TDataSource
    Left = 104
  end
  inherited ActionList1: TActionList
    Left = 296
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
  end
  inherited cxStyleRepository1: TcxStyleRepository
    Left = 384
    PixelsPerInch = 96
  end
end
