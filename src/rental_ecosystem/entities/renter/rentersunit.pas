unit RentersUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, RenterUnit;

type
  TRenters = specialize TObjectList<TRenter>;

  TRentersHelper = class helper for TRenters
    function ToObjectList(): specialize TObjectList<TObject>;
  end;

implementation

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

end.
