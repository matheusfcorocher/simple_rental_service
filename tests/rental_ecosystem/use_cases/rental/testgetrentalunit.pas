unit TestGetRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testutils, testregistry,
  VehicleUnit, VehicleStatusUnit, IRentalStorageUnit, FakeRentalStorageUnit,
  GetRentalUnit, RentalUnit, RentalsUnit, VehicleExceptionsCreatorENUnit,
  RentalExceptionsCreatorENUnit, RentalUtilsFunctionsUnit;

type

  TTestGetRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestGetRental.TestExecute;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;

  RentalStorage: ITRentalStorage;

  GetRental: TGetRental;

  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rentals: TRentals;
  Rental: TRental;

  Expected: TRental;
begin
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create();
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create();

  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, VehicleExceptionsCreator);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, RentalExceptionsCreator);

  Rentals := TRentals.Create;
  Rentals.Add(Rental);

  RentalStorage := TFakeRentalStorage.Create(Rentals);

  GetRental := TGetRental.Create(RentalStorage);

  Expected := Rental;
  Rental := GetRental.Execute(Rental.getId);

  AssertTrue(
    'When getting a rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;

initialization

  RegisterTest(TTestGetRental);
end.
