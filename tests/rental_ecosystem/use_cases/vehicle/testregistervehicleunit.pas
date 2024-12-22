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
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
  Expected := Vehicle;

  VehicleStorage := TFakeVehicleStorage.Create;
  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);

  Vehicle := RegisterVehicle.Execute(Vehicle);

  AssertTrue(
    'When executing RegisterVehicle, it retuns correct Vehicles',
    VehicleEquals(Vehicle,Expected)
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

