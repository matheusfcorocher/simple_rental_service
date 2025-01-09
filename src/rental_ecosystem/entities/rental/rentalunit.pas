unit RentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, DateUtils, VehicleUnit, RentalExceptionsUnit;

type
  { TRental }

  TRental = class
  private
    FId: string;
    FRenterId: string;
    FVehicle: TVehicle;
    FStartDate: TDateTime;
    FEndDate: TDateTime;

    function IsRentalDateValid(startDate: TDateTime; endDate: TDateTime): boolean;
  public
    function getId: string;
    function getRenterId: string;
    function getVehicle: TVehicle;
    function getStartDate: TDateTime;
    function getEndDate: TDateTime;
    procedure setVehicle(vehicle: TVehicle);

    constructor Create(Id: string; RenterId: string; vehicle: TVehicle;
      startDate: TDateTime; endDate: TDateTime);
    constructor CreateWithoutBusinessRules(Id: string; RenterId: string; vehicle: TVehicle;
      startDate: TDateTime; endDate: TDateTime);
    function Total(): currency;
  end;

  TRentals = specialize TObjectList<TRental>;

  TRentalsHelper = class helper for TRentals
    function ToObjectList(): specialize TObjectList<TObject>;
  end;

function RentalEquals(a, b: TRental): boolean;

implementation

constructor TRental.Create(Id: string; RenterId: string; vehicle: TVehicle;
  startDate: TDateTime; endDate: TDateTime);
begin

  IsRentalDateValid(startDate, endDate);
  Vehicle.IsVehicleAvailable();

  FId := id;
  FRenterId := RenterId;
  FVehicle := vehicle;
  FStartDate := startDate;
  FEndDate := endDate;
end;

constructor TRental.CreateWithoutBusinessRules(Id: string; RenterId: string; vehicle: TVehicle;
  startDate: TDateTime; endDate: TDateTime);
begin
  FId := id;
  FRenterId := RenterId;
  FVehicle := vehicle;
  FStartDate := startDate;
  FEndDate := endDate;
end;

function TRental.IsRentalDateValid(startDate: TDateTime; endDate: TDateTime): boolean;
var
  ComparisonResult: integer;
begin
  ComparisonResult := CompareDateTime(startDate, endDate);

  //Rejects if is a day before or on the same day
  if ComparisonResult >= 0 then
  begin
    CreateRangeRentalDateException();
  end;

  Result := True;
end;

function TRental.getId: string;
begin
  Result := FId;
end;

function TRental.getRenterId: string;
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

procedure TRental.setVehicle(vehicle: TVehicle);
begin
  FVehicle := vehicle;
end;

function TRental.Total(): currency;
var
  RentedDays: integer;
  RentalTax: currency;
begin
  // Calculate the difference in hours
  RentedDays := DaysBetween(FStartDate, FEndDate);

  //Tax is 1% of vehicle value
  RentalTax := FVehicle.getValue * 0.01;

  Result := RentalTax * RentedDays;
end;

function RentalEquals(a, b: TRental): boolean;
begin
  Result := (a.getId = b.getId) and (a.getRenterId = b.getRenterId) and
  (a.getVehicle = b.getVehicle) and (a.getStartDate = b.getStartDate)
  and (a.getEndDate = b.getEndDate);
end;

function TRentalsHelper.ToObjectList(): specialize TObjectList<TObject>;
var
  Rental: TRental;
  ObjectList: specialize TObjectList<TObject>;
begin
  ObjectList := specialize TObjectList<TObject>.Create();
  for Rental in Self do
    ObjectList.Add(Rental);

  Result := ObjectList;
end;

end.
