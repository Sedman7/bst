inherited fmUsers: TfmUsers
  Caption = 'fmUsers'
  ClientHeight = 559
  ClientWidth = 916
  FormStyle = fsMDIChild
  Visible = True
  ExplicitWidth = 932
  ExplicitHeight = 597
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    Top = 78
    Width = 313
    Height = 457
    Anchors = [akLeft, akTop, akBottom]
    ExplicitTop = 78
    ExplicitWidth = 313
    ExplicitHeight = 457
    inherited grBaseDBTableView1: TcxGridDBTableView
      OnCellClick = grBaseDBTableView1CellClick
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object grBaseDBTableView1iduser: TcxGridDBColumn
        Caption = 'id'
        DataBinding.FieldName = 'iduser'
        Width = 33
      end
      object grBaseDBTableView1ulogin: TcxGridDBColumn
        Caption = #1051#1086#1075#1080#1085
        DataBinding.FieldName = 'ulogin'
        Width = 95
      end
      object grBaseDBTableView1statustext: TcxGridDBColumn
        Caption = #1057#1090#1072#1090#1091#1089
        DataBinding.FieldName = 'statustext'
        Width = 61
      end
    end
  end
  inherited cxDBNavigator1: TcxDBNavigator
    Top = 541
    ExplicitTop = 541
  end
  object cxGridRoles: TcxGrid [2]
    Left = 319
    Top = 412
    Width = 589
    Height = 127
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
    object cxGridRolesDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsRole
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridRolesDBTableView1id: TcxGridDBColumn
        DataBinding.FieldName = 'id'
        Visible = False
        Styles.Header = cxStyleHeaderBold
        Width = 50
      end
      object cxGridRolesDBTableView1userole: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
        DataBinding.FieldName = 'userole'
        Styles.Header = cxStyleHeaderBold
        Width = 91
      end
      object cxGridRolesDBTableView1rolename: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'rolename'
        Styles.Header = cxStyleHeaderBold
        Width = 140
      end
      object cxGridRolesDBTableView1describe: TcxGridDBColumn
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1088#1086#1083#1080
        DataBinding.FieldName = 'describe'
        Styles.Header = cxStyleHeaderBold
        Width = 346
      end
    end
    object cxGridRolesLevel1: TcxGridLevel
      GridView = cxGridRolesDBTableView1
    end
  end
  object cxDBTextEdit1: TcxDBTextEdit [3]
    Left = 319
    Top = 96
    DataBinding.DataField = 'iduser'
    DataBinding.DataSource = dsBase
    Enabled = False
    TabOrder = 6
    Width = 34
  end
  object cxLabel1: TcxLabel [4]
    Left = 319
    Top = 81
    Caption = 'id'
  end
  object cxDBDateEdit1: TcxDBDateEdit [5]
    Left = 368
    Top = 96
    DataBinding.DataField = 'regdate'
    DataBinding.DataSource = dsBase
    Enabled = False
    Properties.DateButtons = [btnClear]
    TabOrder = 8
    Width = 97
  end
  object cxLabel2: TcxLabel [6]
    Left = 368
    Top = 81
    Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
  end
  object cxLabel3: TcxLabel [7]
    Left = 319
    Top = 122
    Caption = #1051#1086#1075#1080#1085
  end
  object cxLabel4: TcxLabel [8]
    Left = 319
    Top = 396
    Anchors = [akLeft, akBottom]
    Caption = #1056#1086#1083#1080
  end
  object cxLabel6: TcxLabel [9]
    Left = 319
    Top = 162
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object cxTextPass1: TcxTextEdit [10]
    Left = 319
    Top = 176
    Enabled = False
    TabOrder = 12
    Width = 147
  end
  object cxTextPass2: TcxTextEdit [11]
    Left = 319
    Top = 200
    Enabled = False
    TabOrder = 14
    Width = 147
  end
  object cxLabel7: TcxLabel [12]
    Left = 319
    Top = 275
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
  end
  inherited Edit1: TEdit
    Left = 776
    Top = 55
    ExplicitLeft = 776
    ExplicitTop = 55
  end
  inherited cxGroupBox1: TcxGroupBox
    ExplicitWidth = 916
    Width = 916
  end
  object cxTextuLogin: TcxTextEdit [15]
    Left = 319
    Top = 136
    Enabled = False
    TabOrder = 15
    Width = 146
  end
  object cxMemoNote: TcxMemo [16]
    Left = 319
    Top = 296
    Anchors = [akLeft, akTop, akRight, akBottom]
    Enabled = False
    TabOrder = 16
    Height = 94
    Width = 590
  end
  object cxCheckBlock: TcxCheckBox [17]
    Left = 319
    Top = 227
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1079#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsFlat
    Style.Color = clBtnFace
    Style.HotTrack = True
    Style.LookAndFeel.Kind = lfFlat
    Style.LookAndFeel.NativeStyle = True
    Style.Shadow = False
    Style.TextColor = clRed
    StyleDisabled.LookAndFeel.Kind = lfFlat
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfFlat
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfFlat
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 17
  end
  object cxDBTextEdit2: TcxDBTextEdit [18]
    Left = 472
    Top = 200
    DataBinding.DataField = 'pass'
    DataBinding.DataSource = dsBase
    Enabled = False
    TabOrder = 18
    Width = 257
  end
  object cxLabel8: TcxLabel [19]
    Left = 472
    Top = 185
    Caption = 'md5'
    Enabled = False
  end
  object cxCheckLog: TcxCheckBox [20]
    Left = 319
    Top = 248
    Caption = #1051#1086#1075#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1081
    State = cbsChecked
    TabOrder = 20
  end
  object cxChecFullDell: TcxCheckBox [21]
    Left = 85
    Top = 31
    Caption = #1059#1076#1072#1083#1103#1090#1100' '#1080#1079' '#1073#1072#1079#1099
    TabOrder = 21
  end
  object EditULogin: TEdit [22]
    Left = 66
    Top = 55
    Width = 151
    Height = 21
    TabOrder = 22
    OnChange = EditULoginChange
  end
  object cxLookupStatus: TcxLookupComboBox [23]
    Left = 215
    Top = 55
    Properties.KeyFieldNames = 'kod'
    Properties.ListColumns = <
      item
        FieldName = 'znach'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dsStat
    Properties.OnChange = cxLookupStatusPropertiesChange
    TabOrder = 23
    Width = 98
  end
  inherited qBase: TZQuery
    SQL.Strings = (
      
        'select iduser,idclient,ulogin,pass,regdate, znach as statustext,' +
        ' status, note'
      'from org.users us'
      'join spr.status st on st.kod = us.status '
      'where us.ulogin <>  '#39'default'#39
      'order by ulogin'
      '')
    Left = 224
  end
  inherited dsBase: TDataSource
    Left = 272
  end
  inherited ActionList1: TActionList
    Left = 488
    inherited actCreate: TAction
      ImageIndex = 8
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
    inherited actDel: TAction
      OnExecute = actDelExecute
    end
    inherited actEraser: TAction
      OnExecute = actEraserExecute
    end
  end
  inherited cxStyleRepository1: TcxStyleRepository
    Left = 608
    PixelsPerInch = 96
  end
  object qRole: TZQuery
    Connection = Res.ZConnection1
    SQL.Strings = (
      
        'select ur.id, ur.userole, ur.rolename, ro."describe" from org.us' +
        'er_roles ur  '
      'join org.roles ro on ur.rolename = ro.rolename '
      'where iduser=:piduser'
      'order by ro.idrole')
    Params = <
      item
        DataType = ftUnknown
        Name = 'piduser'
        ParamType = ptUnknown
      end>
    Left = 328
    Top = 440
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'piduser'
        ParamType = ptUnknown
      end>
    object qRoleuserole: TBooleanField
      FieldName = 'userole'
      ReadOnly = True
    end
    object qRolerolename: TWideStringField
      FieldName = 'rolename'
      ReadOnly = True
      Required = True
      Size = 50
    end
    object qRoledescribe: TWideStringField
      FieldName = 'describe'
      ReadOnly = True
      Size = 250
    end
  end
  object dsRole: TDataSource
    DataSet = qRole
    Left = 368
    Top = 440
  end
  object qStat: TZQuery
    Connection = Res.ZConnection1
    SQL.Strings = (
      'select * from spr.status ')
    Params = <>
    Left = 224
    Top = 32
  end
  object dsStat: TDataSource
    DataSet = qStat
    Left = 264
    Top = 32
  end
end
