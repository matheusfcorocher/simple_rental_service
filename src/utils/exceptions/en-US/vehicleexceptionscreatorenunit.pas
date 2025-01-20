unit VehicleExceptionsCreatorENUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IVehicleExceptionsCreatorUnit, RentalServiceExceptionsUnit;

type
  TVehicleExceptionsCreatorEN = class(TInterfacedObject, ITVehicleExceptionsCreator)
    public
      procedure CreateVehicleNameError;
      procedure CreateVehicleLicensePlateError;
      procedure CreateVehicleValueError;
      procedure CreateVehicleNotAvailableError;
      procedure CreateNotFoundVehicleError(id: string);
  end;

implementation

procedure TVehicleExceptionsCreatorEN.CreateVehicleNameError;
begin
  Raise VehicleNameException.Create('Name of vehicle isnt valid. Checks if name has more or equal than 3 digits.');
end;

procedure TVehicleExceptionsCreatorEN.CreateVehicleLicensePlateError;
begin
  Raise VehicleLicensePlateException.Create('License Plate of vehicle isnt valid. Checks if license plate has more or equal than 6 digits.');
end;

procedure TVehicleExceptionsCreatorEN.CreateVehicleValueError;
begin
  Raise VehicleValueException.Create('Value of vehicle isnt valid. Checks if value is positive.');
end;

procedure TVehicleExceptionsCreatorEN.CreateVehicleNotAvailableError;
begin
  Raise VehicleNotAvailableException.Create('Vehicle isnt available. Checks others vehicles to rent.');
end;

procedure TVehicleExceptionsCreatorEN.CreateNotFoundVehicleError(id : string);
begin
  Raise NotFoundVehicleException.Create('Vehicle with id ' + id + ' was not found');
end;

end.
