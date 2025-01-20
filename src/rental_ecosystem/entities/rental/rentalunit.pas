unit RentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, VehicleUnit, IRentalExceptionsCreatorUnit;

type
  { TRental }

  TRental = class
  private
    _Id: string;
    _RenterId: string;
    _Vehicle: TVehicle;
    _StartDate: TDateTime;
    _EndDate: TDateTime;

    _ExceptionsCreator : ITRentalExceptionsCreator;

    function _IsRentalDateValid(): boolean;
  public
    constructor Create(Id: string; RenterId: string; vehicle: TVehicle;
      startDate: TDateTime; endDate: TDateTime; RentalExceptionsCreator : ITRentalExceptionsCreator);

    function getId: string;
    function getRenterId: string;
    function getVehicle: TVehicle;
    function getStartDate: TDateTime;
    function getEndDate: TDateTime;
    procedure setVehicle(vehicle: TVehicle);

    function IsRentalValid(): boolean;
    function Total(): currency;
  end;

implementation

// private methods

function TRental._IsRentalDateValid(): boolean;
var
  ComparisonResult: integer;
begin
  ComparisonResult := CompareDateTime(_StartDate, _EndDate);

  //Rejects if is a day before or on the same day
  if ComparisonResult >= 0 then
  begin
    _ExceptionsCreator.CreateRangeRentalDateException();
  end;

  Result := True;
end;


// public methods

constructor TRental.Create(Id: string; RenterId: string; vehicle: TVehicle;
  startDate: TDateTime; endDate: TDateTime; RentalExceptionsCreator : ITRentalExceptionsCreator);
begin
  _Id := id;
  _RenterId := RenterId;
  _Vehicle := vehicle;
  _StartDate := startDate;
  _EndDate := endDate;

  _ExceptionsCreator := RentalExceptionsCreator;
end;

function TRental.IsRentalValid(): Boolean;
begin
   result := _IsRentalDateValid() and _Vehicle.IsVehicleAvailable();
end;

function TRental.Total(): currency;
var
  RentedDays: integer;
  RentalTax: currency;
begin
  // Calculate the difference in hours
  RentedDays := DaysBetween(_StartDate, _EndDate);

  //Tax is 1% of vehicle value
  RentalTax := _Vehicle.getValue * 0.01;

  Result := RentalTax * RentedDays;
end;

function TRental.getId: string;
begin
  Result := _Id;
end;

function TRental.getRenterId: string;
begin
  Result := _RenterId;
end;

function TRental.getVehicle: TVehicle;
begin
  Result := _Vehicle;
end;

function TRental.getStartDate: TDateTime;
begin
  Result := _StartDate;
end;

function TRental.getEndDate: TDateTime;
begin
  Result := _EndDate;
end;

procedure TRental.setVehicle(vehicle: TVehicle);
begin
  _Vehicle := vehicle;
end;

end.
