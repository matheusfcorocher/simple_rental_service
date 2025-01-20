unit RentalBuilderUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRentalExceptionsCreatorUnit, RentalUnit, VehicleUnit;

type
  TRentalBuilder = class

  private
    _RentalExceptionsCreator: ITRentalExceptionsCreator;

  public
    constructor Create(RentalExceptionsCreator: ITRentalExceptionsCreator);
    function Build(Id: string; RenterId: string; vehicle: TVehicle;
      startDate: TDateTime; endDate: TDateTime) : TRental;

  end;

implementation

constructor TRentalBuilder.Create(RentalExceptionsCreator: ITRentalExceptionsCreator);
begin
  _RentalExceptionsCreator := RentalExceptionsCreator;
end;

function TRentalBuilder.Build(Id: string; RenterId: string; vehicle: TVehicle;
      startDate: TDateTime; endDate: TDateTime) : TRental;
begin
  result := TRental.Create(Id, RenterId, vehicle, startDate, endDate, _RentalExceptionsCreator);
end;

end.
