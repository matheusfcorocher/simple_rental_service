unit TestGetVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, GetVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit,
  RegisterVehicleUnit, VehicleDTOUnit, VehicleExceptionsCreatorENUnit, VehicleAuxFunctionsUnit, VehicleBuilderUnit;

type

  TTestGetVehicle = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestGetVehicle.SetUp;
begin

end;

procedure TTestGetVehicle.TearDown;
begin

end;

procedure TTestGetVehicle.TestExecute;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  VehicleBuilder : TVehicleBuilder;
  VehicleStorage: ITVehicleStorage;

  RegisterVehicle: TRegisterVehicle;
  GetVehicle: TGetVehicle;

  Vehicle: TVehicle;
  VehicleDetailsDTO: TVehicleDetailsDTO;

  Expected: TVehicle;
begin
  // preparing test
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);

  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);
  GetVehicle := TGetVehicle.Create(VehicleStorage);

  with VehicleDetailsDTO do
  begin
    Name := 'corsa';
    licensePlate := 'MACLOVIN';
    Value := 1000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleDetailsDTO);
  Expected := Vehicle;
  // Executing tests

  Vehicle := GetVehicle.Execute(Vehicle.getId);

  AssertTrue(
    'When getting a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
    );
end;

initialization

  RegisterTest(TTestGetVehicle);
end.
