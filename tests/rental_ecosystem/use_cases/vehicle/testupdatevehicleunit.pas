unit TestUpdateVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, UpdateVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit;

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
  UpdateVehicle: TUpdateVehicle;
  Vehicle: TVehicle;
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
  Expected := Vehicle;

  VehicleStorage := TFakeVehicleStorage.Create;
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage);

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

