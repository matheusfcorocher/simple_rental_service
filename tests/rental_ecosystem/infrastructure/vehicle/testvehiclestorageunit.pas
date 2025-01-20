unit TestVehicleStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,
  VehicleUnit,
  VehicleStorageUnit, VehicleStatusUnit, VehicleExceptionsCreatorENUnit, VehicleAuxFunctionsUnit, RentalServiceExceptionsUnit;

type

  { TTestVehicleStorage }

  TTestVehicleStorage= class(TTestCase)
  private
    _VehicleStorage : TVehicleStorage;
    _VehicleExceptionsCreator : TVehicleExceptionsCreatorEN;

    procedure _CreatingInvalidUpdateVehicle;
    procedure _CreatingInvalidGetVehicle;
    procedure _CreatingInvalidDeleteVehicle;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegister;

    procedure TestUpdate;
    procedure TestInvalidUpdate;

    procedure TestGet;
    procedure TestInvalidGet;

    procedure TestDelete;
    procedure TestInvalidDelete;
  end;

implementation

procedure TTestVehicleStorage.SetUp;
begin
  _VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  _VehicleStorage := TVehicleStorage.Create(_VehicleExceptionsCreator);
end;

procedure TTestVehicleStorage.TearDown;
begin

end;

procedure TTestVehicleStorage._CreatingInvalidUpdateVehicle;
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  _VehicleStorage.Update(Vehicle);
end;

procedure TTestVehicleStorage._CreatingInvalidGetVehicle;
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  _VehicleStorage.Get(Vehicle.getId);
end;

procedure TTestVehicleStorage._CreatingInvalidDeleteVehicle;
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  _VehicleStorage.Delete(Vehicle.getId);
end;

procedure TTestVehicleStorage.TestRegister;
var
  Vehicle : TVehicle;
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  Expected := _VehicleStorage.Register(Vehicle);

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
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  _VehicleStorage.Register(Vehicle);
  Expected := _VehicleStorage.Update(Vehicle);

  AssertTrue(
    'When updating a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
  );
end;

procedure TTestVehicleStorage.TestInvalidUpdate;
begin
  AssertException(
   'When trying to update vehicle that doesnt exist, return exception',
   NotFoundVehicleException,
   @_CreatingInvalidUpdateVehicle
  );
end;

procedure TTestVehicleStorage.TestGet;
var
  Vehicle: TVehicle;
  Expected: TVehicle;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  _VehicleStorage.Register(Vehicle);
  Expected := _VehicleStorage.Get(Vehicle.getId);

  AssertTrue(
    'When getting a Vehicle, it retuns correct Vehicle',
    VehicleEquals(Vehicle, Expected)
  );
end;

procedure TTestVehicleStorage.TestInvalidGet;
begin
  AssertException(
   'When trying to get vehicle that doesnt exist, return exception',
   NotFoundVehicleException,
   @_CreatingInvalidGetVehicle
  );
end;

procedure TTestVehicleStorage.TestDelete;
var
  Vehicle: TVehicle;
  Expected: String;
begin
  Vehicle := TVehicle.Create('uuid', 'corsa', 'MACLOVIN', 1000, AVAILABLE, _VehicleExceptionsCreator);
  _VehicleStorage.Register(Vehicle);
  Expected := _VehicleStorage.Delete('uuid');

  AssertEquals(
    'When deleting a Vehicle, it retuns right message',
    'The Vehicle has been successfully deleted from the system.',
    Expected
  );
end;

procedure TTestVehicleStorage.TestInvalidDelete;
begin
  AssertException(
   'When trying to delete vehicle that doesnt exist, return exception',
   NotFoundVehicleException,
   @_CreatingInvalidDeleteVehicle
  );
end;

initialization

  RegisterTest(TTestVehicleStorage);
end.

