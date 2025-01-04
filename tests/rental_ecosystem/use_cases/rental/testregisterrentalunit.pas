unit TestRegisterRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, DateUtils, testregistry,
  VehicleUnit, VehicleStatusUnit,
  IRentalStorageUnit, IVehicleStorageUnit, IRenterStorageUnit,
  FakeRentalStorageUnit, FakeVehicleStorageUnit, FakeRenterStorageUnit,
  RegisterRentalUnit;

type

  TTestRegisterRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterRental.TestExecute;
var
  RenterStorage: ITRenterStorage;
  VehicleStorage: ITVehicleStorage;
  RentalStorage: ITRentalStorage;
  RegisterRental: TRegisterRental;
  Vehicle: TVehicle;
  Data: TRegisterRentalData;
  Message: String;
const
  Expected = 'Rental created successfully!';
begin
  RentalStorage := TFakeRentalStorage.Create;
  VehicleStorage := TFakeVehicleStorage.Create;
  RenterStorage := TFakeRenterStorage.Create;

  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  VehicleStorage.Register(Vehicle);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage, RenterStorage);

  with Data do
  begin
    RenterId := 'renter_uuid';
    VehicleId := 'vehicle_uuid';
    StartDate := EncodeDate(2024, 12, 1);
    EndDate := EncodeDate(2024, 12, 31);
  end;

  Message := RegisterRental.Execute(Data);

  AssertEquals(
    'When registering rental, it retuns correct message',
    Message,
    Expected
  );
end;



initialization

  RegisterTest(TTestRegisterRental);
end.
