unit IExceptionsCreatorUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRenterExceptionsCreatorUnit, IVehicleExceptionsCreatorUnit,
  IRentalExceptionsCreatorUnit;

type
  ITExceptionCreator = interface
    function GetRenterExceptionsCreator(): ITRenterExceptionsCreator;
    function GetVehicleExceptionsCreator(): ITVehicleExceptionsCreator;
    function GetRentalExceptionsCreator(): ITRentalExceptionsCreator;
  end;

implementation

end.
