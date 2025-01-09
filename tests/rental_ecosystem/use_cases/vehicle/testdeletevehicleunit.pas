unit TestDeleteVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, DeleteVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit, RegisterVehicleUnit;

type

  TTestDeleteVehicle= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestDeleteVehicle.TestExecute;
var
  VehicleStorage: ITVehicleStorage;
  RegisterVehicle: TRegisterVehicle;
  DeleteVehicle: TDeleteVehicle;
  Vehicle: TVehicle;
  VehicleData: TVehicleData;
  Expected: string;
begin
  // preparing test
  VehicleStorage := TFakeVehicleStorage.Create;

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  with VehicleData do
  begin
    name := 'corsa';
    licensePlate := 'MACLOVIN';
    value := 1000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleData);

  // executing test
  Expected := DeleteVehicle.Execute(Vehicle.getId);

  AssertEquals(
    'When deleting a Vehicle, it retuns right message',
    'The Vehicle has been successfully deleted from the system.',
    Expected
    );
end;

procedure TTestDeleteVehicle.SetUp;
begin

end;

procedure TTestDeleteVehicle.TearDown;
begin

end;

initialization

  RegisterTest(TTestDeleteVehicle);
end.

