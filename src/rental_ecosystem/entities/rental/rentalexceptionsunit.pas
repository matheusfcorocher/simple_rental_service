unit RentalExceptionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  RangeRentalDateException = class(Exception);
  NotFoundRentalException = class(Exception);

procedure CreateRangeRentalDateException;
procedure CreateNotFoundRentalException(id: string);

implementation

procedure CreateRangeRentalDateException;
begin
  Raise RangeRentalDateException.Create('Range of Rental Date is invalid, please checks if start date is before than end date.');
end;

procedure CreateNotFoundRentalException(id: string);
begin
  Raise NotFoundRentalException.Create('Rental with id ' + id + ' was not found');
end;

end.

