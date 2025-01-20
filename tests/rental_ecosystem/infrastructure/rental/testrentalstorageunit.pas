unit TestRentalStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testutils, testregistry,
  RentalStorageUnit, RentalUnit, VehicleUnit, VehicleStatusUnit,
  RentalExceptionsCreatorENUnit, VehicleExceptionsCreatorENUnit,
  RentalUtilsFunctionsUnit, RentalServiceExceptionsUnit;

type

  { TTestRentalStorage }

  TTestRentalStorage = class(TTestCase)
  private
    _VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
    _RentalExceptionsCreator: TRentalExceptionsCreatorEN;
    _RentalStorage: TRentalStorage;

    procedure _CreatingInvalidUpdateRental;
    procedure _CreatingInvalidGetRental;
    procedure _CreatingInvalidDeleteRental;
  protected
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure TestRegister;

    procedure TestUpdate;
    procedure TestInvalidUpdate;

    procedure TestGet;
    procedure TestInvalidGet;

    procedure TestDelete;
    procedure TestInvalidDelete;
  end;

implementation

procedure TTestRentalStorage.Setup;
begin
  _VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  _RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;
  _RentalStorage := TRentalStorage.Create(_RentalExceptionsCreator);
end;

procedure TTestRentalStorage.TearDown;
begin

end;

procedure TTestRentalStorage._CreatingInvalidUpdateRental;
var
  StartDate: TDateTime;
  EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, _VehicleExceptionsCreator);
  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, _RentalExceptionsCreator);

  _RentalStorage.Update(Rental);
end;

procedure TTestRentalStorage._CreatingInvalidGetRental;
begin
  _RentalStorage.Get('rental_uuid');
end;

procedure TTestRentalStorage._CreatingInvalidDeleteRental;
var
  StartDate: TDateTime;
  EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, _VehicleExceptionsCreator);
  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, _RentalExceptionsCreator);

  _RentalStorage.Delete(Rental.getId);
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
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, _VehicleExceptionsCreator);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, _RentalExceptionsCreator);
  Expected := Rental;

  Rental := _RentalStorage.Register(Rental);

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
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, _VehicleExceptionsCreator);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, _RentalExceptionsCreator);
  _RentalStorage.Register(Rental);

  Expected := Rental;

  Rental := _RentalStorage.Update(Rental);

  AssertTrue(
    'When updating rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;

procedure TTestRentalStorage.TestInvalidUpdate;
begin
  AssertException(
    'When trying to update rental that doesnt exist, return exception',
    NotFoundRentalException, @_CreatingInvalidUpdateRental
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
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, _VehicleExceptionsCreator);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, _RentalExceptionsCreator);
  _RentalStorage.Register(Rental);
  Expected := Rental;

  Rental := _RentalStorage.Get(Rental.getId);

  AssertTrue(
    'When registering rental, it retuns correct rental',
    RentalEquals(Rental, Expected)
    );
end;

procedure TTestRentalStorage.TestInvalidGet;
begin
  AssertException(
    'When trying to get rental that doesnt exist, return exception',
    NotFoundRentalException, @_CreatingInvalidGetRental
    );
end;

procedure TTestRentalStorage.TestDelete;
var
  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: string;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, _VehicleExceptionsCreator);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate, _RentalExceptionsCreator);
  Rental := _RentalStorage.Register(Rental);

  Expected := 'The rental has been successfully deleted from the system.';

  AssertEquals(
    'When deleting a rental, it retuns right message',
    _RentalStorage.Delete(Rental.getId),
    Expected
    );
end;

procedure TTestRentalStorage.TestInvalidDelete;
begin
  AssertException(
    'When trying to delete rental that doesnt exist, return exception',
    NotFoundRentalException, @_CreatingInvalidDeleteRental
    );
end;

initialization

  RegisterTest(TTestRentalStorage);
end.
