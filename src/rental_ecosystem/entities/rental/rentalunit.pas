unit RentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, VehicleUnit, RentalExceptionsUnit;

type

  { TRental }

  TRental = class
  private
    FId: String;
    FRenterId: String;
    FVehicle: TVehicle;
    FStartDate: TDateTime;
    FEndDate: TDateTime;

    function IsRentalDateValid(startDate : TDateTime; endDate : TDateTime): Boolean;
  public
    function getId: String;
    function getRenterId: String;
    function getVehicle: TVehicle;
    function getStartDate: TDateTime;
    function getEndDate: TDateTime;


    constructor Create(id: String; renter_id: string; vehicle: TVehicle; startDate : TDateTime; endDate: TDateTime);
    function Total() : Currency;
  end;

  function RentalEquals(a,b : TRental) : Boolean;

implementation

constructor TRental.Create(id: String; renter_id: string; vehicle: TVehicle;
  startDate: TDateTime; endDate: TDateTime);
begin

  IsRentalDateValid(startDate, endDate);
  Vehicle.IsVehicleAvailable();

  FId := id;
  FRenterId := renter_id;
  FVehicle := vehicle;
  FStartDate := startDate;
  FEndDate := endDate;
end;

function TRental.IsRentalDateValid(startDate : TDateTime; endDate : TDateTime): Boolean;
var
  ComparisonResult : Integer;
begin
  ComparisonResult := CompareDateTime(startDate, endDate);

  //Rejects if is a day before or on the same day
  if ComparisonResult >= 0 then
  begin
    CreateRangeRentalDateException();
  end;

  Result := True;
end;

function TRental.getId: String;
begin
  Result := FRenterId;
end;

function TRental.getRenterId: String;
begin
  Result := FRenterId;
end;

function TRental.getVehicle: TVehicle;
begin
  Result := FVehicle;
end;

function TRental.getStartDate: TDateTime;
begin
  Result := FStartDate;
end;

function TRental.getEndDate: TDateTime;
begin
  Result := FEndDate;
end;

function TRental.Total(): Currency;
var
  RentedDays : Integer;
  RentalTax : Currency;
begin
  // Calculate the difference in hours
  RentedDays := DaysBetween(FStartDate, FEndDate);

  //Tax is 1% of vehicle value
  RentalTax := FVehicle.getValue * 0.01;

  Result := RentalTax * RentedDays;
end;

function RentalEquals(a,b : TRental) : Boolean;
begin
  Result := (a.getId = b.getId) and (a.getVehicle =
    b.getVehicle) and (a.getStartDate = b.getStartDate) and
    (a.getEndDate = b.getEndDate);
end;

end.

