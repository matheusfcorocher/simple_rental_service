unit TestRegisterVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, RegisterVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit;

type

  TTestRegisterVehicle= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterVehicle.TestExecute;
var
  VehicleStorage: ITVehicleStorage;
  RegisterVehicle: TRegisterVehicle;
  Vehicle: TVehicle;
  VehicleData : TVehicleData;
  Expected: TVehicle;
begin
  // preparing test
  VehicleStorage := TFakeVehicleStorage.Create;
  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);
  Expected := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);

  with VehicleData do
  begin
    name := Expected.getName;
    licensePlate := Expected.getLicensePlate;
    value := Expected.getValue;
    status := Expected.getStatus;
  end;

  // executing test
  Vehicle := RegisterVehicle.Execute(VehicleData);

  AssertTrue(
    'When executing RegisterVehicle, it retuns correct Vehicles',
    VehicleEquals(Vehicle, Expected)
  );
end;

procedure TTestRegisterVehicle.SetUp;
begin

end;

procedure TTestRegisterVehicle.TearDown;
begin

end;

initialization

  RegisterTest(TTestRegisterVehicle);
end.

