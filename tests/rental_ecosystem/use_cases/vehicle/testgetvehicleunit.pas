unit TestGetVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, GetVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit, RegisterVehicleUnit;

type

  TTestGetVehicle= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestGetVehicle.TestExecute;
var
  VehicleStorage: ITVehicleStorage;
  RegisterVehicle: TRegisterVehicle;
  GetVehicle: TGetVehicle;
  Vehicle: TVehicle;
  VehicleData: TVehicleData;
  Expected: TVehicle;
begin
  // preparing test
  VehicleStorage := TFakeVehicleStorage.Create;
  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);
  GetVehicle := TGetVehicle.Create(VehicleStorage);

  with VehicleData do
  begin
    name := 'corsa';
    licensePlate := 'MACLOVIN';
    value := 1000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleData);
  Expected := Vehicle;
  // Executing tests

  Vehicle := GetVehicle.Execute(Vehicle.getId);

  AssertTrue(
    'When getting a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
    );
end;

procedure TTestGetVehicle.SetUp;
begin

end;

procedure TTestGetVehicle.TearDown;
begin

end;

initialization

  RegisterTest(TTestGetVehicle);
end.

