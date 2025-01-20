unit ExceptionsErrorCodeUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalServiceExceptionsUnit;

function getErrorCode(E: Exception) : Integer;

implementation

function getErrorCode(E: Exception) : Integer;
var
  ErrorCode : Integer;
begin
  case E.ClassName of
    //rentals
    'RangeRentalDateException':
      ErrorCode := 400;
    'NotFoundRentalException':
      ErrorCode := 404;
    //renters
    'RenterNameException':
      ErrorCode := 400;
    'RenterAddressException':
      ErrorCode := 400;
    'RenterEmailException':
      ErrorCode := 400;
    'RenterTelephoneException':
      ErrorCode := 400;
    'NotFoundRenterException':
      ErrorCode := 404;
    //vehicles
    'VehicleNameException':
      ErrorCode := 400;
    'VehicleLicensePlateException':
      ErrorCode := 400;
    'VehicleValueException':
      ErrorCode := 400;
    'VehicleNotAvailableException':
      ErrorCode := 400;
    'NotFoundVehicleException':
      ErrorCode := 404;
    else
      ErrorCode := 500;
  end;

  result := ErrorCode;
end;

end.



