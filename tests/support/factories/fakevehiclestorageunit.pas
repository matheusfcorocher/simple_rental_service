unit FakeVehicleStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IVehicleStorageUnit,
  VehicleUnit,
  VehicleStatusUnit,
  VehicleExceptionsUnit;

type

  { TFakeVehicleStorage }

  TFakeVehicleStorage = class(TInterfacedObject, ITVehicleStorage)
  private
    FVehicles: TVehicles;
  public
    constructor Create();
    function GetNextId() : String;
    function Register(Vehicle: TVehicle): TVehicle;
    function Update(Vehicle: TVehicle): TVehicle;
    function Get(id: String): TVehicle;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeVehicleStorage.Create();
begin
  FVehicles := TVehicles.Create
end;

function TFakeVehicleStorage.GetNextId(): String;
var
  GUID: TGUID;
begin
  CreateGuid(GUID);
  Result := GUIDToString(GUID);
end;

function TFakeVehicleStorage.Register(Vehicle: TVehicle): TVehicle;
begin
  FVehicles.Add(Vehicle);
  result := Vehicle;
end;

function TFakeVehicleStorage.Update(Vehicle: TVehicle): TVehicle;
var
  AuxVehicle: TVehicle;
  VehicleIdx : Integer;
begin
  AuxVehicle := Get(Vehicle.getId());
  VehicleIdx := FVehicles.IndexOf(AuxVehicle);
  FVehicles.Insert(VehicleIdx, Vehicle);;

  result := Vehicle;
end;

function TFakeVehicleStorage.Get(id: String): TVehicle;
var
  Vehicle : TVehicle;
begin
  for Vehicle in FVehicles do
  begin
    if Vehicle.getId() = id then
    begin
      result := Vehicle;
      Exit;
    end;
  end;

  CreateNotFoundVehicleError(id);
end;

function TFakeVehicleStorage.Delete(id: string) : String;
var
  Vehicle : TVehicle;
begin
  Vehicle := Get(id);
  FVehicles.Remove(Vehicle);
  result := 'The Vehicle has been successfully deleted from the system.';
end;

end.

