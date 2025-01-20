unit GetRenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterStorageUnit;

type
  TGetRenter = class
  private
    _RenterStorage: ITRenterStorage;
  public
    constructor Create(IRenterStorage: ITRenterStorage);
    function Execute(id : String): TRenter;
  end;

implementation

constructor TGetRenter.Create(IRenterStorage: ITRenterStorage);
begin
  _RenterStorage := IRenterStorage;
end;

function TGetRenter.Execute(id : String): TRenter;
begin
  Result := _RenterStorage.Get(id);
end;

end.
