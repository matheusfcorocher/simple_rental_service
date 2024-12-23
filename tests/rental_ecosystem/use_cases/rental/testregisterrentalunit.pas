unit TestRegisterRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, DateUtils, testregistry, RentalUnit, VehicleUnit, VehicleStatusUnit,
  IRentalStorageUnit, FakeRentalStorageUnit, RegisterRentalUnit;

type

  TTestRegisterRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterRental.TestExecute;
var
  RentalStorage: ITRentalStorage;
  RegisterRental: TRegisterRental;
  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);
  Expected := Rental;

  RentalStorage := TFakeRentalStorage.Create;
  RegisterRental := TRegisterRental.Create(RentalStorage);

  Rental := RegisterRental.Execute(Rental);

  AssertTrue(
    'When registering rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;



initialization

  RegisterTest(TTestRegisterRental);
end.
