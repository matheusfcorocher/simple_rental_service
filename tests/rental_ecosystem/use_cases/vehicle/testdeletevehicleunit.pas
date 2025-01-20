unit TestDeleteVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, DeleteVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit,
  RegisterVehicleUnit, VehicleExceptionsCreatorENUnit, VehicleDTOUnit, VehicleBuilderUnit;

type

  TTestDeleteVehicle = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestDeleteVehicle.SetUp;
begin

end;

procedure TTestDeleteVehicle.TearDown;
begin

end;

procedure TTestDeleteVehicle.TestExecute;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  VehicleBuilder : TVehicleBuilder;
  VehicleStorage: ITVehicleStorage;

  RegisterVehicle: TRegisterVehicle;
  DeleteVehicle: TDeleteVehicle;

  Vehicle: TVehicle;
  VehicleDetailsDTO: TVehicleDetailsDTO;

  Expected: string;
begin
  // preparing test
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);

  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  with VehicleDetailsDTO do
  begin
    Name := 'corsa';
    licensePlate := 'MACLOVIN';
    Value := 1000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleDetailsDTO);

  // executing test
  Expected := DeleteVehicle.Execute(Vehicle.getId);

  AssertEquals(
    'When deleting a Vehicle, it retuns right message',
    'The Vehicle has been successfully deleted from the system.',
    Expected
    );
end;

initialization

  RegisterTest(TTestDeleteVehicle);
end.
