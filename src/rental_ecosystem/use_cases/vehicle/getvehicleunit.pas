unit GetVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleStorageUnit;

type
  TGetVehicle = class
  private
    FVehicleStorage: ITVehicleStorage;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage);
    function Execute(id : String): TVehicle;
  end;

implementation

constructor TGetVehicle.Create(IVehicleStorage: ITVehicleStorage);
begin
  FVehicleStorage := IVehicleStorage;
end;

function TGetVehicle.Execute(id : String): TVehicle;
begin
  Result := FVehicleStorage.Get(id);
end;

end.
