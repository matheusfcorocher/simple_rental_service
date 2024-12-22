unit TestDeleteVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, DeleteVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit;

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
  DeleteVehicle: TDeleteVehicle;
  Vehicle: TVehicle;
  Expected: string;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);

  VehicleStorage := TFakeVehicleStorage.Create;
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

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

