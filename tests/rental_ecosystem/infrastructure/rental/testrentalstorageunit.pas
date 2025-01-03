unit TestRentalStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testutils, testregistry,
  RentalStorageUnit, RentalUnit, VehicleUnit, VehicleStatusUnit, RentalExceptionsUnit;

type

  { TTestRentalStorage }

  TTestRentalStorage = class(TTestCase)
  private
    FRentalStorage: TRentalStorage;
    procedure _CreatingNotFoundRental;
  protected
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure TestRegister;
    procedure TestUpdate;
    procedure TestInvalidUpdate;
    procedure TestGet;
    procedure TestDelete;
  end;

implementation

procedure TTestRentalStorage.Setup;
begin
  FRentalStorage := TRentalStorage.Create;
end;

procedure TTestRentalStorage.TearDown;
begin
  FRentalStorage.Free;
end;

procedure TTestRentalStorage._CreatingNotFoundRental;
begin
  FRentalStorage.Get('rental_uuid');
end;

procedure TTestRentalStorage.TestRegister;
var
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

  Rental := FRentalStorage.Register(Rental);

  AssertTrue(
    'When registering rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;

procedure TTestRentalStorage.TestUpdate;
var
  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);
  FRentalStorage.Register(Rental);

  Expected := Rental;

  Rental := FRentalStorage.Update(Rental);

  AssertTrue(
    'When updating rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;

procedure TTestRentalStorage.TestInvalidUpdate;
begin
  AssertException(
   'When trying to get the id of rental that doesnt exist, return exception',
   NotFoundRentalException,
   @_CreatingNotFoundRental
  );
end;

procedure TTestRentalStorage.TestGet;
var
  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);
  FRentalStorage.Register(Rental);
  Expected := Rental;

  Rental := FRentalStorage.Get(Rental.getId);

  AssertTrue(
    'When registering rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;

procedure TTestRentalStorage.TestDelete;
var
  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: String;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);
  Rental := FRentalStorage.Register(Rental);

  Expected := 'The rental has been successfully deleted from the system.';

  AssertEquals(
    'When deleting a rental, it retuns right message',
    FRentalStorage.Delete(Rental.getId),
    Expected
  );

  AssertException(
   'When trying to get the id of deleted rental, return exception',
   NotFoundRentalException,
   @_CreatingNotFoundRental
  );
end;

initialization

  RegisterTest(TTestRentalStorage);
end.
