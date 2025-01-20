unit RenterExceptionsCreatorENUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRenterExceptionsCreatorUnit, RentalServiceExceptionsUnit;

type
  TRenterExceptionsCreatorEN = class(TInterfacedObject, ITRenterExceptionsCreator)
    public
      procedure CreateRenterNameError;
      procedure CreateRenterAddressError;
      procedure CreateRenterEmailError;
      procedure CreateRenterTelephoneError;
      procedure CreateNotFoundRenterException(id: string);
  end;

implementation

procedure TRenterExceptionsCreatorEN.CreateRenterNameError;
begin
  raise RenterNameException.Create(
    'Name isnt valid. Checks if name isnt empty and have digits between 2 and 50.');
end;

procedure TRenterExceptionsCreatorEN.CreateRenterAddressError;
begin
  raise RenterAddressException.Create(
    'Address isnt valid. Checks if address isnt empty.');
end;

procedure TRenterExceptionsCreatorEN.CreateRenterEmailError;
begin
  raise RenterEmailException.Create('Email isnt valid. Checks if email isnt empty.');
end;

procedure TRenterExceptionsCreatorEN.CreateRenterTelephoneError;
begin
  raise RenterTelephoneException.Create(
    'Telephone isnt valid. Checks if telephone isnt empty and have digits between 2 and 50.');
end;

procedure TRenterExceptionsCreatorEN.CreateNotFoundRenterException(id: string);
begin
  Raise NotFoundRenterException.Create('Renter with id ' + id + ' was not found');
end;

end.
