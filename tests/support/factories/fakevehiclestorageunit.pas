unit FakeVehicleStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IVehicleStorageUnit,
  VehicleUnit,
  VehicleStatusUnit,
  IVehicleExceptionsCreatorUnit,
  VehiclesUnit;

type

  { TFakeVehicleStorage }

  TFakeVehicleStorage = class(TInterfacedObject, ITVehicleStorage)
  private
    _Vehicles: TVehicles;
    _VehicleExceptionsCreator : ITVehicleExceptionsCreator;
  public
    constructor Create(VehicleExceptionsCreator : ITVehicleExceptionsCreator);
    function GetNextId() : String;
    function Register(Vehicle: TVehicle): TVehicle;
    function Update(Vehicle: TVehicle): TVehicle;
    function Get(id: String): TVehicle;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeVehicleStorage.Create(VehicleExceptionsCreator : ITVehicleExceptionsCreator);
begin
  _Vehicles := TVehicles.Create;
  _VehicleExceptionsCreator := VehicleExceptionsCreator;
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
  _Vehicles.Add(Vehicle);
  result := Vehicle;
end;

function TFakeVehicleStorage.Update(Vehicle: TVehicle): TVehicle;
var
  AuxVehicle: TVehicle;
  VehicleIdx : Integer;
begin
  AuxVehicle := Get(Vehicle.getId());
  VehicleIdx := _Vehicles.IndexOf(AuxVehicle);
  _Vehicles.Insert(VehicleIdx, Vehicle);;

  result := Vehicle;
end;

function TFakeVehicleStorage.Get(id: String): TVehicle;
var
  Vehicle : TVehicle;
begin
  for Vehicle in _Vehicles do
  begin
    if Vehicle.getId() = id then
    begin
      result := Vehicle;
      Exit;
    end;
  end;

  _VehicleExceptionsCreator.CreateNotFoundVehicleError(id);
end;

function TFakeVehicleStorage.Delete(id: string) : String;
var
  Vehicle : TVehicle;
begin
  Vehicle := Get(id);
  _Vehicles.Remove(Vehicle);
  result := 'The Vehicle has been successfully deleted from the system.';
end;

end.

