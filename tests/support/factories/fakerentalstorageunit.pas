unit FakeRentalStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  DateUtils,
  IRentalStorageUnit,
  RentalUnit,
  VehicleUnit,
  VehicleStatusUnit;

type
  TFakeRentalStorage = class(TInterfacedObject, ITRentalStorage)
  private
    FRentals: TRentals;
  public
    constructor Create();
    constructor Create(rentals : TRentals); overload;
    function Register(Rental: TRental): TRental;
    function Update(Rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeRentalStorage.Create();
begin
  FRentals := TRentals.Create
end;

constructor TFakeRentalStorage.Create(rentals : TRentals);
begin
  FRentals := rentals;
end;

function TFakeRentalStorage.Register(Rental: TRental): TRental;
begin
  FRentals.Add(Rental);
  result := Rental;
end;

function TFakeRentalStorage.Update(Rental: TRental): TRental;
begin
  result := Rental;
end;

function TFakeRentalStorage.Get(id: String): TRental;
var
  //StartDate, EndDate : TDateTime;
  //Vehicle : TVehicle;
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
  //StartDate := EncodeDate(2024, 12, 1);
  //EndDate := EncodeDate(2024, 12, 31);
  //Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  //
  //result := TRental.Create('rental_uuid','renter_uuid', Vehicle, StartDate, EndDate);
end;

function TFakeRentalStorage.Delete(id: string) : String;
begin
  result := 'The rental has been successfully deleted from the system.';
end;

end.


