unit RegisterRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, RentalUnit, VehicleUnit, RenterUnit,
  IRentalStorageUnit, IVehicleStorageUnit, IRenterStorageUnit, VehicleStatusUnit, RentalDTOUnit;

type
  TRegisterRental = class
  private
    FRentalStorage: ITRentalStorage;
    FVehicleStorage: ITVehicleStorage;
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage;
      IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage);
    function Execute(rentalInfoDTO: TRentalInfoDTO): TRental;
  end;

implementation

constructor TRegisterRental.Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage);
begin
  FRentalStorage := IRentalStorage;
  FVehicleStorage := IVehicleStorage;
  FRenterStorage := IRenterStorage;
end;

function TRegisterRental.Execute(rentalInfoDTO: TRentalInfoDTO): TRental;
var
  Renter: TRenter;
  Vehicle: TVehicle;
  RentalId: string;
  Rental : TRental;
begin
  Renter := FRenterStorage.Get(rentalInfoDTO.RenterId);
  Vehicle := FVehicleStorage.Get(rentalInfoDTO.VehicleId);
  RentalId := FRentalStorage.GetNextId();

  Rental := TRental.Create(RentalId, Renter.getId, Vehicle,
    rentalInfoDTO.StartDate, rentalInfoDTO.EndDate);

  Rental := FRentalStorage.Register(rental);

  //Updates vehicle status from AVAILABLE to RENTED
  Vehicle.setStatus(RENTED);
  Vehicle := FVehicleStorage.Update(Vehicle);
  Rental.setVehicle(Vehicle);

  Result := Rental;
end;

end.
