unit IRenterExceptionsCreatorUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  ITRenterExceptionsCreator = interface
      procedure CreateRenterNameError;
      procedure CreateRenterAddressError;
      procedure CreateRenterEmailError;
      procedure CreateRenterTelephoneError;
      procedure CreateNotFoundRenterException(id: string);
  end;

implementation

end.

