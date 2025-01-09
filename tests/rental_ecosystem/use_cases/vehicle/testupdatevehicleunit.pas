unit TestUpdateVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, UpdateVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit, RegisterVehicleUnit;

type

  TTestUpdateVehicle= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestVehicle;
  end;

implementation

procedure TTestUpdateVehicle.TestVehicle;
var
  VehicleStorage: ITVehicleStorage;
  RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle;
  Vehicle: TVehicle;
  VehicleData: TVehicleData;
  Expected: TVehicle;
begin
  // preparing test
  VehicleStorage := TFakeVehicleStorage.Create;
  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage);

  with VehicleData do
  begin
    name := 'corsa';
    licensePlate := 'MACLOVIN';
    value := 1000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleData);

  Vehicle.setName('Subaru');
  Expected := Vehicle;

  // executing test
  Vehicle := UpdateVehicle.Execute(Vehicle);

  AssertTrue(
    'When updating a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle,Expected)
  );
end;

procedure TTestUpdateVehicle.SetUp;
begin

end;

procedure TTestUpdateVehicle.TearDown;
begin

end;

initialization

  RegisterTest(TTestUpdateVehicle);
end.

