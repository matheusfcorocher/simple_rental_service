unit TestRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, RentalUnit, VehicleUnit,
  VehicleStatusUnit, RentalExceptionsUnit, DateUtils, VehicleExceptionsUnit;

type

  { TTestRental }

  TTestRental= class(TTestCase)
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
  StartDate, EndDate : TDateTime;
  Vehicle : TVehicle;
begin
 StartDate := EncodeDate(2024, 12, 31);
 EndDate := EncodeDate(2024, 12, 1);
 Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
 TRental.Create('rental_uuid','renter_uuid', Vehicle, StartDate, EndDate);
end;

procedure TTestRental._CreatingInvalidVehicleForRental;
var
  StartDate, EndDate : TDateTime;
  Vehicle : TVehicle;
begin
 StartDate := EncodeDate(2024, 12, 1);
 EndDate := EncodeDate(2024, 12, 31);
 Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, RENTED);
 TRental.Create('rental_uuid','renter_uuid', Vehicle, StartDate, EndDate);
end;

procedure TTestRental.TestCreateWithValidData;
var
  StartDate, EndDate : TDateTime;
  Vehicle : TVehicle;
  Rental : TRental;
  Expected : TRental;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  Rental := TRental.Create('rental_uuid','renter_uuid', Vehicle, StartDate, EndDate);

  Expected := TRental.Create('rental_uuid','renter_uuid', Vehicle, StartDate, EndDate);

  AssertTrue(
    'When creating a rental with valid data, it retuns rental instance',
    RentalEquals(Expected, Rental)
  );
end;

procedure TTestRental.TestCreateWithInvalidRange;
begin
  AssertException(
   'When is created a rental with invalid date, it retuns exception',
   RangeRentalDateException,
   @_CreatingInvalidDateForRental
  );
end;

procedure TTestRental.TestCreateWithInvalidVehicle;
begin
  AssertException(
   'When is created a rental with invalid vehicle, it retuns exception',
   VehicleNotAvailableException,
   @_CreatingInvalidVehicleForRental
  );
end;

procedure TTestRental.TestTotal;
var
  StartDate, EndDate : TDateTime;
  Vehicle : TVehicle;
  Rental : TRental;
  Expected : Currency;
  Value : Currency;
begin
  Value := 20000;
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', Value, AVAILABLE);
  Rental := TRental.Create('rental_uuid','renter_uuid', Vehicle, StartDate, EndDate);

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

