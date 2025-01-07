unit ConsolePresenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, RenterUnit, VehicleUnit, RentalUnit, IPresenterUnit, VehicleStatusUnit;


type

  { TConsolePresenter }

  TConsolePresenter = class(TInterfacedObject, specialize ITPresenter<string>)
    function Present(Renter : TRenter) : string;
    function Present(Vehicle : TVehicle) : string; overload;
    function Present(Rental : TRental) : string; overload;
    function Present(message : String) : string; overload;
    function Present(error : Exception) : string; overload;
  end;

implementation

{ TConsolePresenter }

function TConsolePresenter.Present(Renter: TRenter): string;
var
  message : String;
begin
  message := 'Id: ' + Renter.getId + #13#10 +
             'Name: ' + Renter.getName + #13#10 +
             'Address: ' + Renter.getAddress + #13#10 +
             'Email: ' + Renter.getEmail + #13#10 +
             'Telephone: ' + Renter.getTelephone;

  result := message;
end;

function TConsolePresenter.Present(Vehicle: TVehicle): string;
var
  message : String;
begin
  message := 'Id: ' + Vehicle.getId + #13#10 +
             'Name: ' + Vehicle.getName + #13#10 +
             'License Plate: ' + Vehicle.getLicensePlate + #13#10 +
             'Value: ' + CurrToStr(Vehicle.getValue) + #13#10 +
             'Status: ' + VehicleStatusToStr(Vehicle.getStatus);

  result := message;
end;

function TConsolePresenter.Present(Rental: TRental): string;
var
  message : String;
  VehicleMessage : String;
begin
  VehicleMessage := Present(Rental.getVehicle);

  message := 'Id: ' + Rental.getId + #13#10 +
             'Name: ' + Rental.getRenterId + #13#10 +
             'Vehicle: ' + #13#10 + VehicleMessage + #13#10 +
             'Start Date: ' + FormatDateTime('DD MM YYYY', Rental.getStartDate) + #13#10 +
             'End Date: ' + FormatDateTime('DD MM YYYY', Rental.getEndDate);

  result := message;
end;

function TConsolePresenter.Present(message: String): string;
begin
  result := message + #13#10;
end;

function TConsolePresenter.Present(error: Exception): string;
begin
  result := error.Message + #13#10;
end;

end.

