unit VehicleExceptionsCreatorPTUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IVehicleExceptionsCreatorUnit, RentalServiceExceptionsUnit;

type
  TVehicleExceptionsCreatorPT = class(TInterfacedObject, ITVehicleExceptionsCreator)
  public
    procedure CreateVehicleNameError;
    procedure CreateVehicleLicensePlateError;
    procedure CreateVehicleValueError;
    procedure CreateVehicleNotAvailableError;
    procedure CreateNotFoundVehicleError(id: string);
  end;

implementation

procedure TVehicleExceptionsCreatorPT.CreateVehicleNameError;
begin
  raise VehicleNameException.Create(
    'O nome do veículo não é válido. Verifique se o nome tem 3 ou mais dígitos.');
end;

procedure TVehicleExceptionsCreatorPT.CreateVehicleLicensePlateError;
begin
  raise VehicleLicensePlateException.Create(
    'A placa do veículo não é válida. Verifique se a placa tem 6 ou mais dígitos.');
end;

procedure TVehicleExceptionsCreatorPT.CreateVehicleValueError;
begin
  raise VehicleValueException.Create(
    'O valor do veículo não é válido. Verifique se o valor é positivo.');
end;

procedure TVehicleExceptionsCreatorPT.CreateVehicleNotAvailableError;
begin
  raise VehicleNotAvailableException.Create(
    '"O veículo não está disponível. Verifique outros veículos para alugar.');
end;

procedure TVehicleExceptionsCreatorPT.CreateNotFoundVehicleError(id: string);
begin
  raise NotFoundVehicleException.Create('Veículo com id ' + id +
    ' não foi encontrado.');
end;

end.
