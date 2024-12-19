unit DeleteRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit;

type
  TDeleteRenter = class
  private
    FRenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(id : String): String;
  end;

implementation

constructor TDeleteRenter.Create(IRenterStorage: ITRenterStorage);
begin
  FRenterStorage := IRenterStorage;
end;

function TDeleteRenter.Execute(id : String): String;
begin
  Result := FRenterStorage.Delete(id);
end;

end.
