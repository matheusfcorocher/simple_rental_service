unit TestUpdateRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testutils, testregistry,
  VehicleUnit, VehicleStatusUnit,
  RentalUnit, IRentalStorageUnit, FakeRentalStorageUnit, UpdateRentalUnit;

type

  TTestUpdateRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestUpdateRental.TestExecute;
var
  RentalStorage: ITRentalStorage;
  UpdateRental: TUpdateRental;
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
  UpdateRental := TUpdateRental.Create(RentalStorage);

  Rental := UpdateRental.Execute(Rental);

  AssertTrue(
    'When updating a Rental, it retuns correct Rental',
    RentalEquals(Rental, Expected)
    );
end;



initialization

  RegisterTest(TTestUpdateRental);
end.
