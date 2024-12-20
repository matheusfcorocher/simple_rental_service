unit VehicleExceptionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  VehicleNameException = class(Exception);
  VehicleLicensePlateException = class(Exception);
  VehicleValueException = class(Exception);

procedure CreateVehicleNameError;
procedure CreateVehicleLicensePlateError;
procedure CreateVehicleValueError;

implementation

procedure CreateVehicleNameError;
begin
  Raise VehicleNameException.Create('Name of vehicle isnt valid. Checks if name has more or equal than 3 digits.');
end;

procedure CreateVehicleLicensePlateError;
begin
  Raise VehicleLicensePlateException.Create('License Plate of vehicle isnt valid. Checks if license plate has more or equal than 6 digits.');
end;

procedure CreateVehicleValueError;
begin
  Raise VehicleValueException.Create('Value of vehicle isnt valid. Checks if value is positive.');
end;

end.
