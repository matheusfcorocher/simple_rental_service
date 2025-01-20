unit RentalServiceExceptionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  // Renters exceptions
  RenterNameException = class(Exception);
  RenterAddressException = class(Exception);
  RenterEmailException = class(Exception);
  RenterTelephoneException = class(Exception);
  NotFoundRenterException = class(Exception);

  // Vehicles exceptions
  VehicleNameException = class(Exception);
  VehicleLicensePlateException = class(Exception);
  VehicleValueException = class(Exception);
  VehicleNotAvailableException = class(Exception);
  NotFoundVehicleException = class(Exception);

  // Rentals exceptions
  RangeRentalDateException = class(Exception);
  NotFoundRentalException = class(Exception);
implementation

end.

