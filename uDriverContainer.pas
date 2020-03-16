unit uDriverContainer;

interface

uses
  uSpyTaxiTypes;

type
  TDriverContainer = class
  strict private
    FDriver: TDriver;
    FUsesDriver: Boolean;
  private
    function GetIdDriver: string;

    procedure DoGetCarPosition;
    function GetCarPoisition: TDriverPosition;
  public
    property UsesDriver: Boolean read FUsesDriver;
    property IdDriver: string read GetIdDriver;
    property CarPoisition: TDriverPosition read GetCarPoisition;

    constructor Create(const ADriver: TDriver);
  end;

implementation

{ TDriverContainer }

constructor TDriverContainer.Create(const ADriver: TDriver);
begin
  FUsesDriver := False;
  FDriver := ADriver;
end;

procedure TDriverContainer.DoGetCarPosition;
begin
  FUsesDriver := True;
end;

function TDriverContainer.GetCarPoisition: TDriverPosition;
begin
  Result := FDriver.CarPosition;
  DoGetCarPosition;
end;

function TDriverContainer.GetIdDriver: string;
begin
  Result := FDriver.Id;
end;

end.
