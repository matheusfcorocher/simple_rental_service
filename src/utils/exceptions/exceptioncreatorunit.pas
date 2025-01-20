unit ExceptionCreatorUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IExceptionsCreatorUnit, IRenterExceptionsCreatorUnit, IVehicleExceptionsCreatorUnit,
  IRentalExceptionsCreatorUnit;

type

  { TExceptionCreator }

  TExceptionCreator = class(TInterfacedObject, ITExceptionCreator)
  private
    FRenterExceptionsCreator: ITRenterExceptionsCreator;
    FVehicleExceptionsCreator: ITVehicleExceptionsCreator;
    FRentalExceptionsCreator: ITRentalExceptionsCreator;

  public
      constructor Create(renterExceptionsCreator : ITRenterExceptionsCreator; vehicleExceptionsCreator : ITVehicleExceptionsCreator; rentalExceptionsCreator : ITRentalExceptionsCreator);
      function GetRenterExceptionsCreator(): ITRenterExceptionsCreator;
      function GetVehicleExceptionsCreator(): ITVehicleExceptionsCreator;
      function GetRentalExceptionsCreator(): ITRentalExceptionsCreator;
  end;

implementation


{ TExceptionCreator }

constructor TExceptionCreator.Create(
  renterExceptionsCreator: ITRenterExceptionsCreator;
  vehicleExceptionsCreator: ITVehicleExceptionsCreator;
  rentalExceptionsCreator: ITRentalExceptionsCreator);
begin
  FRenterExceptionsCreator := renterExceptionsCreator;
  FVehicleExceptionsCreator := vehicleExceptionsCreator;
  FRentalExceptionsCreator := rentalExceptionsCreator;
end;

function TExceptionCreator.GetRenterExceptionsCreator(
  ): ITRenterExceptionsCreator;
begin
  result := FRenterExceptionsCreator;
end;

function TExceptionCreator.GetVehicleExceptionsCreator(
  ): ITVehicleExceptionsCreator;
begin
  result := FVehicleExceptionsCreator;
end;

function TExceptionCreator.GetRentalExceptionsCreator(
  ): ITRentalExceptionsCreator;
begin
  result := FRentalExceptionsCreator;
end;

end.

