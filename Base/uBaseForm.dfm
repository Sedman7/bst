object fmBaseForm: TfmBaseForm
  Left = 0
  Top = 0
  Caption = 'fmBaseForm'
  ClientHeight = 422
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 288
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    Visible = False
  end
  object cxGroupBox1: TcxGroupBox
    Left = 0
    Top = 0
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BiDiMode = bdLeftToRight
    Ctl3D = True
    PanelStyle.Active = True
    PanelStyle.OfficeBackgroundKind = pobkGradient
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderColor = clSilver
    Style.BorderStyle = ebsNone
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = False
    Style.TransparentBorder = False
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 1
    Height = 25
    Width = 709
    object cxExit: TcxButton
      Left = 0
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actExit
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object cxButSave: TcxButton
      Left = 120
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actSave
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object cxSplitter1: TcxSplitter
      Left = 25
      Top = 0
      Width = 10
      Height = 25
      Color = clBtnShadow
      ParentColor = False
    end
    object cxButCreate: TcxButton
      Left = 35
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actCreate
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object cxButCancel: TcxButton
      Left = 145
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actCancel
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object cxButEdit: TcxButton
      Left = 60
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actEdit
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object cxButRefresh: TcxButton
      Left = 205
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actRefresh
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object cxSplitter2: TcxSplitter
      Left = 170
      Top = 0
      Width = 10
      Height = 25
      Color = clBtnShadow
      ParentColor = False
    end
    object cxButDel: TcxButton
      Left = 85
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actDel
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
    object cxButton1: TcxButton
      Left = 180
      Top = 0
      Width = 25
      Height = 25
      Align = alLeft
      Action = actEraser
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object cxSplitter3: TcxSplitter
      Left = 110
      Top = 0
      Width = 10
      Height = 25
      Color = clBtnShadow
      ParentColor = False
    end
  end
  object qBase: TZQuery
    Connection = Res.ZConnection1
    Params = <>
    Left = 16
    Top = 88
  end
  object dsBase: TDataSource
    DataSet = qBase
    Left = 64
    Top = 88
  end
  object ActionList1: TActionList
    Images = Res.cxImageList1
    Left = 272
    object actExit: TAction
      ImageIndex = 0
      OnExecute = actExitExecute
    end
    object actCreate: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      ImageIndex = 1
      OnExecute = actCreateExecute
    end
    object actSave: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 2
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1072
      ImageIndex = 3
    end
    object actEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 6
      OnExecute = actEditExecute
    end
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 5
      OnExecute = actRefreshExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 10
    end
    object actEraser: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 11
    end
  end
end
