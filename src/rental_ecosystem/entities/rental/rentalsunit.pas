unit RentalsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, RentalUnit;

type

  TRentals = specialize TObjectList<TRental>;

  TRentalsHelper = class helper for TRentals
    function ToObjectList(): specialize TObjectList<TObject>;

  end;

implementation

function TRentalsHelper.ToObjectList(): specialize TObjectList<TObject>;
var
  Rental: TRental;
  ObjectList: specialize TObjectList<TObject>;
begin
  ObjectList := specialize TObjectList<TObject>.Create();
  for Rental in Self do
    ObjectList.Add(Rental);

  Result := ObjectList;
end;

end.
