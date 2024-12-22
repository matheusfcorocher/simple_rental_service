unit TestGetVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, GetVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit;

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
  GetVehicle: TGetVehicle;
  Vehicle: TVehicle;
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
  Expected := Vehicle;

  VehicleStorage := TFakeVehicleStorage.Create;
  GetVehicle := TGetVehicle.Create(VehicleStorage);

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

