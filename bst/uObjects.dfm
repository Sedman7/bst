inherited fmObjects: TfmObjects
  Caption = 'fmObjects'
  ClientHeight = 530
  ClientWidth = 1056
  FormStyle = fsMDIChild
  Position = poDesigned
  Visible = True
  ExplicitWidth = 1072
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 13
  inherited grBase: TcxGrid
    Top = 112
    Width = 1056
    Height = 400
    ExplicitTop = 112
    ExplicitWidth = 1056
    ExplicitHeight = 400
    inherited grBaseDBTableView1: TcxGridDBTableView
      OptionsData.Editing = False
      OptionsData.Inserting = False
      object grBaseDBTableView1idobject: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'idobject'
        Width = 47
      end
      object grBaseDBTableView1name: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'name'
        Width = 130
      end
      object grBaseDBTableView1name_1: TcxGridDBColumn
        Caption = #1059#1083#1080#1094#1072
        DataBinding.FieldName = 'name_1'
        Width = 119
      end
      object grBaseDBTableView1dom: TcxGridDBColumn
        Caption = #8470' '#1044#1086#1084#1072
        DataBinding.FieldName = 'dom'
        Width = 58
      end
      object grBaseDBTableView1domkorp: TcxGridDBColumn
        Caption = #1050#1086#1088#1087#1091#1089
        DataBinding.FieldName = 'domkorp'
        Width = 53
      end
      object grBaseDBTableView1domindex: TcxGridDBColumn
        Caption = #1048#1085#1076#1077#1082#1089
        DataBinding.FieldName = 'domindex'
        Width = 56
      end
      object grBaseDBTableView1fio: TcxGridDBColumn
        Caption = #1060#1080#1086' '#1074#1083#1072#1076#1077#1083#1100#1094#1072
        DataBinding.FieldName = 'fio'
        Width = 174
      end
      object grBaseDBTableView1phone: TcxGridDBColumn
        Caption = #1058#1077#1083#1077#1092#1086#1085
        DataBinding.FieldName = 'phone'
        Width = 110
      end
      object grBaseDBTableView1znach: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1086#1073#1098#1077#1082#1090#1072
        DataBinding.FieldName = 'znach'
        Width = 107
      end
    end
    object grBaseDBTableView2: TcxGridDBTableView [1]
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object grBaseDBTableView3: TcxGridDBTableView [2]
      Navigator.Buttons.CustomButtons = <>
      DataController.MasterKeyFieldNames = 'idobject'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
  end
  inherited cxDBNavigator1: TcxDBNavigator
    Top = 512
    ExplicitTop = 512
  end
  object Button1: TButton [2]
    Left = 170
    Top = 46
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
  end
  inherited cxGroupBox1: TcxGroupBox
    TabOrder = 4
    ExplicitWidth = 1056
    Width = 1056
    inherited cxButSave: TcxButton
      Visible = False
    end
    inherited cxButCancel: TcxButton
      Visible = False
    end
  end
  inherited qBase: TZQuery
    SQL.Strings = (
      'select '#9'ob.idobject, ob.name, ot.znach, st."name", '
      #9#9'ob.dom, ob.domkorp, ob.domindex, '
      
        #9#9'ow.fam||'#39' '#39'||substring(ow."name" from 1 for 1)||'#39'. '#39'||substrin' +
        'g(ow.sname from 1 for 1)||'#39'.'#39' as fio,'
      #9#9'ow.phone '
      'from main.objects ob '
      'left join main.streets st on st.idstreet=ob.idstreet'
      'join spr.objtype ot on ob.objtype = ot.idobjtype '
      'left join main.owners ow on ow.idobject = ob.idobject '
      'where ob.status=0'
      'order by ob.dom')
    Left = 536
    Top = 8
  end
  inherited dsBase: TDataSource
    Left = 576
    Top = 8
  end
  inherited ActionList1: TActionList
    inherited actDel: TAction
      OnExecute = actDelExecute
    end
  end
  inherited cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
  end
  object dsAddInfo: TDataSource
    DataSet = qAddInfo
    Left = 712
    Top = 8
  end
  object qAddInfo: TZQuery
    Connection = Res.ZConnection1
    SQL.Strings = (
      'Select * from main.owners')
    Params = <>
    Left = 656
    Top = 8
    object qAddInfoidowner: TIntegerField
      FieldName = 'idowner'
      Required = True
    end
    object qAddInfoidobject: TIntegerField
      FieldName = 'idobject'
    end
    object qAddInfofam: TWideMemoField
      FieldName = 'fam'
      BlobType = ftWideMemo
    end
    object qAddInfoname: TWideMemoField
      FieldName = 'name'
      BlobType = ftWideMemo
    end
    object qAddInfosname: TWideMemoField
      FieldName = 'sname'
      BlobType = ftWideMemo
    end
    object qAddInfophone: TWideMemoField
      FieldName = 'phone'
      BlobType = ftWideMemo
    end
    object qAddInfoownertype: TIntegerField
      FieldName = 'ownertype'
    end
  end
end
