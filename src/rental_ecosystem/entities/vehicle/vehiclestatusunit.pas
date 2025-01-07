unit VehicleStatusUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, TypInfo;

type
  TVehicleStatus = (AVAILABLE, RENTED);

function IsVehicleStatusEqual(a, b: TVehicleStatus): boolean;
function VehicleStatusToStr(Status: TVehicleStatus): string;
function StrToVehicleStatus(Status: string): TVehicleStatus;

implementation

function IsVehicleStatusEqual(a, b: TVehicleStatus): boolean;
begin
  Result := GetEnumName(TypeInfo(TVehicleStatus), Ord(a)) =
    GetEnumName(TypeInfo(TVehicleStatus), Ord(b));
end;

function VehicleStatusToStr(Status: TVehicleStatus): string;
const
  StatusNames: array[TVehicleStatus] of string = ('AVAILABLE', 'RENTED');
begin
  Result := StatusNames[Status];
end;

function StrToVehicleStatus(Status: string): TVehicleStatus;
const
  StatusNames: array[0..1] of string = ('AVAILABLE', 'RENTED');
  StatusValues: array[0..1] of TVehicleStatus = (AVAILABLE, RENTED);
var
  i: integer;
begin
  for i := Low(StatusNames) to High(StatusNames) do
  begin
    if StatusNames[i] = Status then
    begin
      Result := StatusValues[i];
      Exit;
    end;
  end;

  raise Exception.Create(
    'Vehicle status not found, checks if status is AVAILABLE or RENTED');
end;

end.
