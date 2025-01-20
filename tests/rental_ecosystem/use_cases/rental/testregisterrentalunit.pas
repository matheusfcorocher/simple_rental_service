unit TestRegisterRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, DateUtils, testregistry,
  RenterUnit, VehicleUnit, VehicleStatusUnit,
  IRentalStorageUnit, IVehicleStorageUnit, IRenterStorageUnit,
  FakeRentalStorageUnit, FakeVehicleStorageUnit, FakeRenterStorageUnit,
  RegisterRentalUnit, RentalDTOUnit, RentalUnit, RentalExceptionsCreatorENUnit,
  VehicleExceptionsCreatorENUnit, RenterExceptionsCreatorENUnit, RentalBuilderUnit, RentalUtilsFunctionsUnit;

type

  TTestRegisterRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterRental.TestExecute;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;

  RenterStorage: ITRenterStorage;
  VehicleStorage: ITVehicleStorage;
  RentalStorage: ITRentalStorage;

  RentalBuilder : TRentalBuilder;

  RegisterRental: TRegisterRental;

  Renter: TRenter;
  Vehicle: TVehicle;
  Rental: TRental;

  Data: TRentalInfoDTO;
  Expected: TRental;
begin
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;


  RentalStorage := TFakeRentalStorage.Create(RentalExceptionsCreator);
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);
  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);

  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  Renter := TRenter.Create('renter_uuid', 'bob', 'address', 'email', '12432532', RenterExceptionsCreator);
  RenterStorage.Register(Renter);

  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE, VehicleExceptionsCreator);
  VehicleStorage.Register(Vehicle);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage, RenterStorage, RentalBuilder);

  with Data do
  begin
    RenterId := Renter.getId;
    VehicleId := Vehicle.getId;
    StartDate := EncodeDate(2024, 12, 1);
    EndDate := EncodeDate(2024, 12, 31);
  end;

  Rental := RegisterRental.Execute(Data);

  Expected := TRental.Create(Rental.getId, Data.RenterId, Vehicle, Data.StartDate, Data.EndDate, RentalExceptionsCreator);


  AssertTrue(
    'When registering rental, it retuns correct message',
    RentalEquals(Rental, Expected)
    );
end;



initialization
  RegisterTest(TTestRegisterRental);
end.
