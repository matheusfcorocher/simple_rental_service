unit GetRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit, IRentalStorageUnit;

type
  TGetRental = class
  private
    FRentalStorage: ITRentalStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage);
    function Execute(id : String): TRental;
  end;

implementation

constructor TGetRental.Create(IRentalStorage: ITRentalStorage);
begin
  FRentalStorage := IRentalStorage;
end;

function TGetRental.Execute(id : String): TRental;
begin
  Result := FRentalStorage.Get(id);
end;

end.

