unit RenterUnit;

{$mode objfpc}{$H+}

interface

uses
    SysUtils, Generics.Collections, SystemResponseUnit, RenterDTOUnit, RenterExceptionsUnit;

type
  TRenter = class

  private
    Fid: string;
    Fname: string;
    Faddress: string;
    Femail: string;
    Ftelephone: string;


    function IsNameValid(name: string) : Boolean;
    function IsAddressValid(address: string) : Boolean;
    function IsEmailValid(email: string) : Boolean;
    function IsTelephoneValid(telephone: string) : Boolean;

    function IsFieldEmpty(field: string) : Boolean;
    function HasNameValidDigits(name: string) : Boolean;
    function HasTelephoneValidDigits(telephone: string) : Boolean;


  public
    constructor Create(id: string; name: string; address: string;
      email: string; telephone: string);

    constructor Create(RenterDTO: TRenterDTO); overload;

    //getter and setter methods
    function getId: string;

    function getName: string;
    procedure setName(name: string);

    function getAddress: string;
    procedure setAddress(address: string);

    function getEmail: string;
    procedure setEmail(email: string);

    function getTelephone: string;
    procedure setTelephone(telephone: string);
  end;

  TRenters = specialize TObjectList<TRenter>;

  TRentersHelper = class helper for TRenters
    function ToObjectList(): specialize TObjectList<TObject>;
  end;

  function RenterEquals(a, b : TRenter): boolean;

implementation

constructor TRenter.Create(id: string; name: string; address: string;
  email: string; telephone: string);
begin
  IsNameValid(name);
  IsAddressValid(address);
  IsEmailValid(email);
  IsTelephoneValid(telephone);

  Fid := id;
  Fname := name;
  Faddress := address;
  Femail := email;
  Ftelephone := telephone;
end;

constructor TRenter.Create(RenterDTO: TRenterDTO);
begin
  IsNameValid(RenterDTO.name);
  IsAddressValid(RenterDTO.address);
  IsEmailValid(RenterDTO.email);
  IsTelephoneValid(RenterDTO.telephone);

  Fid := RenterDTO.id;
  Fname := RenterDTO.name;
  Faddress := RenterDTO.address;
  Femail := RenterDTO.email;
  Ftelephone := RenterDTO.telephone;
end;


// getter and setter methods
function TRenter.getId(): string;
begin
  Result := Fid;
end;

function TRenter.getName(): string;
begin
  Result := Fname;
end;

procedure TRenter.setName(name: string);
begin
  IsNameValid(name);
  Fname := Name;
end;

function TRenter.getAddress(): string;
begin
  Result := Faddress;
end;

procedure TRenter.setAddress(address: string);
begin
  IsAddressValid(address);
  Faddress := address;
end;

function TRenter.getEmail(): string;
begin
  Result := Femail;
end;

procedure TRenter.setEmail(email: string);
begin
  IsEmailValid(email);
  Femail := email;
end;

function TRenter.getTelephone() : string;
begin
  Result := Ftelephone;
end;

procedure TRenter.setTelephone(telephone: string);
begin
  IsTelephoneValid(telephone);
  Ftelephone := telephone;
end;

// main methods for validating Renter fields

function TRenter.IsNameValid(name: string) : Boolean;
var
  isValid : Boolean;
begin
  isValid := HasNameValidDigits(name);

  if not isValid then
  begin
    CreateRenterNameError;
  end;

  result := isValid;
end;

function TRenter.IsAddressValid(address: string) : Boolean;
var
  IsValid : Boolean;
begin
  IsValid := not IsFieldEmpty(address);

  if not IsValid then
  begin
    CreateRenterAddressError;
  end;

  result := IsValid;
end;

function TRenter.IsEmailValid(email: string) : Boolean;
var
  IsValid : Boolean;
begin
  IsValid := not IsFieldEmpty(email);

  if not IsValid then
  begin
    CreateRenterEmailError;
  end;

  result := IsValid;
end;

function TRenter.IsTelephoneValid(telephone: string) : Boolean;
var
  IsValid : Boolean;
begin
  IsValid := HasTelephoneValidDigits(telephone);

  if not IsValid then
  begin
    CreateRenterTelephoneError;
  end;

  result := IsValid;
end;

// auxiliary private methods for validating Renter fields

function TRenter.IsFieldEmpty(field: string) : Boolean;
begin
   result := (Length(Trim(field))) = 0
end;

function TRenter.HasNameValidDigits(name: string) : Boolean;
const
  minimumDigits = 2;
  maximumDigits = 50;
begin
  result := (Length(name) >= minimumDigits) and (Length(name) <= maximumDigits);
end;

function TRenter.HasTelephoneValidDigits(telephone: string) : Boolean;
const
  minimumDigits = 8;
  maximumDigits = 15;
begin
  result := (Length(telephone) >= minimumDigits) and (Length(telephone) <= maximumDigits);
end;

function TRentersHelper.ToObjectList(): specialize TObjectList<TObject>;
var
  Renter: TRenter;
  ObjectList: specialize TObjectList<TObject>;
begin
  ObjectList := specialize TObjectList<TObject>.Create();
  for Renter in Self do
    ObjectList.Add(Renter);

  Result := ObjectList;
end;

function RenterEquals(a, b : TRenter): boolean;
  begin
       Result := (a.getName = b.getName) and
       (a.getAddress = b.getAddress) and
       (a.getEmail = b.getEmail) and (a.getTelephone =
       b.getTelephone);
end;

end.
