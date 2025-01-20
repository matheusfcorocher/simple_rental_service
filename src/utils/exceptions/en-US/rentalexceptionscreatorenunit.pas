unit RentalExceptionsCreatorENUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRentalExceptionsCreatorUnit, RentalServiceExceptionsUnit;

type
  TRentalExceptionsCreatorEN = class(TInterfacedObject, ITRentalExceptionsCreator)
    public
      procedure CreateRangeRentalDateException;
      procedure CreateNotFoundRentalException(id: string);
  end;


implementation

procedure TRentalExceptionsCreatorEN.CreateRangeRentalDateException;
begin
  Raise RangeRentalDateException.Create('Range of Rental Date is invalid, please checks if start date is before than end date.');
end;

procedure TRentalExceptionsCreatorEN.CreateNotFoundRentalException(id: string);
begin
  Raise NotFoundRentalException.Create('Rental with id ' + id + ' was not found');
end;

end.

