unit RegisterRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit;

type

  TRenterData = record
    name: String;
    address: String;
    email: String;
    telephone: String;
  end;

  TRegisterRenter = class
  private
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(RenterData : TRenterData) : TRenter;
  end;
implementation

constructor TRegisterRenter.Create(IRenterStorage: ITRenterStorage);
begin
  FRenterStorage := IRenterStorage;
end;

function TRegisterRenter.Execute(RenterData : TRenterData) : TRenter;
var
  RenterId : String;
  Renter : TRenter;
begin
  RenterId := FRenterStorage.GetNextId();
  Renter := TRenter.Create(RenterId, RenterData.name, RenterData.Address, RenterData.Email, RenterData.Telephone);
  Result := FRenterStorage.Register(Renter);
end;

end.
