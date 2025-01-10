unit RenterExceptionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  RenterNameException = class(Exception);
  RenterAddressException = class(Exception);
  RenterEmailException = class(Exception);
  RenterTelephoneException = class(Exception);
  NotFoundRenterException = class(Exception);

procedure CreateRenterNameError;
procedure CreateRenterAddressError;
procedure CreateRenterEmailError;
procedure CreateRenterTelephoneError;
procedure CreateNotFoundRenterException(id: string);

implementation

procedure CreateRenterNameError;
begin
  raise RenterNameException.Create(
    'Name isnt valid. Checks if name isnt empty and have digits between 2 and 50.');
end;

procedure CreateRenterAddressError;
begin
  raise RenterAddressException.Create(
    'Address isnt valid. Checks if address isnt empty.');
end;

procedure CreateRenterEmailError;
begin
  raise RenterEmailException.Create('Email isnt valid. Checks if email isnt empty.');
end;

procedure CreateRenterTelephoneError;
begin
  raise RenterTelephoneException.Create(
    'Telephone isnt valid. Checks if telephone isnt empty and have digits between 2 and 50.');
end;

procedure CreateNotFoundRenterException(id: string);
begin
  Raise NotFoundRenterException.Create('Renter with id ' + id + ' was not found');
end;

end.
