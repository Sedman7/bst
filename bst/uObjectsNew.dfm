inherited fmObjectsNew: TfmObjectsNew
  BorderStyle = bsSingle
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
  ClientHeight = 335
  ClientWidth = 498
  ExplicitWidth = 504
  ExplicitHeight = 363
  PixelsPerInch = 96
  TextHeight = 13
  inherited Edit1: TEdit
    Left = 580
    Top = 393
    ExplicitLeft = 580
    ExplicitTop = 393
  end
  inherited cxGroupBox1: TcxGroupBox
    ExplicitWidth = 498
    Width = 498
    inherited cxButCreate: TcxButton
      Visible = False
    end
    inherited cxButEdit: TcxButton
      Visible = False
    end
    inherited cxButRefresh: TcxButton
      Visible = False
    end
    inherited cxButDel: TcxButton
      Visible = False
    end
  end
  object cxTextName: TcxTextEdit [2]
    Left = 8
    Top = 48
    Properties.OnChange = cxTextNamePropertiesChange
    TabOrder = 2
    Width = 162
  end
  object cxLabel1: TcxLabel [3]
    Left = 8
    Top = 33
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object cxGroupBox2: TcxGroupBox [4]
    Left = 8
    Top = 75
    Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077
    TabOrder = 4
    Height = 110
    Width = 385
    object cxLookupTown: TcxLookupComboBox
      Left = 3
      Top = 32
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'idtown'
      Properties.ListColumns = <
        item
          FieldName = 'name'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsTown
      Properties.OnChange = cxLookupComboBox1PropertiesChange
      TabOrder = 0
      Width = 159
    end
    object cxLabel2: TcxLabel
      Left = 3
      Top = 17
      Caption = #1053#1072#1089#1077#1083#1077#1085#1085#1099#1081' '#1087#1091#1085#1082#1090'*'
    end
    object cxLabel3: TcxLabel
      Left = 3
      Top = 56
      Caption = #1059#1083#1080#1094#1072
    end
    object cxLookupStreet: TcxLookupComboBox
      Left = 3
      Top = 72
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'idstreet'
      Properties.ListColumns = <
        item
          FieldName = 'name'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsStreet
      TabOrder = 3
      Width = 182
    end
    object cxDom: TcxCurrencyEdit
      Left = 200
      Top = 72
      Properties.DisplayFormat = '0'
      Properties.EditFormat = '0'
      TabOrder = 4
      OnKeyPress = cxDomKeyPress
      Width = 49
    end
    object cxLabel4: TcxLabel
      Left = 200
      Top = 56
      Caption = #1044#1086#1084
    end
    object cxKorp: TcxCurrencyEdit
      Left = 264
      Top = 72
      Properties.DisplayFormat = '#,0'
      TabOrder = 6
      Width = 41
    end
    object cxLabel5: TcxLabel
      Left = 264
      Top = 56
      Caption = #1050#1086#1088#1087#1091#1089
    end
    object cxInd: TcxTextEdit
      Left = 320
      Top = 72
      TabOrder = 8
      Width = 41
    end
    object cxLabel6: TcxLabel
      Left = 320
      Top = 56
      Caption = #1048#1085#1076#1077#1082#1089
    end
  end
  object cxLookupType: TcxLookupComboBox [5]
    Left = 8
    Top = 208
    Properties.DropDownRows = 16
    Properties.KeyFieldNames = 'idobjtype'
    Properties.ListColumns = <
      item
        FieldName = 'znach'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dsTypes
    Properties.OnChange = cxLookupTypePropertiesChange
    TabOrder = 5
    Width = 161
  end
  object cxLabel7: TcxLabel [6]
    Left = 8
    Top = 192
    Caption = #1058#1080#1087' '#1086#1073#1098#1077#1082#1090#1072'*'
  end
  object cxButton2: TcxButton [7]
    Left = 272
    Top = 280
    Width = 107
    Height = 25
    Action = actSave
    Anchors = [akRight, akBottom]
    TabOrder = 7
  end
  object cxButton3: TcxButton [8]
    Left = 392
    Top = 280
    Width = 97
    Height = 25
    Action = actCancel
    Anchors = [akRight, akBottom]
    TabOrder = 8
  end
  object cxCheckClose: TcxCheckBox [9]
    Left = 272
    Top = 308
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    State = cbsChecked
    TabOrder = 9
  end
  inherited qBase: TZQuery
    Left = 400
    Top = 8
  end
  inherited dsBase: TDataSource
    Left = 448
    Top = 8
  end
  inherited ActionList1: TActionList
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
    inherited actEraser: TAction
      OnExecute = actEraserExecute
    end
  end
  object qStreet: TZQuery
    Connection = Res.ZConnection1
    SQL.Strings = (
      
        'select * from main.streets where idtown = :PIDTOWN order by name' +
        ' ')
    Params = <
      item
        DataType = ftUnknown
        Name = 'PIDTOWN'
        ParamType = ptUnknown
      end>
    Left = 400
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PIDTOWN'
        ParamType = ptUnknown
      end>
  end
  object dsStreet: TDataSource
    DataSet = qStreet
    Left = 448
    Top = 112
  end
  object qTown: TZQuery
    Connection = Res.ZConnection1
    SQL.Strings = (
      'Select * from main.towns order by name')
    Params = <>
    Left = 400
    Top = 56
  end
  object dsTown: TDataSource
    DataSet = qTown
    Left = 448
    Top = 56
  end
  object qTypes: TZQuery
    Connection = Res.ZConnection1
    SQL.Strings = (
      'Select * from spr.objtype order by znach')
    Params = <>
    Left = 400
    Top = 160
  end
  object dsTypes: TDataSource
    DataSet = qTypes
    Left = 448
    Top = 160
  end
end
