unit IVehicleStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  VehicleUnit;

type
  ITVehicleStorage = interface
    function GetNextId() : string;
    function Register(Vehicle: TVehicle): TVehicle;
    function Update(Vehicle: TVehicle): TVehicle;
    function Get(id: String): TVehicle;
    function Delete(id: string): String;
  end;

implementation

end.

