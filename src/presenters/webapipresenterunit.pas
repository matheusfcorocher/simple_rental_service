unit WebAPIPresenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpjson, RenterUnit, VehicleUnit,
  RentalUnit, IPresenterUnit, VehicleStatusUnit, SystemResponseUnit,
  StandardResponsesUnit, ExceptionsErrorCodeUnit;

type

  { TWebAPIPresenter }

  TWebAPIPresenter = class(TInterfacedObject, specialize ITPresenter<TJSONObject>)
    function Present(Renter: TRenter): TJSONObject;
    function Present(Vehicle: TVehicle): TJSONObject; overload;
    function Present(Rental: TRental): TJSONObject; overload;
    function Present(message: string): TJSONObject; overload;
    function Present(error: Exception): TJSONObject; overload;
  end;

implementation

{ TWebAPIPresenter }

function TWebAPIPresenter.Present(Renter: TRenter): TJSONObject;
var
  Response: TJSONObject;
  RenterJSON: TJSONObject;
begin
  Response := TJSONObject.Create;
  Response.Add('success', True);
  Response.Add('code', 200);
  Response.Add('title', 'Operation was successful!');
  Response.Add('message', 'Operation was successful!');

  RenterJSON := TJSONObject.Create;
  RenterJSON.Add('id', Renter.getId);
  RenterJSON.Add('name', Renter.getName);
  RenterJSON.Add('address', Renter.getAddress);
  RenterJSON.Add('email', Renter.getEmail);
  RenterJSON.Add('telephone', Renter.getTelephone);

  Response.Add('data', RenterJSON );

  result := Response;
end;

function TWebAPIPresenter.Present(Vehicle: TVehicle): TJSONObject;
var
  Response: TJSONObject;
  VehicleJSON: TJSONObject;
begin
  Response := TJSONObject.Create;
  Response.Booleans['success'] := True;
  Response.Integers['code'] := 200;
  Response.Strings['title'] := 'Operation was successful!';
  Response.Strings['message'] := 'Operation was successful!';

  VehicleJSON := TJSONObject.Create;
  VehicleJSON.Add('id', Vehicle.getId);
  VehicleJSON.Add('name', Vehicle.getName);
  VehicleJSON.Add('licensePlate', Vehicle.getLicensePlate);
  VehicleJSON.Add('value', Vehicle.getValue);
  VehicleJSON.Add('status', VehicleStatusToStr(Vehicle.getStatus));

  Response.Add('data', VehicleJSON);

  result := Response;
end;

function TWebAPIPresenter.Present(Rental: TRental): TJSONObject;
var
  Response: TJSONObject;
  RentalJSON: TJSONObject;
  VehicleJSON: TJSONObject;
begin
  Response := TJSONObject.Create;
  Response.Booleans['success'] := True;
  Response.Integers['code'] := 200;
  Response.Strings['title'] := 'Operation was successful!';
  Response.Strings['message'] := 'Operation was successful!';

  VehicleJSON := TJSONObject.Create;
  VehicleJSON.Add('id', Rental.getVehicle.getId);
  VehicleJSON.Add('name', Rental.getVehicle.getName);
  VehicleJSON.Add('licensePlate', Rental.getVehicle.getLicensePlate);
  VehicleJSON.Add('value', Rental.getVehicle.getValue);
  VehicleJSON.Add('status', VehicleStatusToStr(Rental.getVehicle.getStatus));

  RentalJSON := TJSONObject.Create;
  RentalJSON.Add('id', Rental.getId);
  RentalJSON.Add('renter_id', Rental.getRenterId);
  RentalJSON.Add('vehicle', VehicleJSON);
  RentalJSON.Add('start_date', FormatDateTime('DD MM YYYY', Rental.getStartDate));
  RentalJSON.Add('end_date', FormatDateTime('DD MM YYYY', Rental.getEndDate));

  Response.Add('data', RentalJSON);

  result := Response;
end;

function TWebAPIPresenter.Present(message: string): TJSONObject;
var
  Response: TJSONObject;
begin
  Response := TJSONObject.Create;
  Response.Booleans['success'] := True;
  Response.Integers['code'] := 200;
  Response.Strings['title'] := 'Operation was successful!';
  Response.Strings['message'] := message;

  result := Response;
end;

function TWebAPIPresenter.Present(error: Exception): TJSONObject;
var
  Response: TJSONObject;
begin
  Response := TJSONObject.Create;
  Response.Booleans['success'] := False;
  Response.Integers['code'] := getErrorCode(error);
  Response.Strings['title'] := 'Operation has failed!';
  Response.Strings['message'] := Error.Message;

  result := Response;
end;

end.
