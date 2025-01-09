unit TestRegisterRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, DateUtils, testregistry,
  RenterUnit, VehicleUnit, VehicleStatusUnit,
  IRentalStorageUnit, IVehicleStorageUnit, IRenterStorageUnit,
  FakeRentalStorageUnit, FakeVehicleStorageUnit, FakeRenterStorageUnit,
  RegisterRentalUnit, RentalDTOUnit, RentalUnit;

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
  Renter: TRenter;
  Vehicle: TVehicle;
  Data: TRentalInfoDTO;
  Rental: TRental;
  Expected: TRental;
begin
  RentalStorage := TFakeRentalStorage.Create;
  VehicleStorage := TFakeVehicleStorage.Create;
  RenterStorage := TFakeRenterStorage.Create;

  Renter := TRenter.Create('renter_uuid', 'bob', 'address', 'email', '12432532');
  RenterStorage.Register(Renter);

  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);
  VehicleStorage.Register(Vehicle);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage, RenterStorage);

  with Data do
  begin
    RenterId := Renter.getId;
    VehicleId := Vehicle.getId;
    StartDate := EncodeDate(2024, 12, 1);
    EndDate := EncodeDate(2024, 12, 31);
  end;

  Rental := RegisterRental.Execute(Data);

  Expected := TRental.CreateWithoutBusinessRules(Rental.getId,
    Data.RenterId, Vehicle, Data.StartDate, Data.EndDate);


  AssertTrue(
    'When registering rental, it retuns correct message',
    RentalEquals(Rental, Expected)
    );
end;



initialization
  RegisterTest(TTestRegisterRental);
end.
