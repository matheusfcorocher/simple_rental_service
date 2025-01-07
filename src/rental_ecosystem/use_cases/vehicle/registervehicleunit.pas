unit RegisterVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit;

type
  TRegisterVehicle = class
  private
    FVehicleStorage: ITVehicleStorage;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage);
    function Execute(VehicleData: TVehicleData): TVehicle;
  end;

implementation

constructor TRegisterVehicle.Create(IVehicleStorage: ITVehicleStorage);
begin
  FVehicleStorage := IVehicleStorage;
end;

function TRegisterVehicle.Execute(VehicleData: TVehicleData): TVehicle;
var
  VehicleId: string;
  Vehicle: TVehicle;
begin
  VehicleId := FVehicleStorage.GetNextId();
  Vehicle := TVehicle.Create(VehicleId, VehicleData.Name, VehicleData.licensePlate,
    VehicleData.value, VehicleData.status);
  Result := FVehicleStorage.Register(Vehicle);
end;

end.
