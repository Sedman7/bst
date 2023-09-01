object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'fmMain'
  ClientHeight = 439
  ClientWidth = 831
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dxMainStatus: TdxStatusBar
    Left = 0
    Top = 419
    Width = 831
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarKeyboardStatePanelStyle'
        PanelStyle.CapsLockKeyAppearance.ActiveCaption = 'CAPS'
        PanelStyle.CapsLockKeyAppearance.InactiveCaption = 'CAPS'
        PanelStyle.NumLockKeyAppearance.ActiveCaption = 'NUM'
        PanelStyle.NumLockKeyAppearance.InactiveCaption = 'NUM'
        PanelStyle.ScrollLockKeyAppearance.ActiveCaption = 'SCRL'
        PanelStyle.ScrollLockKeyAppearance.InactiveCaption = 'SCRL'
        PanelStyle.InsertKeyAppearance.ActiveCaption = 'OVR'
        PanelStyle.InsertKeyAppearance.InactiveCaption = 'INS'
        Width = 124
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Fixed = False
        Text = 'Status ok...'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Color = clWhite
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object MainMenu1: TMainMenu
    Left = 752
    Top = 16
    object N1: TMenuItem
      Caption = #1043#1083#1072#1074#1085#1086#1077
      object N2: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32856
        OnClick = N2Click
      end
    end
    object N3: TMenuItem
      Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072
      object N4: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090#1099
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1057#1086#1073#1089#1090#1074#1077#1085#1085#1080#1082#1080
        OnClick = N5Click
      end
      object N20: TMenuItem
        Caption = #1055#1088#1080#1073#1086#1088#1099' '#1091#1095#1077#1090#1072
        OnClick = N20Click
      end
    end
    object N8: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object N11: TMenuItem
        Caption = #1058#1077#1088#1088#1080#1090#1086#1088#1080#1072#1083#1100#1085#1099#1077
        object N13: TMenuItem
          Caption = #1053#1072#1089'. '#1087#1091#1085#1082#1090#1099
        end
        object N12: TMenuItem
          Caption = #1059#1083#1080#1094#1099
        end
      end
      object N14: TMenuItem
        Caption = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077
        object N15: TMenuItem
          Caption = #1058#1080#1087#1099' '#1055#1059
          OnClick = N15Click
        end
        object N16: TMenuItem
          Caption = #1052#1086#1076#1077#1083#1080' '#1055#1059
        end
      end
      object N9: TMenuItem
        Caption = #1054#1073#1097#1080#1077
        object N10: TMenuItem
          Caption = #1057#1090#1072#1090#1091#1089#1099
          OnClick = N10Click
        end
      end
    end
    object N6: TMenuItem
      Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
      object N7: TMenuItem
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
        OnClick = N7Click
      end
    end
    object N17: TMenuItem
      Caption = #1054#1082#1085#1086
      object N18: TMenuItem
        Caption = #1050#1072#1089#1082#1072#1076
        OnClick = N18Click
      end
      object N19: TMenuItem
        Caption = #1052#1086#1079#1072#1081#1082#1072
        OnClick = N19Click
      end
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 560
    Top = 112
    DockControlHeights = (
      0
      0
      0
      0)
  end
end
