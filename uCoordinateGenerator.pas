unit uCoordinateGenerator;

interface

uses
  uSpyTaxiTypes, uDriverContainer
  //
    , System.Generics.Collections;

type
  TCoordinateGenerator = class
  private
    FDriversDictionary: TObjectDictionary<string, TDriverContainer>;
  public
    function AddDriver(const ADriver: TDriver): Boolean;

    procedure AddPosition(const AZonePosition: TZonePosition);

    procedure Clear;

    function GenerateCoordinate(out ADriverPosition: TDriverPosition): Boolean;
    procedure AfterConstruction; override;
  end;

implementation

uses System.SysUtils;

function TCoordinateGenerator.AddDriver(const ADriver: TDriver): Boolean;
var
  lDriverContainer: TDriverContainer;
begin
  Result := False;
  if not FDriversDictionary.TryGetValue(ADriver.Id, lDriverContainer) then
  begin
    lDriverContainer := TDriverContainer.Create(ADriver);
    FDriversDictionary.Add(ADriver.Id, lDriverContainer);
    Result := True;
  end;
end;

procedure TCoordinateGenerator.AddPosition(const AZonePosition: TZonePosition);
var
  lFictionalDriver: TDriver;
  lDriverContainer: TDriverContainer;
begin
  // Создаем фиктивного водителя, что бы добавить координаты.
  lFictionalDriver.Id := IntToStr(Random(999999999999999));
  lFictionalDriver.CarPosition := AZonePosition;

  lDriverContainer := TDriverContainer.Create(lFictionalDriver);

  FDriversDictionary.TryAdd(lFictionalDriver.Id, lDriverContainer)
end;

procedure TCoordinateGenerator.AfterConstruction;
begin
  inherited;
  FDriversDictionary := TObjectDictionary<string, TDriverContainer>.Create;
end;

procedure TCoordinateGenerator.Clear;
begin
  FDriversDictionary.Clear;
end;

function TCoordinateGenerator.GenerateCoordinate(out ADriverPosition: TDriverPosition): Boolean;
var
  lDriverContainer: TDriverContainer;
begin
  Result := False;
  for lDriverContainer in FDriversDictionary.Values do
  begin
    if not lDriverContainer.UsesDriver then
    begin
      Result := True;
      ADriverPosition := lDriverContainer.CarPoisition;
    end;
  end;
end;

end.
