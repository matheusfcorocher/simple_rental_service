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
  RegisterRenterUnit, RegisterVehicleUnit, VehicleDTOUnit, RenterDTOUnit,
  RenterExceptionsCreatorENUnit, RentalExceptionsCreatorENUnit, VehicleExceptionsCreatorENUnit,
  RenterBuilderUnit, VehicleBuilderUnit, RentalBuilderUnit, RentalUtilsFunctionsUnit;

type

  TTestUpdateRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestUpdateRental.TestExecute;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;

  RenterBuilder: TRenterBuilder;
  VehicleBuilder : TVehicleBuilder;
  RentalBuilder : TRentalBuilder;

  RentalStorage: ITRentalStorage;
  VehicleStorage: ITVehicleStorage;
  RenterStorage: ITRenterStorage;

  RegisterRenter: TRegisterRenter;
  RegisterVehicle: TRegisterVehicle;
  RegisterRental: TRegisterRental;
  UpdateRental: TUpdateRental;

  Renter: TRenter;
  RenterProfile: TRenterInfoDTO;

  Vehicle: TVehicle;
  VehicleDetails: TVehicleDetailsDTO;

  Rental: TRental;
  RentalInfoDTO: TRentalInfoDTO;
  RentalDTO: TRentalDTO;

  Expected: TRental;
begin
  // preparing test
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  RentalStorage := TFakeRentalStorage.Create(RentalExceptionsCreator);
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);
  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);

  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage, RenterStorage, RentalBuilder);
  UpdateRental := TUpdateRental.Create(RentalStorage, VehicleStorage, RenterStorage, RentalBuilder);

  with RenterProfile do
  begin
    Name := 'bob';
    address := 'address';
    email := 'email';
    telephone := '12432532';
  end;

  Renter := RegisterRenter.Execute(RenterProfile);

  with VehicleDetails do
  begin
    Name := 'corsa';
    licensePlate := 'MACLOVIN';
    Value := 20000;
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

  Expected := TRental.Create(Rental.getId,
    RentalDTO.RenterId, Vehicle, RentalDTO.StartDate, RentalDTO.EndDate, RentalExceptionsCreator);

  AssertTrue(
    'When updating a Rental, it retuns correct Rental',
    RentalEquals(Rental, Expected)
    );
end;



initialization

  RegisterTest(TTestUpdateRental);
end.
