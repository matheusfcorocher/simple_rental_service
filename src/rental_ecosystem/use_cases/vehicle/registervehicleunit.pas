unit RegisterVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleStorageUnit;

type
  TRegisterVehicle = class
  private
    FVehicleStorage: ITVehicleStorage;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage);
    function Execute(Vehicle : TVehicle): TVehicle;
  end;

implementation

constructor TRegisterVehicle.Create(IVehicleStorage: ITVehicleStorage);
begin
  FVehicleStorage := IVehicleStorage;
end;

function TRegisterVehicle.Execute(Vehicle : TVehicle) : TVehicle;
begin
  Result := FVehicleStorage.Register(Vehicle);
end;

end.
