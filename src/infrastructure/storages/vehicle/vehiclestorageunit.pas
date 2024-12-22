unit VehicleStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IVehicleStorageUnit,
  VehicleUnit,
  VehicleStatusUnit;

type
  TVehicleStorage = class(TInterfacedObject, ITVehicleStorage)
  public
    function Register(Vehicle: TVehicle): TVehicle;
    function Update(Vehicle: TVehicle): TVehicle;
    function Get(id: String): TVehicle;
    function Delete(id: string): String;
  end;

implementation

function TVehicleStorage.Register(Vehicle: TVehicle): TVehicle;
begin
  result := Vehicle;
end;

function TVehicleStorage.Update(Vehicle: TVehicle): TVehicle;
begin
  result := Vehicle;
end;

function TVehicleStorage.Get(id: String): TVehicle;
begin
  result := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
end;

function TVehicleStorage.Delete(id: string) : String;
begin
  result := 'The Vehicle has been successfully deleted from the system.';
end;

end.

