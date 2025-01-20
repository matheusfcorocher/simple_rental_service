unit RentalUtilsFunctionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit;

function RentalEquals(a, b: TRental): boolean;

implementation

function RentalEquals(a, b: TRental): boolean;
begin
  Result := (a.getId = b.getId) and (a.getRenterId = b.getRenterId) and
    (a.getVehicle = b.getVehicle) and (a.getStartDate = b.getStartDate) and
    (a.getEndDate = b.getEndDate);
end;

end.

