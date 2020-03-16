unit uMapStatesZone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxMapControlTypes,
  dxMapControlBingMapImageryDataProvider, dxCustomMapItemLayer, dxMapItemLayer,
  cxClasses, dxMapLayer, dxMapImageTileLayer, dxMapControl, Vcl.ExtCtrls,
  Vcl.Menus, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TfrmStatesZoneMap = class(TForm)
    pnMap: TPanel;
    mcCarsPlaces: TdxMapControl;
    mlBingMap: TdxMapImageTileLayer;
    ilPolyLines: TdxMapItemLayer;
    ilCarsPoints: TdxMapItemLayer;
    pnGrid: TPanel;
    DBGridEh1: TDBGridEh;
    pnToolBox: TPanel;
    pmRightClickOnMap: TPopupMenu;
    miAddZone: TMenuItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AddZone(const ALatitude, ALongitude:Double);
    procedure ZoomInToCenterMoscow;
  public
    { Public declarations }
  end;

var
  frmStatesZoneMap: TfrmStatesZoneMap;

implementation

uses uSpyTaxiConst;
{$R *.dfm}

procedure TfrmStatesZoneMap.AddZone(const ALatitude, ALongitude: Double);
begin

end;

procedure TfrmStatesZoneMap.FormCreate(Sender: TObject);
begin
  (mlBingMap.Provider as TdxMapControlBingMapImageryDataProvider).BingKey := constBingAPIKey;

  ZoomInToCenterMoscow;
end;

procedure TfrmStatesZoneMap.ZoomInToCenterMoscow;
var
  lGeoRect: TdxMapControlGeoRect;
begin
  lGeoRect.TopLeft.Latitude := constCenterMoscowTopLeftLatitude;
  lGeoRect.TopLeft.Longitude := constCenterMoscowTopLeftLongitude;

  lGeoRect.BottomRight.Latitude := constCenterMoscowRightLatitude;
  lGeoRect.BottomRight.Longitude := constCenterMoscowRightLongitude;
  mcCarsPlaces.ZoomToGeoRect(lGeoRect);
end;

end.
