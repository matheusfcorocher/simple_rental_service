unit RentalStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  DateUtils,
  IRentalStorageUnit,
  VehicleUnit,
  VehicleStatusUnit,
  RentalUnit;

type

  { TRentalStorage }

  TRentalStorage = class(TInterfacedObject, ITRentalStorage)
  private
    FRentals: TRentals;
  public
    constructor Create();
    constructor Create(rentals : TRentals); overload;
    function Register(rental: TRental): TRental;
    function Update(rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;
  end;

implementation

constructor TRentalStorage.Create();
begin
  FRentals := TRentals.Create
end;

constructor TRentalStorage.Create(rentals: TRentals);
begin
  FRentals := rentals;
end;

function TRentalStorage.Register(rental: TRental): TRental;
begin
  FRentals.Add(Rental);
  result := Rental;
end;

function TRentalStorage.Update(rental: TRental): TRental;
begin
  result := rental;
end;

function TRentalStorage.Get(id: String): TRental;
var
  Rental : TRental;
begin
  for Rental in FRentals do
  begin
    if Rental.getId = id then
    begin
      result := Rental;
      break;
    end;
  end;
end;

function TRentalStorage.Delete(id: string) : String;
begin
  result := 'The rental has been successfully deleted from the system.';
end;

end.
