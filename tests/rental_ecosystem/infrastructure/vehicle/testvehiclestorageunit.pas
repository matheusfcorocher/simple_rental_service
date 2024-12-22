unit TestVehicleStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,
  VehicleUnit,
  VehicleStorageUnit, VehicleStatusUnit;

type

  TTestVehicleStorage= class(TTestCase)
  private
    FVehicleStorage : TVehicleStorage;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegister;
    procedure TestUpdate;
    procedure TestGet;
    procedure TestDelete;
  end;

implementation

procedure TTestVehicleStorage.SetUp;
begin
  FVehicleStorage := TVehicleStorage.Create;
end;

procedure TTestVehicleStorage.TearDown;
begin
  FVehicleStorage.Free;
end;

procedure TTestVehicleStorage.TestRegister;
var
  Vehicle : TVehicle;
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
  Expected := FVehicleStorage.Register(Vehicle);

  AssertTrue(
    'When testing Register of StorageTest, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
  );
end;

procedure TTestVehicleStorage.TestUpdate;
var
  Vehicle : TVehicle;
  Expected : TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
  Expected := FVehicleStorage.Update(Vehicle);

  AssertTrue(
    'When updating a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
  );
end;

procedure TTestVehicleStorage.TestGet;
var
  Vehicle: TVehicle;
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);
  Expected := FVehicleStorage.Get(Vehicle.getId);

  AssertTrue(
    'When getting a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
  );
end;

procedure TTestVehicleStorage.TestDelete;
var
  Expected: String;
begin
  Expected := FVehicleStorage.Delete('uid');

  AssertEquals(
    'When deleting a Vehicle, it retuns right message',
    'The Vehicle has been successfully deleted from the system.',
    Expected
  );
end;

initialization

  RegisterTest(TTestVehicleStorage);
end.

