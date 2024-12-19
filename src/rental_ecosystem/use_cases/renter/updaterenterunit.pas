unit UpdateRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit;

type
  TUpdateRenter = class
  private
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(renter : TRenter): TRenter;
  end;

implementation

constructor TUpdateRenter.Create(IRenterStorage: ITRenterStorage);
begin
  FRenterStorage := IRenterStorage;
end;

function TUpdateRenter.Execute(renter : TRenter) : TRenter;
begin
  Result := FRenterStorage.Update(renter);
end;

end.

