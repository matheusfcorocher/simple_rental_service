unit VehiclesUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, VehicleUnit;

type
  TVehicles = specialize TObjectList<TVehicle>;

  TVehiclesHelper = class helper for TVehicles
    function ToObjectList(): specialize TObjectList<TObject>;
  end;

implementation

function TVehiclesHelper.ToObjectList(): specialize TObjectList<TObject>;
var
  Vehicle: TVehicle;
  ObjectList: specialize TObjectList<TObject>;
begin
  ObjectList := specialize TObjectList<TObject>.Create();
  for Vehicle in Self do
    ObjectList.Add(Vehicle);

  Result := ObjectList;
end;

end.
