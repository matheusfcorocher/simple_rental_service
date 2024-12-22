unit RentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, VehicleUnit;

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
    constructor Create(id: String; renter_id: string; vehicle: TVehicle; startDate : TDateTime; endDate: TDateTime);
    function Total() : Currency;

  end;

implementation

constructor TRental.Create(id: String; renter_id: string; vehicle: TVehicle;
  startDate: TDateTime; endDate: TDateTime);
begin
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
    Result := False;
  end;

  Result := True;
end;

function TRental.Total(): Currency;
var
  RentedDays : Integer;
  RentalTax : Currency;
begin
  // Calculate the difference in hours
  RentedDays := DaysBetween(FStartDate, FEndDate);

  //Tax is 10% of vehicle value
  RentalTax := FVehicle.getValue * 0.1;

  Result := RentalTax * RentedDays;
end;

end.

