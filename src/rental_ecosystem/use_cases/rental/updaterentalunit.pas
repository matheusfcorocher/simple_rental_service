unit UpdateRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit, RenterUnit, VehicleUnit, RentalDTOUnit,
  IRentalStorageUnit, IVehicleStorageUnit, VehicleStatusUnit, IRenterStorageUnit, RentalBuilderUnit;

type
  TUpdateRental = class
  private
    _RentalStorage: ITRentalStorage;
    _VehicleStorage: ITVehicleStorage;
    _RenterStorage: ITRenterStorage;
    _RentalBuilder: TRentalBuilder;
  public
    constructor Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage; RentalBuilder: TRentalBuilder);
    function Execute(rentalDTO: TRentalDTO): TRental;
  end;

implementation

constructor TUpdateRental.Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage; RentalBuilder: TRentalBuilder);
begin
  _RentalStorage := IRentalStorage;
  _VehicleStorage := IVehicleStorage;
  _RenterStorage := IRenterStorage;
  _RentalBuilder := RentalBuilder;
end;

function TUpdateRental.Execute(rentalDTO: TRentalDTO): TRental;
var
  Renter: TRenter;
  Vehicle: TVehicle;
  Rental: TRental;
begin
  Rental := _RentalStorage.Get(rentalDTO.id);

  //Updates vehicle status from RENTED to AVAILABLE
  Vehicle := Rental.getVehicle();
  Vehicle.setStatus(AVAILABLE);
  _VehicleStorage.Update(Vehicle);

  Renter := _RenterStorage.Get(rentalDTO.RenterId);
  Vehicle := _VehicleStorage.Get(rentalDTO.VehicleId);

  // Checks if vehicle is available
  Vehicle.IsVehicleAvailable();

  // Create new Rental
  Rental := _RentalBuilder.Build(Rental.getId, Renter.getId, Vehicle,
    rentalDTO.StartDate, rentalDTO.EndDate);

  Rental.IsRentalValid();

  //Updates vehicle status from AVAILABLE to RENTED
  Vehicle.setStatus(RENTED);
  _VehicleStorage.Update(Vehicle);

  Result := _RentalStorage.Update(rental);
end;

end.
