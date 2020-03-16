unit uJSONParser;

interface

uses System.JSON, System.SysUtils, uSpyTaxiTypes, uExUtils, System.Generics.Collections;

type
  TCarDetectEvent = procedure(const ACar:TDriver);

  TTaxiParser = class
  private

    FOnCarDetect: TCarDetectEvent;

    procedure DoCarDetectEvent(const ACar:TDriver);
  public
    property OnCarDetected: TCarDetectEvent read FOnCarDetect write FOnCarDetect;

    procedure ParseTaxi(AValue: string);

    procedure AfterConstruction; override;
  end;

implementation

{ TTaxiParser }

procedure TTaxiParser.AfterConstruction;
begin
  inherited;
end;

procedure TTaxiParser.DoCarDetectEvent(const ACar:TDriver);
begin
  if Assigned(FOnCarDetect) then
  begin
    FOnCarDetect(ACar);
  end;
end;

procedure TTaxiParser.ParseTaxi(AValue: string);
var
  lJSONObject: TJSONObject;

  lPositionJSONArray: TJSONArray;

  lCarsClassJSONArray: TJSONArray;
  lCarsClassIndex: Integer;

  lDriversJSONObject: TJSONObject;
  lDriversJSONArray: TJSONArray;
  lDriverJSONObject: TJSONObject;
  lDriversIndex: Integer;

  lCar:TDriver;
begin
  // Парсим
  try
    lJSONObject := TJSONObject.Create;
    lJSONObject.Parse(TEncoding.UTF8.GetBytes(AValue), 0);

    lCarsClassJSONArray := lJSONObject.Values['services'].AsType<TJSONArray>;

    for lCarsClassIndex := 0 to lCarsClassJSONArray.Count - 1 do
    begin
      lDriversJSONObject := lCarsClassJSONArray.Items[lCarsClassIndex].AsType<TJSONObject>;

      lDriversJSONArray := lDriversJSONObject.Values['nearby_vehicles'].AsType<TJSONArray>;

      for lDriversIndex := 0 to lDriversJSONArray.Count - 1 do
      begin
        lDriverJSONObject := lDriversJSONArray.Items[lDriversIndex].AsType<TJSONObject>;

        lCar.Id := lDriverJSONObject.Values['id'].ToString;
        lCar.Color := lDriverJSONObject.Values['color'].ToString;
        lCar.CarClass := lDriverJSONObject.Values['pin'].ToString;

        lPositionJSONArray := lDriverJSONObject.Values['position'].AsType<TJSONArray>;

        lCar.CarPosition.Latitude := StrToFloat(lPositionJSONArray.Items[0].ToString);
        lCar.CarPosition.Longitude := StrToFloat(lPositionJSONArray.Items[1].ToString);

        DoCarDetectEvent(lCar);
      end;
    end;
  finally
    FreeAndNilEx(lJSONObject);
  end;
end;

end.
