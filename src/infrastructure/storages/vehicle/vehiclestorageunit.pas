unit VehicleStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IVehicleStorageUnit,
  VehicleUnit,
  VehicleStatusUnit,
  VehiclesUnit,
  IVehicleExceptionsCreatorUnit;

type

  { TVehicleStorage }

  TVehicleStorage = class(TInterfacedObject, ITVehicleStorage)
  private
    _Vehicles: TVehicles;
    _VehicleExceptionsCreator: ITVehicleExceptionsCreator;
  public
    constructor Create(VehicleExceptionsCreator: ITVehicleExceptionsCreator);
    constructor Create(vehicles: TVehicles;
      VehicleExceptionsCreator: ITVehicleExceptionsCreator); overload;
    function GetNextId(): string;
    function Register(Vehicle: TVehicle): TVehicle;
    function Update(Vehicle: TVehicle): TVehicle;
    function Get(id: string): TVehicle;
    function Delete(id: string): string;
  end;

implementation

constructor TVehicleStorage.Create(VehicleExceptionsCreator:
  ITVehicleExceptionsCreator);
begin
  _Vehicles := TVehicles.Create();
  _VehicleExceptionsCreator := VehicleExceptionsCreator;
end;

constructor TVehicleStorage.Create(vehicles: TVehicles; VehicleExceptionsCreator:
  ITVehicleExceptionsCreator);
begin
  _Vehicles := vehicles;
  _VehicleExceptionsCreator := VehicleExceptionsCreator;
end;

function TVehicleStorage.GetNextId(): string;
var
  GUID: TGUID;
begin
  CreateGuid(GUID);
  Result := GUIDToString(GUID);
end;

function TVehicleStorage.Register(Vehicle: TVehicle): TVehicle;
begin
  _Vehicles.Add(Vehicle);
  Result := Vehicle;
end;

function TVehicleStorage.Update(Vehicle: TVehicle): TVehicle;
var
  AuxVehicle: TVehicle;
  VehicleIdx: integer;
begin
  AuxVehicle := Get(Vehicle.getId());
  VehicleIdx := _Vehicles.IndexOf(AuxVehicle);
  _Vehicles.Insert(VehicleIdx, Vehicle);

  Result := Vehicle;
end;

function TVehicleStorage.Get(id: string): TVehicle;
var
  Vehicle: TVehicle;
begin
  for Vehicle in _Vehicles do
  begin
    if Vehicle.getId() = id then
    begin
      Result := Vehicle;
      Exit;
    end;
  end;

  _VehicleExceptionsCreator.CreateNotFoundVehicleError(id);
end;

function TVehicleStorage.Delete(id: string): string;
var
  Vehicle: TVehicle;
begin
  Vehicle := Get(id);
  _Vehicles.Remove(Vehicle);
  Result := 'The Vehicle has been successfully deleted from the system.';
end;

end.
