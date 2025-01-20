unit JSONConvertersUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRenterUnit,
  RegisterVehicleUnit, RenterUnit, VehicleUnit, VehicleStatusUnit, RentalUnit,
  RentalDTOUnit, RenterDTOUnit, VehicleDTOUnit;

function JSONToRenterDTO(JSON: TJSONObject): TRenterDTO;
function JSONToRenterInfoDTO(JSON: TJSONObject): TRenterInfoDTO;

function JSONToVehicleDTO(JSON: TJSONObject): TVehicleDTO;
function JSONToVehicleDetailsDTO(JSON: TJSONObject): TVehicleDetailsDTO;

function JSONToRentalDTO(JSON: TJSONObject): TRentalDTO;
function JSONToRentalInfoDTO(JSON: TJSONObject): TRentalInfoDTO;

function JSONToId(JSON: TJSONObject): string;

implementation

function JSONToRenterDTO(JSON: TJSONObject): TRenterDTO;
var
  RenterDTO : TRenterDTO;
begin
  with RenterDTO do
  begin
    id := JSON.Strings['id'];
    name := JSON.Strings['name'];
    address := JSON.Strings['address'];
    email := JSON.Strings['email'];
    telephone := JSON.Strings['telephone'];
  end;

  Result := RenterDTO;
end;

function JSONToRenterInfoDTO(JSON: TJSONObject): TRenterInfoDTO;
var
  RenterInfoDTO: TRenterInfoDTO;
begin
  with RenterInfoDTO do
  begin
    name := JSON.Strings['name'];
    address := JSON.Strings['address'];
    email := JSON.Strings['email'];
    telephone := JSON.Strings['telephone'];
  end;

  Result := RenterInfoDTO;
end;

function JSONToVehicleDTO(JSON: TJSONObject): TVehicleDTO;
var
  VehicleDTO: TVehicleDTO;
begin
  with VehicleDTO do
  begin
    id := JSON.Strings['id'];
    Name := JSON.Strings['name'];
    licensePlate := JSON.Strings['licensePlate'];
    Value := JSON.Integers['value'];
    status := StrToVehicleStatus(JSON.Strings['status']);
  end;

  Result := VehicleDTO;
end;

function JSONToVehicleDetailsDTO(JSON: TJSONObject): TVehicleDetailsDTO;
var
  VehicleDetailsDTO: TVehicleDetailsDTO;
begin
  with VehicleDetailsDTO do
  begin
    name := JSON.Strings['name'];
    licensePlate := JSON.Strings['licensePlate'];
    value := JSON.Integers['value'];
    status := StrToVehicleStatus(JSON.Strings['status']);
  end;

  Result := VehicleDetailsDTO;
end;

function JSONToRentalDTO(JSON: TJSONObject): TRentalDTO;
var
  RentalDTO: TRentalDTO;
begin
  with RentalDTO do
  begin
    Id := JSON.Strings['id'];
    RenterId := JSON.Strings['renter_id'];
    VehicleId := JSON.Strings['vehicle_id'];
    StartDate := StrToDateTime(Copy(JSON.Strings['start_date'], 1, 10));
    EndDate := StrToDateTime(Copy(JSON.Strings['end_date'], 1, 10));
  end;


  Result := RentalDTO;
end;

function JSONToRentalInfoDTO(JSON: TJSONObject): TRentalInfoDTO;
var
  RentalInfoDTO: TRentalInfoDTO;
begin
  with RentalInfoDTO do
  begin
    RenterId := JSON.Strings['renter_id'];
    VehicleId := JSON.Strings['vehicle_id'];
    StartDate := StrToDateTime(Copy(JSON.Strings['start_date'], 1, 10));
    EndDate := StrToDateTime(Copy(JSON.Strings['end_date'], 1, 10));
  end;

  Result := RentalInfoDTO;
end;

function JSONToId(JSON: TJSONObject): string;
begin
  Result := JSON.Strings['id'];
end;

end.
