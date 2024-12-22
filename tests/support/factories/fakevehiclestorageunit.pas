unit FakeVehicleStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IVehicleStorageUnit,
  VehicleUnit,
  VehicleStatusUnit;

type
  TFakeVehicleStorage = class(TInterfacedObject, ITVehicleStorage)
  private
    Vehicles: TVehicles;
  public
    constructor Create();
    function Register(Vehicle: TVehicle): TVehicle;
    function Update(Vehicle: TVehicle): TVehicle;
    function Get(id: String): TVehicle;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeVehicleStorage.Create();
begin
  Vehicles := TVehicles.Create
end;

function TFakeVehicleStorage.Register(Vehicle: TVehicle): TVehicle;
begin
  Vehicles.Add(Vehicle);
  result := Vehicle;
end;

function TFakeVehicleStorage.Update(Vehicle: TVehicle): TVehicle;
begin
  result := Vehicle;
end;

function TFakeVehicleStorage.Get(id: String): TVehicle;
begin
  result := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
end;

function TFakeVehicleStorage.Delete(id: string) : String;
begin
  result := 'The Vehicle has been successfully deleted from the system.';
end;

end.

