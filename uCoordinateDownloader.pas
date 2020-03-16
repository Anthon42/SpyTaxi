unit uCoordinateDownloader;

interface

uses uSpyTaxiTypes, uEventTypes, uDataConstantStorage;

type
  TDownloadCooridnateEvent = procedure(const AZonePosition: TZonePosition) of object;

  TCoordinateDownloader = class(TObject)
  strict private
    FOnDownloadCooridnate: TDownloadCooridnateEvent;
    FOnLogMessage: TLogMessageMethod;
    FDataConstantStorage: TDataConstantStorage;

    procedure DoDownloadCooridnate(const AZonePosition: TZonePosition);
    procedure DoLogMessage(const AValue: string; AEventType: TEventType);
  public
    property OnDownloadCooridnate: TDownloadCooridnateEvent read FOnDownloadCooridnate write FOnDownloadCooridnate;
    property OnLogMessage: TLogMessageMethod read FOnLogMessage write FOnLogMessage;

    procedure DownloadCoordinate;

    constructor Create(const ADBConnectionParams: TDBConnectionParams);
  end;

implementation

uses System.SysUtils, uCommonCreator, uMKCommonData, uMKUtils, uErrorMessageFormatter;

const
  constSQLDownloadCoordinate = 'select d.* from default_coordinates d';
  constLatitudeParamName = 'latitude';
  constLongitudeParamName = 'longitude';

constructor TCoordinateDownloader.Create(const ADBConnectionParams: TDBConnectionParams);
var
  lErrorStr: string;
begin
  InitializeCommonCreator(nil, ADBConnectionParams);

  if not TCommonCreator.InitializeConstantStorage(nil, FDataConstantStorage, lErrorStr) then
  begin
    raise Exception.Create(Self.ClassName + '.Create: ' + lErrorStr);
  end;
end;

procedure TCoordinateDownloader.DoDownloadCooridnate(const AZonePosition: TZonePosition);
begin
  if Assigned(FOnDownloadCooridnate) then
  begin
    FOnDownloadCooridnate(AZonePosition);
  end;
end;

procedure TCoordinateDownloader.DoLogMessage(const AValue: string; AEventType: TEventType);
begin
  if Assigned(FOnLogMessage) then
  begin
    FOnLogMessage(AValue, AEventType);
  end;
end;

procedure TCoordinateDownloader.DownloadCoordinate;
var
  lCommonDataList: TCommonDataList;
  lErrorStr: string;
  lScriptIndex: Integer;
  lCommonData: TCommonData;
  lZonePosition: TZonePosition;
begin
  if not Assigned(FOnDownloadCooridnate) then
  begin
    DoLogMessage(Self.ClassName + 'Не создан метод FOnDownloadCooridnate', etError);
    Exit;
  end;

  lCommonDataList := TCommonDataList.Create(nil);

  try
    if not FDataConstantStorage.LoadCommonDataList(constSQLDownloadCoordinate, lCommonDataList) then
    begin
      lErrorStr := TErrorMessageFormatter.ErrorRunMethodMessage(Self, 'DownloadCoordinate',
        'Невозможно загрузить координаты из бд');
      DoLogMessage(lErrorStr, etError);
      Exit;
    end;

    for lScriptIndex := 0 to lCommonDataList.CommonDataCount - 1 do
    begin
      lCommonData := lCommonDataList.CommonData[lScriptIndex];

      lZonePosition.Latitude := lCommonData.ItemByName[constLatitudeParamName].AsFloat;
      lZonePosition.Longitude := lCommonData.ItemByName[constLongitudeParamName].AsFloat;

      DoDownloadCooridnate(lZonePosition);
    end;

  finally
    FreeAndNilEx(lCommonDataList);
  end;
end;

end.
