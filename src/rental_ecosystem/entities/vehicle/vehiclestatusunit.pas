unit VehicleStatusUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, TypInfo;

type
  TVehicleStatus = (AVAILABLE, RENTED);

function IsVehicleStatusEqual(a, b: TVehicleStatus): boolean;
function VehicleStatusToStr(Status: TVehicleStatus) : String;

implementation

function IsVehicleStatusEqual(a, b: TVehicleStatus): boolean;
begin
  Result := GetEnumName(TypeInfo(TVehicleStatus), Ord(a)) =
    GetEnumName(TypeInfo(TVehicleStatus), Ord(b));
end;

function VehicleStatusToStr(Status: TVehicleStatus) : String;
const
  StatusNames : array[TVehicleStatus] of string = ('AVAILABLE', 'RENTED');
begin
  result := StatusNames[Status];
end;

end.
