unit RenterUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, RenterDTOUnit, IRenterExceptionsCreatorUnit;

type
  TRenter = class

  private
    _id: string;
    _name: string;
    _address: string;
    _email: string;
    _telephone: string;

    _RenterExceptionsCreator: ITRenterExceptionsCreator;

    // renter validation methods

    function _IsNameValid(): boolean;
    function _IsAddressValid(): boolean;
    function _IsEmailValid(): boolean;
    function _IsTelephoneValid(): boolean;

    function _IsFieldEmpty(field: string): boolean;
    function _HasNameValidDigits(): boolean;
    function _HasTelephoneValidDigits(): boolean;

  public
    constructor Create(id: string; name: string; address: string;
      email: string; telephone: string; RenterExceptionsCreator: ITRenterExceptionsCreator);

    constructor Create(RenterDTO: TRenterDTO; RenterExceptionsCreator: ITRenterExceptionsCreator); overload;

    function IsRenterValid() : Boolean;

    //getter and setter methods

    function getId: string;

    function getName: string;
    procedure setName(Name: string);

    function getAddress: string;
    procedure setAddress(address: string);

    function getEmail: string;
    procedure setEmail(email: string);

    function getTelephone: string;
    procedure setTelephone(telephone: string);
  end;

implementation

// private methods

function TRenter._IsNameValid(): boolean;
var
  isValid: boolean;
begin
  isValid := _HasNameValidDigits();

  if not isValid then
  begin
    _RenterExceptionsCreator.CreateRenterNameError;
  end;

  Result := isValid;
end;

function TRenter._IsAddressValid(): boolean;
var
  IsValid: boolean;
begin
  IsValid := not _IsFieldEmpty(_address);

  if not IsValid then
  begin
    _RenterExceptionsCreator.CreateRenterAddressError;
  end;

  Result := IsValid;
end;

function TRenter._IsEmailValid(): boolean;
var
  IsValid: boolean;
begin
  IsValid := not _IsFieldEmpty(_email);

  if not IsValid then
  begin
    _RenterExceptionsCreator.CreateRenterEmailError;
  end;

  Result := IsValid;
end;

function TRenter._IsTelephoneValid(): boolean;
var
  IsValid: boolean;
begin
  IsValid := _HasTelephoneValidDigits();

  if not IsValid then
  begin
    _RenterExceptionsCreator.CreateRenterTelephoneError;
  end;

  Result := IsValid;
end;

// auxiliary private methods for validating Renter fields

function TRenter._IsFieldEmpty(field: string): boolean;
begin
  Result := (Length(Trim(field))) = 0;
end;

function TRenter._HasNameValidDigits(): boolean;
const
  minimumDigits = 2;
  maximumDigits = 50;
begin
  Result := (Length(_name) >= minimumDigits) and (Length(_name) <= maximumDigits);
end;

function TRenter._HasTelephoneValidDigits(): boolean;
const
  minimumDigits = 8;
  maximumDigits = 15;
begin
  Result := (Length(_telephone) >= minimumDigits) and
    (Length(_telephone) <= maximumDigits);
end;

// public methods

constructor TRenter.Create(id: string; name: string; address: string;
  email: string; telephone: string; RenterExceptionsCreator: ITRenterExceptionsCreator);
begin
  _id := id;
  _name := name;
  _address := address;
  _email := email;
  _telephone := telephone;

  _RenterExceptionsCreator := RenterExceptionsCreator;
end;

constructor TRenter.Create(RenterDTO: TRenterDTO; RenterExceptionsCreator: ITRenterExceptionsCreator);
begin
  _id := RenterDTO.id;
  _name := RenterDTO.Name;
  _address := RenterDTO.address;
  _email := RenterDTO.email;
  _telephone := RenterDTO.telephone;

  _RenterExceptionsCreator := RenterExceptionsCreator;
end;

function TRenter.IsRenterValid() : Boolean;
begin
  result := _IsNameValid() and _IsAddressValid() and _IsEmailValid() and _IsTelephoneValid();
end;

// getter and setters

function TRenter.getId(): string;
begin
  Result := _id;
end;

function TRenter.getName(): string;
begin
  Result := _name;
end;

procedure TRenter.setName(name: string);
begin
  _name := name;
end;

function TRenter.getAddress(): string;
begin
  Result := _address;
end;

procedure TRenter.setAddress(address: string);
begin
  _address := address;
end;

function TRenter.getEmail(): string;
begin
  Result := _email;
end;

procedure TRenter.setEmail(email: string);
begin
  _email := email;
end;

function TRenter.getTelephone(): string;
begin
  Result := _telephone;
end;

procedure TRenter.setTelephone(telephone: string);
begin
  _telephone := telephone;
end;

end.
