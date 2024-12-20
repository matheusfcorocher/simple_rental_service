unit TestVehicleDTOUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, VehicleDTOUnit, VehicleStatusUnit;

type

  TTestVehicleDTOUnit = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCreateVehicleDTO;
    procedure TestAreVehicleDTOsEquals;
  end;

implementation

procedure TTestVehicleDTOUnit.TestCreateVehicleDTO;
var
  VehicleDTO_A: TVehicleDTO;
  VehicleDTO_B: TVehicleDTO;
begin
  VehicleDTO_A := CreateVehicleDTO('uid', 'name', 'car_number', 1234, AVAILABLE);
  VehicleDTO_B.id := 'uid';
  VehicleDTO_B.Name := 'name';
  VehicleDTO_B.licensePlate := 'car_number';
  VehicleDTO_B.Value := 1234;
  VehicleDTO_B.status := AVAILABLE;

  AssertTrue(
    'When creating a VehicleDTO with function, it retuns correct VehicleDTO',
    AreVehicleDTOsEquals(VehicleDTO_A, VehicleDTO_B)
    );
end;

procedure TTestVehicleDTOUnit.TestAreVehicleDTOsEquals;
var
  VehicleDTO_A: TVehicleDTO;
  VehicleDTO_B: TVehicleDTO;
begin
  VehicleDTO_A := CreateVehicleDTO('uid', 'name', 'car_number', 1234, AVAILABLE);
  VehicleDTO_B := CreateVehicleDTO('uid', 'name', 'car_number', 1234, AVAILABLE);

  AssertTrue(
    'When comparing equal VehicleDTOs, it retuns true',
    AreVehicleDTOsEquals(VehicleDTO_A, VehicleDTO_B)
    );
end;

procedure TTestVehicleDTOUnit.SetUp;
begin

end;

procedure TTestVehicleDTOUnit.TearDown;
begin

end;

initialization

  RegisterTest(TTestVehicleDTOUnit);
end.
