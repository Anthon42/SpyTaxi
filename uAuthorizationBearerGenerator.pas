unit uAuthorizationBearerGenerator;

interface

uses System.Classes;

type
  TAuthorizationBearerGenerator = class
  private
    FBearerList: TStringList;
    FlastReturnIndex: Integer;
  public
    function ReturnBearer: string;

    constructor Create(const AFullName: string);
    procedure BeforeDestruction; override;
  end;

implementation

uses System.SysUtils;

procedure TAuthorizationBearerGenerator.BeforeDestruction;
begin
  FreeAndNil(FBearerList);
  inherited;
end;

constructor TAuthorizationBearerGenerator.Create(const AFullName: string);
begin
  if not FileExists(AFullName) then
  begin
    raise Exception.Create('Фaйл ' + AFullName + 'ненайден');
  end;

  FBearerList := TStringList.Create;

  FBearerList.LoadFromFile(AFullName);

  FlastReturnIndex := 0;
end;

function TAuthorizationBearerGenerator.ReturnBearer: string;
begin
  if FlastReturnIndex > FBearerList.Count - 1 then
    FlastReturnIndex := 0;

  Result := FBearerList[FlastReturnIndex];
  Inc(FlastReturnIndex);
end;

end.
