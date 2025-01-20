unit RegisterRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit, RenterBuilderUnit, RenterDTOUnit;

type
  TRegisterRenter = class
  private
    _RenterStorage: ITRenterStorage;
    _RenterBuilder : TRenterBuilder;
  public
    constructor Create(RenterBuilder : TRenterBuilder; IRenterStorage: ITRenterStorage);
    function Execute(RenterInfoDTO : TRenterInfoDTO) : TRenter;
  end;
implementation

constructor TRegisterRenter.Create(RenterBuilder : TRenterBuilder; IRenterStorage: ITRenterStorage);
begin
  _RenterBuilder := RenterBuilder;
  _RenterStorage := IRenterStorage;
end;

function TRegisterRenter.Execute(RenterInfoDTO : TRenterInfoDTO) : TRenter;
var
  RenterId : String;
  Renter : TRenter;
begin
  RenterId := _RenterStorage.GetNextId();
  Renter := _RenterBuilder.Build(RenterId, RenterInfoDTO.name, RenterInfoDTO.Address, RenterInfoDTO.Email, RenterInfoDTO.Telephone);
  Renter.IsRenterValid();
  Result := _RenterStorage.Register(Renter);
end;

end.
