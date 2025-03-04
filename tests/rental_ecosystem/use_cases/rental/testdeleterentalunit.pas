unit TestDeleteRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testregistry, RentalUnit,
  VehicleUnit, VehicleStatusUnit,
  IRentalStorageUnit, FakeRentalStorageUnit, DeleteRentalUnit,
  RegisterRentalUnit, FakeRenterStorageUnit, FakeVehicleStorageUnit,
  RenterUnit, IRenterStorageUnit, IVehicleStorageUnit, RentalDTOUnit,
  RenterExceptionsCreatorENUnit, VehicleExceptionsCreatorENUnit, RentalExceptionsCreatorENUnit, RentalBuilderUnit;

type

  TTestDeleteRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestDeleteRental.TestExecute;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;

  RentalBuilder: TRentalBuilder;

  RentalStorage: ITRentalStorage;
  VehicleStorage: ITVehicleStorage;
  RenterStorage: ITRenterStorage;

  RegisterRental: TRegisterRental;
  DeleteRental: TDeleteRental;

  Renter: TRenter;
  Vehicle: TVehicle;
  Rental: TRental;
  Data: TRentalInfoDTO;

  Expected: string;
begin
  // preparing test
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  RentalStorage := TFakeRentalStorage.Create(RentalExceptionsCreator);
  VehicleStorage := TFakeVehicleStorage.Create(VehicleExceptionsCreator);
  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  DeleteRental := TDeleteRental.Create(RentalStorage);

  Renter := TRenter.Create('renter_uuid', 'bob', 'address', 'email',
    '12432532', RenterExceptionsCreator);
  RenterStorage.Register(Renter);

  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN',
    20000, AVAILABLE, VehicleExceptionsCreator);
  VehicleStorage.Register(Vehicle);

  with Data do
  begin
    RenterId := Renter.getId;
    VehicleId := Vehicle.getId;
    StartDate := EncodeDate(2024, 12, 1);
    EndDate := EncodeDate(2024, 12, 31);
  end;

  Rental := RegisterRental.Execute(Data);

  // executing test
  Expected := DeleteRental.Execute(Rental.getId);

  AssertEquals(
    'When deleting a rental, it retuns right message',
    'The rental has been successfully deleted from the system.',
    Expected
    );
end;

initialization
  RegisterTest(TTestDeleteRental);
end.
