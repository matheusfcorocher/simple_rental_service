unit RegisterRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, RentalUnit, VehicleUnit, RenterUnit,
  IRentalStorageUnit, IVehicleStorageUnit, IRenterStorageUnit,
  VehicleStatusUnit, RentalDTOUnit, RentalBuilderUnit;

type
  TRegisterRental = class
  private
    _RentalStorage: ITRentalStorage;
    _VehicleStorage: ITVehicleStorage;
    _RenterStorage: ITRenterStorage;

    _RentalBuilder: TRentalBuilder;
  public
    constructor Create(IRentalStorage: ITRentalStorage;
      IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage; RentalBuilder: TRentalBuilder);
    function Execute(rentalInfoDTO: TRentalInfoDTO): TRental;
  end;

implementation

constructor TRegisterRental.Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage; RentalBuilder: TRentalBuilder);
begin
  _RentalStorage := IRentalStorage;
  _VehicleStorage := IVehicleStorage;
  _RenterStorage := IRenterStorage;
  _RentalBuilder := RentalBuilder;
end;

function TRegisterRental.Execute(rentalInfoDTO: TRentalInfoDTO): TRental;
var
  Renter: TRenter;
  Vehicle: TVehicle;
  RentalId: string;
  Rental: TRental;
begin
  Renter := _RenterStorage.Get(rentalInfoDTO.RenterId);
  Vehicle := _VehicleStorage.Get(rentalInfoDTO.VehicleId);
  RentalId := _RentalStorage.GetNextId();

  Rental := _RentalBuilder.Build(RentalId, Renter.getId, Vehicle,
    rentalInfoDTO.StartDate, rentalInfoDTO.EndDate);

  // checks if rental is valid
  Rental.IsRentalValid;

  Rental := _RentalStorage.Register(rental);

  //Updates vehicle status from AVAILABLE to RENTED
  Vehicle.setStatus(RENTED);
  Vehicle := _VehicleStorage.Update(Vehicle);
  Rental.setVehicle(Vehicle);

  Result := Rental;
end;

end.
