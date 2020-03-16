object frmStatesZoneMap: TfrmStatesZoneMap
  Left = 0
  Top = 0
  Caption = #1050#1072#1088#1090#1072' '#1079#1086#1085
  ClientHeight = 609
  ClientWidth = 924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnMap: TPanel
    Left = 0
    Top = 218
    Width = 924
    Height = 391
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 41
    ExplicitHeight = 568
    object mcCarsPlaces: TdxMapControl
      Left = 0
      Top = 0
      Width = 924
      Height = 391
      Align = alClient
      BorderStyle = cxcbsNone
      NavigationPanel.ShowMilesScale = False
      NavigationPanel.Style.CoordinateFont.Charset = DEFAULT_CHARSET
      NavigationPanel.Style.CoordinateFont.Color = clWindowText
      NavigationPanel.Style.CoordinateFont.Height = -21
      NavigationPanel.Style.CoordinateFont.Name = 'Tahoma'
      NavigationPanel.Style.CoordinateFont.Style = []
      NavigationPanel.Style.ScaleFont.Charset = DEFAULT_CHARSET
      NavigationPanel.Style.ScaleFont.Color = clWindowText
      NavigationPanel.Style.ScaleFont.Height = -16
      NavigationPanel.Style.ScaleFont.Name = 'Tahoma'
      NavigationPanel.Style.ScaleFont.Style = []
      NavigationPanel.Visible = False
      NavigationPanel.XCoordinateDisplayMask = '0'
      NavigationPanel.YCoordinateDisplayMask = '0'
      OptionsBehavior.MapItemSelectMode = mismSingle
      PopupMenu = pmRightClickOnMap
      TabOrder = 0
      ZoomLevel = 14.000000000000000000
      ExplicitLeft = 1
      ExplicitTop = 5
      ExplicitWidth = 922
      ExplicitHeight = 282
      object mlBingMap: TdxMapImageTileLayer
        ProviderClassName = 'TdxMapControlBingMapImageryDataProvider'
      end
      object ilPolyLines: TdxMapItemLayer
        ProjectionClassName = 'TdxMapControlSphericalMercatorProjection'
      end
      object ilCarsPoints: TdxMapItemLayer
        ProjectionClassName = 'TdxMapControlSphericalMercatorProjection'
      end
    end
  end
  object pnToolBox: TPanel
    Left = 0
    Top = 177
    Width = 924
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  object pnGrid: TPanel
    Left = 0
    Top = 0
    Width = 924
    Height = 177
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 183
    object DBGridEh1: TDBGridEh
      Left = 0
      Top = 0
      Width = 924
      Height = 177
      Align = alClient
      Ctl3D = False
      DynProps = <>
      ParentCtl3D = False
      TabOrder = 0
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object pmRightClickOnMap: TPopupMenu
    Left = 384
    Top = 290
    object miAddZone: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1086#1085#1091
    end
  end
end
