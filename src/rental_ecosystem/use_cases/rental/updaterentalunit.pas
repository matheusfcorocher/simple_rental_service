unit UpdateRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit, IRentalStorageUnit;

type
  TUpdateRental = class
  private
    FRentalStorage: ITRentalStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage);
    function Execute(rental : TRental): TRental;
  end;

implementation

constructor TUpdateRental.Create(IRentalStorage: ITRentalStorage);
begin
  FRentalStorage := IRentalStorage;
end;

function TUpdateRental.Execute(rental : TRental): TRental;
begin
  Result := FRentalStorage.Update(rental);
end;

end.

