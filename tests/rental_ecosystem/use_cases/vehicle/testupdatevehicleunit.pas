unit TestUpdateVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, UpdateVehicleUnit,
  FakeVehicleStorageUnit, VehicleUnit, IVehicleStorageUnit, VehicleStatusUnit,
  RegisterVehicleUnit, VehicleDTOUnit, VehicleExceptionsCreatorENUnit, VehicleAuxFunctionsUnit, VehicleBuilderUnit;

type

  TTestUpdateVehicle = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestVehicle;
  end;

implementation

procedure TTestUpdateVehicle.SetUp;
begin

end;

procedure TTestUpdateVehicle.TearDown;
begin

end;

procedure TTestUpdateVehicle.TestVehicle;
var
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;

  VehicleStorage: ITVehicleStorage;

  VehicleBuilder : TVehicleBuilder;
  RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle;

  Vehicle: TVehicle;
  VehicleDTO: TVehicleDTO;
  VehicleDetailsDTO: TVehicleDetailsDTO;
  Expected: TVehicle;
begin
  // preparing test
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage, VehicleBuilder);

  with VehicleDetailsDTO do
  begin
    Name := 'corsa';
    licensePlate := 'MACLOVIN';
    Value := 1000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleDetailsDTO);

  Vehicle.setName('Subaru');
  Expected := Vehicle;

  with VehicleDTO do
  begin
    id := Vehicle.getId;
    Name := 'Subaru';
    licensePlate := 'MACLOVIN';
    Value := 1000;
    status := AVAILABLE;
  end;

  // executing test
  Vehicle := UpdateVehicle.Execute(VehicleDTO);

  AssertTrue(
    'When updating a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
    );
end;

initialization

  RegisterTest(TTestUpdateVehicle);
end.
