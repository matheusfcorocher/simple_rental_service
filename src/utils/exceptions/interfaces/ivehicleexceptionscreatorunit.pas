unit IVehicleExceptionsCreatorUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  ITVehicleExceptionsCreator = interface
    procedure CreateVehicleNameError;
    procedure CreateVehicleLicensePlateError;
    procedure CreateVehicleValueError;
    procedure CreateVehicleNotAvailableError;
    procedure CreateNotFoundVehicleError(id: string);
  end;

implementation

end.

