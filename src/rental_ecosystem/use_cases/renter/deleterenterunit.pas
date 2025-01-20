unit DeleteRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRenterStorageUnit;

type
  TDeleteRenter = class
  private
    _RenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(id : String): String;
  end;

implementation

constructor TDeleteRenter.Create(IRenterStorage: ITRenterStorage);
begin
  _RenterStorage := IRenterStorage;
end;

function TDeleteRenter.Execute(id : String): String;
begin
  Result := _RenterStorage.Delete(id);
end;

end.
