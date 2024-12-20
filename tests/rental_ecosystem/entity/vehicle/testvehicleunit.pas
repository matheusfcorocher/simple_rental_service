unit TestVehicleUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, VehicleUnit,
  VehicleStatusUnit, VehicleDTOUnit, Generics.Collections, VehicleExceptionsUnit;

type

  TTestVehicle = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  private
    procedure _CreatingInvalidNameForVehicle;
    procedure _CreatingInvalidLicensePlateForVehicle;
    procedure _CreatingInvalidValueForVehicle;

    procedure _CreatingInvalidNameForVehicleDTO;
    procedure _CreatingInvalidLicensePlateForVehicleDTO;
    procedure _CreatingInvalidValueForVehicleDTO;

    procedure _UpdatingWithInvalidName;
    procedure _UpdatingWithInvalidLicensePlate;
    procedure _UpdatingWithInvalidValue;

  published
    procedure TestCreatingVehicleWithValidData;
    procedure TestCreatingVehicleWithInvalidData;

    procedure TestCreatingVehicleWithDTOAndValidData;
    procedure TestCreatingVehicleWithDTOAndInvalidData;

    procedure TestUpdatingVehicleNameWithValidData;
    procedure TestUpdatingVehicleNameWithInvalidData;

    procedure TestUpdatingVehicleLicensePlateWithValidData;
    procedure TestUpdatingVehicleLicensePlateWithInvalidData;

    procedure TestUpdatingVehicleValueWithValidData;
    procedure TestUpdatingVehicleValueWithInvalidData;

    procedure TestTransformingVehiclesToObjectList;
    procedure TestVehicleEquals;
  end;

implementation

procedure TTestVehicle.SetUp;
begin

end;

procedure TTestVehicle.TearDown;
begin

end;

//-----------

procedure TTestVehicle.TestCreatingVehicleWithValidData;
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

procedure TTestVehicle.TestCreatingVehicleWithInvalidData;
begin
  AssertException(
   'When is created a vehicle with invalid name, it retuns exception',
   VehicleNameException,
   @_CreatingInvalidNameForVehicle
  );

  AssertException(
   'When is created a vehicle with invalid license plate, it retuns exception',
   VehicleLicensePlateException,
   @_CreatingInvalidLicensePlateForVehicle
  );

  AssertException(
   'When is created a vehicle with invalid value, it retuns exception',
   VehicleValueException,
   @_CreatingInvalidValueForVehicle
  );
end;

//--------------

procedure TTestVehicle.TestCreatingVehicleWithDTOAndValidData;
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

procedure TTestVehicle.TestCreatingVehicleWithDTOAndInvalidData;
begin
  AssertException(
   'When is created a vehicle DTO with invalid name, it retuns exception',
   VehicleNameException,
   @_CreatingInvalidNameForVehicleDTO
  );

  AssertException(
   'When is created a vehicle DTO with invalid license plate, it retuns exception',
   VehicleLicensePlateException,
   @_CreatingInvalidLicensePlateForVehicleDTO
  );

  AssertException(
   'When is created a vehicle DTO with invalid value, it retuns exception',
   VehicleValueException,
   @_CreatingInvalidValueForVehicleDTO
  );
end;

//--------------

procedure TTestVehicle.TestUpdatingVehicleNameWithValidData;
var
  Vehicle: TVehicle;
  Name: String;
  Expected: TVehicle;
begin
  try
    Name := 'Opala';
    Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
    Vehicle.setName(Name);
    Expected := TVehicle.Create('uid', Name, 'car_number', 1234, AVAILABLE);

    AssertTrue(
      'When creating a vehicle, it retuns vehicle instance',
      VehicleEquals(Expected, Vehicle)
      );
  finally
    Vehicle.Free;
    Expected.Free;
  end;
end;

procedure TTestVehicle.TestUpdatingVehicleNameWithInvalidData;
begin
  AssertException(
   'When is updating a vehicle with invalid name, it retuns exception',
   VehicleNameException,
   @_UpdatingWithInvalidName
  );
end;

//--------------

procedure TTestVehicle.TestUpdatingVehicleLicensePlateWithValidData;
var
  Vehicle: TVehicle;
  LicensePlate : String;
  Expected: TVehicle;
begin
  try
    LicensePlate := 'MACLOVIN';
    Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
    Vehicle.setLicensePlate(LicensePlate);
    Expected := TVehicle.Create('uid', 'name', LicensePlate, 1234, AVAILABLE);

    AssertTrue(
      'When updating license plate of vehicle, it retuns vehicle instance',
      VehicleEquals(Expected, Vehicle)
      );
  finally
    Vehicle.Free;
    Expected.Free;
  end;
end;

procedure TTestVehicle.TestUpdatingVehicleLicensePlateWithInvalidData;
begin
  AssertException(
   'When is updating a vehicle with invalid license plate, it retuns exception',
   VehicleLicensePlateException,
   @_UpdatingWithInvalidLicensePlate
  );
end;

//--------------

procedure TTestVehicle.TestUpdatingVehicleValueWithValidData;
var
  Vehicle: TVehicle;
  Value : Currency;
  Expected: TVehicle;
begin
  try
    Value := 9000;
    Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
    Vehicle.setValue(Value);
    Expected := TVehicle.Create('uid', 'name', 'car_number', Value, AVAILABLE);

    AssertTrue(
      'When updating license plate of vehicle, it retuns vehicle instance',
      VehicleEquals(Expected, Vehicle)
      );
  finally
    Vehicle.Free;
    Expected.Free;
  end;
end;

procedure TTestVehicle.TestUpdatingVehicleValueWithInvalidData;
begin
  AssertException(
   'When is updating a vehicle with invalid value, it retuns exception',
   VehicleValueException,
   @_UpdatingWithInvalidValue
  );
end;

//------------

procedure TTestVehicle.TestTransformingVehiclesToObjectList;
var
  Vehicles: TVehicles;
  ObjectList: specialize TObjectList<TObject>;
begin
  Vehicles := TVehicles.Create;
  Vehicles.Add(TVehicle.Create('uid1', 'name', 'car_number', 1234, AVAILABLE));
  Vehicles.Add(TVehicle.Create('uid2', 'name', 'car_number', 1234, AVAILABLE));
  Vehicles.Add(TVehicle.Create('uid3', 'name', 'car_number', 1234, AVAILABLE));

  ObjectList := Vehicles.ToObjectList();

  AssertEquals(
    'When is transform vehicles to object, it retuns right object',
    ObjectList.Count, Vehicles.Count);
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

// private methods for exceptions

procedure TTestVehicle._CreatingInvalidNameForVehicle;
begin
  TVehicle.Create('uid', 'ne', 'car_number', 1234, AVAILABLE);
end;

procedure TTestVehicle._CreatingInvalidLicensePlateForVehicle;
begin
  TVehicle.Create('uid', 'name', 'ber', 1234, AVAILABLE);
end;

procedure TTestVehicle._CreatingInvalidValueForVehicle;
begin
  TVehicle.Create('uid', 'name', 'berertss', -1000, AVAILABLE);
end;

procedure TTestVehicle._CreatingInvalidNameForVehicleDTO;
var
  VehicleDTO : TVehicleDTO;
begin
  VehicleDTO := CreateVehicleDTO('uid', 'ne', 'car_number', 1234, AVAILABLE);
  TVehicle.Create(VehicleDTO);
end;

procedure TTestVehicle._CreatingInvalidLicensePlateForVehicleDTO;
var
  VehicleDTO : TVehicleDTO;
begin
  VehicleDTO := CreateVehicleDTO('uid', 'name', 'ber', 1234, AVAILABLE);
  TVehicle.Create(VehicleDTO);
end;

procedure TTestVehicle._CreatingInvalidValueForVehicleDTO;
var
  VehicleDTO : TVehicleDTO;
begin
  VehicleDTO := CreateVehicleDTO('uid', 'name', 'berertss', -1000, AVAILABLE);
  TVehicle.Create(VehicleDTO);
end;

procedure TTestVehicle._UpdatingWithInvalidName;
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
  Vehicle.setName('na');
end;

procedure TTestVehicle._UpdatingWithInvalidLicensePlate;
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
  Vehicle.setLicensePlate('12');
end;

procedure TTestVehicle._UpdatingWithInvalidValue;
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create('uid', 'name', 'car_number', 1234, AVAILABLE);
  Vehicle.setValue(-1200);
end;

initialization

  RegisterTest(TTestVehicle);
end.