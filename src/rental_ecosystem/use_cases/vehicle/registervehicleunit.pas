unit RegisterVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit, VehicleDTOUnit, VehicleBuilderUnit;

type
  TRegisterVehicle = class
  private
    _VehicleStorage: ITVehicleStorage;
    _VehicleBuilder: TVehicleBuilder;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage; VehicleBuilder: TVehicleBuilder);
    function Execute(VehicleDetailsDTO: TVehicleDetailsDTO): TVehicle;
  end;

implementation

constructor TRegisterVehicle.Create(IVehicleStorage: ITVehicleStorage; VehicleBuilder: TVehicleBuilder);
begin
  _VehicleStorage := IVehicleStorage;
  _VehicleBuilder := VehicleBuilder;
end;

function TRegisterVehicle.Execute(VehicleDetailsDTO: TVehicleDetailsDTO): TVehicle;
var
  VehicleId: string;
  Vehicle: TVehicle;
begin
  VehicleId := _VehicleStorage.GetNextId();
  Vehicle := _VehicleBuilder.Build(VehicleId, VehicleDetailsDTO.Name, VehicleDetailsDTO.licensePlate,
    VehicleDetailsDTO.value, VehicleDetailsDTO.status);
  Vehicle.IsVehicleValid();
  Result := _VehicleStorage.Register(Vehicle);
end;

end.
