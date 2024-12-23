unit RentalExceptionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  RangeRentalDateException = class(Exception);

procedure CreateRangeRentalDateException;

implementation

procedure CreateRangeRentalDateException;
begin
  Raise RangeRentalDateException.Create('Range of Rental Date is invalid, please checks if start date is before than end date.');
end;

end.

