unit uInterfaceObjects;

interface
uses uSpyTaxiTypes;
type
  ICar = interface
    function GetPositon: TDriverPosition;
  end;

implementation

end.
