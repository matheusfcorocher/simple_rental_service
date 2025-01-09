unit JSONConvertersUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRenterUnit,
  RegisterVehicleUnit, RenterUnit, VehicleUnit, VehicleStatusUnit, RentalUnit,
  RentalDTOUnit;

function JSONToRenter(JSON: TJSONObject): TRenter;
function JSONToRenterData(JSON: TJSONObject): TRenterData;

function JSONToVehicle(JSON: TJSONObject): TVehicle;
function JSONToVehicleData(JSON: TJSONObject): TVehicleData;

function JSONToRentalDTO(JSON: TJSONObject): TRentalDTO;
function JSONToRentalInfoDTO(JSON: TJSONObject): TRentalInfoDTO;

function JSONToId(JSON: TJSONObject): string;

implementation

function JSONToRenter(JSON: TJSONObject): TRenter;
var
  Renter: TRenter;
begin
  Result := TRenter.Create(JSON.Strings['id'], JSON.Strings['name'],
    JSON.Strings['address'], JSON.Strings['email'], JSON.Strings['telephone']);
end;

function JSONToRenterData(JSON: TJSONObject): TRenterData;
var
  RenterData: TRenterData;
begin
  with RenterData do
  begin
    name := JSON.Strings['name'];
    address := JSON.Strings['address'];
    email := JSON.Strings['email'];
    telephone := JSON.Strings['telephone'];
  end;

  Result := RenterData;
end;

function JSONToVehicle(JSON: TJSONObject): TVehicle;
var
  Vehicle: TVehicle;
begin
  Result := TVehicle.Create(JSON.Strings['id'], JSON.Strings['name'],
    JSON.Strings['licensePlate'], JSON.Integers['value'],
    StrToVehicleStatus(JSON.Strings['status']));
end;

function JSONToVehicleData(JSON: TJSONObject): TVehicleData;
var
  VehicleData: TVehicleData;
begin
  with VehicleData do
  begin
    name := JSON.Strings['name'];
    licensePlate := JSON.Strings['licensePlate'];
    value := JSON.Integers['value'];
    status := StrToVehicleStatus(JSON.Strings['status']);
  end;

  Result := VehicleData;
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
