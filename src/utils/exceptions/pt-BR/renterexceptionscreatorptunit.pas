unit RenterExceptionsCreatorPTUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRenterExceptionsCreatorUnit, RentalServiceExceptionsUnit;

type
  TRenterExceptionsCreatorPT = class(TInterfacedObject, ITRenterExceptionsCreator)
    public
      procedure CreateRenterNameError;
      procedure CreateRenterAddressError;
      procedure CreateRenterEmailError;
      procedure CreateRenterTelephoneError;
      procedure CreateNotFoundRenterException(id: string);
  end;

implementation

procedure TRenterExceptionsCreatorPT.CreateRenterNameError;
begin
  raise RenterNameException.Create(
    'O nome não é válido. Verifique se o nome não está vazio e tem entre 2 e 50 caracteres.');
end;

procedure TRenterExceptionsCreatorPT.CreateRenterAddressError;
begin
  raise RenterAddressException.Create(
    '"O endereço não é válido. Verifique se o endereço não está vazio.');
end;

procedure TRenterExceptionsCreatorPT.CreateRenterEmailError;
begin
  raise RenterEmailException.Create('O e-mail não é válido. Verifique se o e-mail não está vazio.');
end;

procedure TRenterExceptionsCreatorPT.CreateRenterTelephoneError;
begin
  raise RenterTelephoneException.Create(
    'O telefone não é válido. Verifique se o telefone não está vazio e tem entre 2 e 50 dígitos.');
end;

procedure TRenterExceptionsCreatorPT.CreateNotFoundRenterException(id: string);
begin
  Raise NotFoundRenterException.Create('Locatário com id ' + id + ' não foi encontrado.');
end;

end.

