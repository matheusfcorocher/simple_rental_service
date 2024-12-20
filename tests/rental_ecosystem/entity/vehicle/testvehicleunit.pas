unit TestVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, VehicleUnit,
  VehicleStatusUnit, VehicleDTOUnit;

type

  TTestVehicle = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCreatingVehicle;
    procedure TestCreatingVehicleWithDTO;
    procedure TestVehicleEquals;
  end;

implementation

procedure TTestVehicle.TestCreatingVehicle;
var
  Vehicle: TVehicle;
  Expected: TVehicle;
begin
  try
    Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
    Expected := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);

    AssertTrue(
      'When creating a vehicle, it retuns vehicle instance',
      VehicleEquals(Expected, Vehicle)
      );
  finally
    Vehicle.Free;
    Expected.Free;
  end;
end;

procedure TTestVehicle.TestCreatingVehicleWithDTO;
var
  VehicleDTO: TVehicleDTO;
  Vehicle: TVehicle;
  Expected: TVehicle;
begin
  try
    VehicleDTO := CreateVehicleDTO('uid', 'name', 'car_number', 1234, AVAILABLE);
    Vehicle := TVehicle.Create(VehicleDTO);
    Expected := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);

    AssertTrue(
      'When creating vehicle with DTO, it retuns renter instance',
      VehicleEquals(Expected, Vehicle)
      );
  finally
    Vehicle.Free;
    Expected.Free;
  end;
end;

procedure TTestVehicle.TestVehicleEquals;
var
  Vehicle_A: TVehicle;
  Vehicle_B: TVehicle;
begin
  try
    Vehicle_A := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
    Vehicle_B := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);

    AssertTrue(
      'When is given two vehicle with same data, it retuns true',
      VehicleEquals(Vehicle_A, Vehicle_B)
    );
  finally
    Vehicle_A.Free;
    Vehicle_B.Free;
  end;
end;

procedure TTestVehicle.SetUp;
begin

end;

procedure TTestVehicle.TearDown;
begin

end;

initialization

  RegisterTest(TTestVehicle);
end.
