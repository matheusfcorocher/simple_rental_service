unit TestRegisterVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, RegisterVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit,
  VehicleDTOUnit, VehicleExceptionsCreatorENUnit, VehicleBuilderUnit, VehicleAuxFunctionsUnit;

type

  TTestRegisterVehicle = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterVehicle.SetUp;
begin

end;

procedure TTestRegisterVehicle.TearDown;
begin

end;

procedure TTestRegisterVehicle.TestExecute;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;

  VehicleStorage: ITVehicleStorage;
  VehicleBuilder : TVehicleBuilder;

  RegisterVehicle: TRegisterVehicle;
  Vehicle: TVehicle;
  VehicleDetailsDTO: TVehicleDetailsDTO;
  Expected: TVehicle;
begin
  // preparing test
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);

  Expected := VehicleBuilder.Build('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE);

  with VehicleDetailsDTO do
  begin
    Name := Expected.getName;
    licensePlate := Expected.getLicensePlate;
    Value := Expected.getValue;
    status := Expected.getStatus;
  end;

  // executing test
  Vehicle := RegisterVehicle.Execute(VehicleDetailsDTO);

  AssertTrue(
    'When executing RegisterVehicle, it retuns correct Vehicles',
    VehicleEquals(Vehicle, Expected)
    );
end;

initialization

  RegisterTest(TTestRegisterVehicle);
end.
