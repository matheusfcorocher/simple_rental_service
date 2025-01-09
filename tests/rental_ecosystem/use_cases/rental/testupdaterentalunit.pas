unit TestUpdateRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testutils, testregistry,
  VehicleUnit, VehicleStatusUnit, RenterUnit, RentalUnit, RentalDTOUnit,
  IRentalStorageUnit,
  IVehicleStorageUnit, IRenterStorageUnit,
  FakeRentalStorageUnit, FakeVehicleStorageUnit,
  FakeRenterStorageUnit, UpdateRentalUnit, RegisterRentalUnit,
  RegisterRenterUnit, RegisterVehicleUnit;

type

  TTestUpdateRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestUpdateRental.TestExecute;
var
  RentalStorage: ITRentalStorage;
  VehicleStorage: ITVehicleStorage;
  RenterStorage: ITRenterStorage;

  RegisterRenter: TRegisterRenter;
  RegisterVehicle: TRegisterVehicle;
  RegisterRental: TRegisterRental;
  UpdateRental: TUpdateRental;

  Renter: TRenter;
  RenterProfile: TRenterData;

  Vehicle: TVehicle;
  VehicleDetails: TVehicleData;

  Rental: TRental;
  RentalInfoDTO: TRentalInfoDTO;
  RentalDTO: TRentalDTO;

  Expected: TRental;
begin
  // preparing test
  RentalStorage := TFakeRentalStorage.Create;
  VehicleStorage := TFakeVehicleStorage.Create;
  RenterStorage := TFakeRenterStorage.Create;

  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage, RenterStorage);
  UpdateRental := TUpdateRental.Create(RentalStorage, VehicleStorage, RenterStorage);

  with RenterProfile do
  begin
    name := 'bob';
    address := 'address';
    email := 'email';
    telephone := '12432532';
  end;

  Renter := RegisterRenter.Execute(RenterProfile);

  with VehicleDetails do
  begin
    name := 'corsa';
    licensePlate := 'MACLOVIN';
    value := 20000;
    status := AVAILABLE;
  end;

  Vehicle := RegisterVehicle.Execute(VehicleDetails);

  with RentalInfoDTO do
  begin
    RenterId := Renter.getId;
    VehicleId := Vehicle.getId;
    StartDate := EncodeDate(2024, 12, 1);
    EndDate := EncodeDate(2024, 12, 31);
  end;

  Rental := RegisterRental.Execute(RentalInfoDTO);

  with RentalDTO do
  begin
    Id := Rental.getId;
    RenterId := Renter.getId;
    VehicleId := Vehicle.getId;
    StartDate := EncodeDate(2024, 12, 20);
    EndDate := EncodeDate(2024, 12, 31);
  end;

  // executing test
  Rental := UpdateRental.Execute(RentalDTO);

  Expected := TRental.CreateWithoutBusinessRules(Rental.getId, RentalDTO.RenterId, Vehicle,
    RentalDTO.StartDate, RentalDTO.EndDate);

  AssertTrue(
    'When updating a Rental, it retuns correct Rental',
    RentalEquals(Rental, Expected)
    );
end;



initialization

  RegisterTest(TTestUpdateRental);
end.
