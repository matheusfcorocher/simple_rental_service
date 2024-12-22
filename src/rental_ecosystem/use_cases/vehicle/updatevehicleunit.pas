unit UpdateVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleStorageUnit;

type
  TUpdateVehicle = class
  private
    FVehicleStorage: ITVehicleStorage;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage);
    function Execute(Vehicle : TVehicle): TVehicle;
  end;

implementation

constructor TUpdateVehicle.Create(IVehicleStorage: ITVehicleStorage);
begin
  FVehicleStorage := IVehicleStorage;
end;

function TUpdateVehicle.Execute(Vehicle : TVehicle) : TVehicle;
begin
  Result := FVehicleStorage.Update(Vehicle);
end;

end.

