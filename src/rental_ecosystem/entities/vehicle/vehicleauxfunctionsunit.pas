unit VehicleAuxFunctionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit;

function VehicleEquals(a, b: TVehicle): boolean;

implementation

function VehicleEquals(a, b: TVehicle): boolean;
begin
  Result := (a.getName = b.getName) and (a.getLicensePlate = b.getLicensePlate) and
    (a.getValue = b.getValue) and (a.getStatus = b.getStatus);
end;

end.

