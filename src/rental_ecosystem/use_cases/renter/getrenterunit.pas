unit GetRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit, RenterDTOUnit;

type
  TGetRenter = class
  private
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(id : String): TRenter;
  end;

implementation

constructor TGetRenter.Create(IRenterStorage: ITRenterStorage);
begin
  FRenterStorage := IRenterStorage;
end;

function TGetRenter.Execute(id : String): TRenter;
begin
  Result := FRenterStorage.Get(id);
end;

end.
