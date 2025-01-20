unit UpdateRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit, RenterDTOUnit, RenterBuilderUnit;

type
  TUpdateRenter = class
  private
    _RenterStorage: ITRenterStorage;
    _RenterBuilder : TRenterBuilder;
  public
    constructor Create(IRenterStorage: ITRenterStorage; RenterBuilder : TRenterBuilder);
    function Execute(RenterDTO: TRenterDTO): TRenter;
  end;

implementation

constructor TUpdateRenter.Create(IRenterStorage: ITRenterStorage; RenterBuilder : TRenterBuilder);
begin
  _RenterStorage := IRenterStorage;
  _RenterBuilder := RenterBuilder;
end;

function TUpdateRenter.Execute(RenterDTO: TRenterDTO): TRenter;
var
  Renter: TRenter;
begin
  Renter := _RenterBuilder.Build(RenterDTO.id, RenterDTO.Name, RenterDTO.Address,
    RenterDTO.email, RenterDTO.telephone);
  Renter.IsRenterValid();
  Result := _RenterStorage.Update(Renter);
end;

end.
