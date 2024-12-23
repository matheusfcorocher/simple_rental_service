unit RegisterRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit, IRentalStorageUnit;

type
  TRegisterRental = class
  private
    FRentalStorage: ITRentalStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage);
    function Execute(rental : TRental): TRental;
  end;

implementation

constructor TRegisterRental.Create(IRentalStorage: ITRentalStorage);
begin
  FRentalStorage := IRentalStorage;
end;

function TRegisterRental.Execute(rental : TRental): TRental;
begin
  Result := FRentalStorage.Register(rental);
end;

end.

