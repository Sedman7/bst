inherited fmBaseGrid: TfmBaseGrid
  Caption = 'fmBaseGrid'
  ClientHeight = 345
  ClientWidth = 624
  ExplicitWidth = 640
  ExplicitHeight = 383
  DesignSize = (
    624
    345)
  PixelsPerInch = 96
  TextHeight = 13
  object grBase: TcxGrid [0]
    Left = 0
    Top = 152
    Width = 624
    Height = 177
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object grBaseDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsBase
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.HeaderHeight = 25
      OptionsView.Indicator = True
      Styles.ContentOdd = cxStyleOdd
      Styles.Header = cxStyleHeaderBold
    end
    object grBaseLevel1: TcxGridLevel
      GridView = grBaseDBTableView1
    end
  end
  object cxDBNavigator1: TcxDBNavigator [1]
    Left = 0
    Top = 327
    Width = 180
    Height = 19
    Buttons.CustomButtons = <>
    Buttons.Insert.Enabled = False
    Buttons.Insert.Visible = False
    Buttons.Delete.Enabled = False
    Buttons.Delete.Visible = False
    Buttons.Edit.Enabled = False
    Buttons.Edit.Visible = False
    Buttons.Post.Enabled = False
    Buttons.Post.Visible = False
    Buttons.Cancel.Enabled = False
    Buttons.Cancel.Visible = False
    DataSource = dsBase
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  inherited Edit1: TEdit
    TabOrder = 1
  end
  inherited cxGroupBox1: TcxGroupBox
    TabOrder = 3
    ExplicitWidth = 624
    Width = 624
  end
  inherited qBase: TZQuery
    Left = 40
    Top = 144
  end
  inherited dsBase: TDataSource
    Left = 88
    Top = 144
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 360
    PixelsPerInch = 96
    object cxStyleHeaderBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyleOdd: TcxStyle
      AssignedValues = [svColor]
      Color = 16445680
    end
  end
end
