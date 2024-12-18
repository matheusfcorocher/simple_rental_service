unit RegisterRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit, SystemResponseUnit;

type
  TRegisterRenter = class
  private
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(renter : TRenter): TRenter;
  end;

implementation

constructor TRegisterRenter.Create(IRenterStorage: ITRenterStorage);
begin
  FRenterStorage := IRenterStorage;
end;

function TRegisterRenter.Execute(renter : TRenter) : TRenter;
begin
  Result := FRenterStorage.Register(renter);
end;

end.
