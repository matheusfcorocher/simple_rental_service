unit UpdateRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit, RenterUnit, VehicleUnit, RentalDTOUnit,
  IRentalStorageUnit, IVehicleStorageUnit, VehicleStatusUnit, IRenterStorageUnit;

type
  TUpdateRental = class
  private
    FRentalStorage: ITRentalStorage;
    FVehicleStorage: ITVehicleStorage;
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage);
    function Execute(rentalDTO: TRentalDTO): TRental;
  end;

implementation

constructor TUpdateRental.Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage);
begin
  FRentalStorage := IRentalStorage;
  FVehicleStorage := IVehicleStorage;
  FRenterStorage := IRenterStorage;
end;

function TUpdateRental.Execute(rentalDTO: TRentalDTO): TRental;
var
  Renter: TRenter;
  Vehicle: TVehicle;
  Rental: TRental;
begin
  Rental := FRentalStorage.Get(rentalDTO.id);

  //Updates vehicle status from RENTED to AVAILABLE
  Vehicle := Rental.getVehicle();
  Vehicle.setStatus(AVAILABLE);
  FVehicleStorage.Update(Vehicle);

  Renter := FRenterStorage.Get(rentalDTO.RenterId);
  Vehicle := FVehicleStorage.Get(rentalDTO.VehicleId);

  // Checks if vehicle is available
  Vehicle.IsVehicleAvailable();

  // Create new Rental
  Rental := TRental.Create(Rental.getId, Renter.getId, Vehicle,
    rentalDTO.StartDate, rentalDTO.EndDate);

  //Updates vehicle status from AVAILABLE to RENTED
  Vehicle.setStatus(RENTED);
  FVehicleStorage.Update(Vehicle);

  Result := FRentalStorage.Update(rental);
end;

end.
