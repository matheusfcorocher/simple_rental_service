unit UpdateVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleStorageUnit, VehicleDTOUnit, VehicleBuilderUnit;

type
  TUpdateVehicle = class
  private
    _VehicleStorage: ITVehicleStorage;
    _VehicleBuilder: TVehicleBuilder;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage; VehicleBuilder: TVehicleBuilder);
    function Execute(VehicleDTO: TVehicleDTO): TVehicle;
  end;

implementation

constructor TUpdateVehicle.Create(IVehicleStorage: ITVehicleStorage; VehicleBuilder: TVehicleBuilder);
begin
  _VehicleStorage := IVehicleStorage;
  _VehicleBuilder := VehicleBuilder;
end;

function TUpdateVehicle.Execute(VehicleDTO: TVehicleDTO): TVehicle;
var
  Vehicle: TVehicle;
begin
  Vehicle := _VehicleBuilder.Build(VehicleDTO.id, VehicleDTO.Name,
    VehicleDTO.licensePlate, VehicleDTO.Value, VehicleDTO.status);
  Vehicle.IsVehicleValid();
  Result := _VehicleStorage.Update(Vehicle);
end;

end.
