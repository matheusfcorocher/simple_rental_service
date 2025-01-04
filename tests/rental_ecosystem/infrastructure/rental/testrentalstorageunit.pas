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

procedure TTestRentalStorage._CreatingInvalidUpdateRental;
var
  StartDate : TDateTime;
  EndDate : TDateTime;
  Vehicle : TVehicle;
  Rental : TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);

  FRentalStorage.Update(Rental);
end;

procedure TTestRentalStorage._CreatingInvalidGetRental;
begin
  FRentalStorage.Get('rental_uuid');
end;

procedure TTestRentalStorage._CreatingInvalidDeleteRental;
var
  StartDate : TDateTime;
  EndDate : TDateTime;
  Vehicle : TVehicle;
  Rental : TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);

  FRentalStorage.Delete(Rental.getId);
end;

procedure TTestRentalStorage.Setup;
begin
  FRentalStorage := TRentalStorage.Create;
end;

procedure TTestRentalStorage.TearDown;
begin
  FRentalStorage.Free;
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
   'When trying to update rental that doesnt exist, return exception',
   NotFoundRentalException,
   @_CreatingInvalidUpdateRental
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

procedure TTestRentalStorage.TestInvalidGet;
begin
  AssertException(
   'When trying to get rental that doesnt exist, return exception',
   NotFoundRentalException,
   @_CreatingInvalidGetRental
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
end;

procedure TTestRentalStorage.TestInvalidDelete;
begin
  AssertException(
   'When trying to delete rental that doesnt exist, return exception',
   NotFoundRentalException,
   @_CreatingInvalidDeleteRental
  );
end;

initialization

  RegisterTest(TTestRentalStorage);
end.
