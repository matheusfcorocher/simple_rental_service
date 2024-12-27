unit RegisterRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, RentalUnit, VehicleUnit, RenterUnit,
  IRentalStorageUnit, IVehicleStorageUnit, IRenterStorageUnit, VehicleStatusUnit;

type
  TRegisterRentalData = record
    RenterId: string;
    VehicleId: string;
    StartDate: TDateTime;
    EndDate: TDateTime;
  end;

  TRegisterRental = class
  private
    FRentalStorage: ITRentalStorage;
    FVehicleStorage: ITVehicleStorage;
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage;
      IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage);
    function Execute(data: TRegisterRentalData): string;
  end;

implementation

constructor TRegisterRental.Create(IRentalStorage: ITRentalStorage;
  IVehicleStorage: ITVehicleStorage; IRenterStorage: ITRenterStorage);
begin
  FRentalStorage := IRentalStorage;
  FVehicleStorage := IVehicleStorage;
  FRenterStorage := IRenterStorage;
end;

function TRegisterRental.Execute(data: TRegisterRentalData): string;
var
  Renter: TRenter;
  Vehicle: TVehicle;
  RentalId: string;
  Rental : TRental;
begin
  Renter := FRenterStorage.Get(data.RenterId);
  Vehicle := FVehicleStorage.Get(data.VehicleId);
  RentalId := FRentalStorage.GetNextId();

  Rental := TRental.Create(RentalId, Renter.getId, Vehicle,
    data.StartDate, data.EndDate);

  FRentalStorage.Register(rental);

  //Updates vehicle status from AVAILABLE to RENTED
  Vehicle.setStatus(RENTED);
  FVehicleStorage.Update(Vehicle);

  Result := 'Rental created successfully!';
end;

end.
