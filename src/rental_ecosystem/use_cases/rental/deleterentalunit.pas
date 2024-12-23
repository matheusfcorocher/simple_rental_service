unit DeleteRentalUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RentalUnit, IRentalStorageUnit;

type
  TDeleteRental = class
  private
    FRentalStorage: ITRentalStorage;
  public
    constructor Create(IRentalStorage: ITRentalStorage);
    function Execute(id : String): String;
  end;

implementation

constructor TDeleteRental.Create(IRentalStorage: ITRentalStorage);
begin
  FRentalStorage := IRentalStorage;
end;

function TDeleteRental.Execute(id : String): String;
begin
  Result := FRentalStorage.Delete(id);
end;

end.

