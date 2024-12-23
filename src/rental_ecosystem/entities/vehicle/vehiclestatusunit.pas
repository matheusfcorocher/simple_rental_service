unit VehicleStatusUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, TypInfo;

type
  TVehicleStatus = (AVAILABLE, RENTED);

function IsVehicleStatusEqual(a, b: TVehicleStatus): boolean;

implementation

function IsVehicleStatusEqual(a, b: TVehicleStatus): boolean;
begin
  Result := GetEnumName(TypeInfo(TVehicleStatus), Ord(a)) =
    GetEnumName(TypeInfo(TVehicleStatus), Ord(b));
end;


end.
