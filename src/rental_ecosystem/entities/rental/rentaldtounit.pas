unit RentalDTOUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit;

type
  TRentalDTO = record
    Id: String;
    RenterId: String;
    VehicleId: String;
    StartDate: TDateTime;
    EndDate: TDateTime;
  end;

  TRentalInfoDTO = record
    RenterId: String;
    VehicleId: String;
    StartDate: TDateTime;
    EndDate: TDateTime;
  end;

function CreateRentalDTO(rental: TRental): TRentalDTO;

implementation

function CreateRentalDTO(rental: TRental): TRentalDTO;
var
  RentalDTO: TRentalDTO;
begin
  with RentalDTO do
  begin
   Id := rental.getId();
   RenterId := rental.getRenterId();
   VehicleId := rental.getVehicle().getId();
   StartDate := rental.getStartDate();
   EndDate := rental.getEndDate();
  end;


  Result := RentalDTO;
end;

end.

