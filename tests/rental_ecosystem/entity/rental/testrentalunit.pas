unit TestRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, RentalUnit, VehicleUnit,
  VehicleStatusUnit, RentalExceptionsCreatorENUnit, DateUtils,
  VehicleExceptionsCreatorENUnit,
  RentalBuilderUnit, VehicleBuilderUnit, VehicleAuxFunctionsUnit,
  RentalUtilsFunctionsUnit, RentalServiceExceptionsUnit;

type

  { TTestRental }

  TTestRental = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  private
    procedure _CreatingInvalidDateForRental;
    procedure _CreatingInvalidVehicleForRental;
  published
    procedure TestCreateWithValidData;
    procedure TestCreateWithInvalidRange;
    procedure TestCreateWithInvalidVehicle;
    procedure TestTotal;
  end;

implementation

procedure TTestRental.SetUp;
begin

end;

procedure TTestRental.TearDown;
begin

end;

//support procedure

procedure TTestRental._CreatingInvalidDateForRental;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
begin
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  StartDate := EncodeDate(2024, 12, 31);
  EndDate := EncodeDate(2024, 12, 1);
  Vehicle := VehicleBuilder.Build('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  Rental := RentalBuilder.Build('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate);
  Rental.IsRentalValid();
end;

procedure TTestRental._CreatingInvalidVehicleForRental;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
begin
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := VehicleBuilder.Build('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, RENTED);
  Rental := RentalBuilder.Build('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate);
  Rental.IsRentalValid();
end;

procedure TTestRental.TestCreateWithValidData;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: TRental;
begin
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := VehicleBuilder.Build('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  Rental := RentalBuilder.Build('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate);

  Expected := RentalBuilder.Build('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate);

  AssertTrue(
    'When creating a rental with valid data, it retuns rental instance',
    RentalEquals(Expected, Rental)
    );
end;

procedure TTestRental.TestCreateWithInvalidRange;
begin
  AssertException(
    'When is created a rental with invalid date, it retuns exception',
    RangeRentalDateException, @_CreatingInvalidDateForRental
    );
end;

procedure TTestRental.TestCreateWithInvalidVehicle;
begin
  AssertException(
    'When is created a rental with invalid vehicle, it retuns exception',
    VehicleNotAvailableException, @_CreatingInvalidVehicleForRental
    );
end;

procedure TTestRental.TestTotal;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: currency;
  Value: currency;
begin
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  Value := 20000;
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := VehicleBuilder.Build('vehicle_uuid', 'corsa', 'MACLOVIN', Value, AVAILABLE);
  Rental := RentalBuilder.Build('rental_uuid', 'renter_uuid', Vehicle,
    StartDate, EndDate);

  Expected := Value * DaysBetween(StartDate, EndDate) * 0.01;

  AssertEquals(
    'When get total of rental, it retuns the price of 1% of vehicle value',
    Expected,
    Rental.Total()
    );
end;

initialization

  RegisterTest(TTestRental);
end.
