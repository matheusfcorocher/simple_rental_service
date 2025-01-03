unit RentalStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  DateUtils,
  uuid,
  IRentalStorageUnit,
  RentalUnit,
  RentalExceptionsUnit;

type

  { TRentalStorage }

  TRentalStorage = class(TInterfacedObject, ITRentalStorage)
  private
    FRentals: TRentals;
  public
    constructor Create();
    constructor Create(rentals : TRentals); overload;
    function GetNextId() : String;
    function Register(rental: TRental): TRental;
    function Update(rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;
  end;

implementation

constructor TRentalStorage.Create();
begin
  FRentals := TRentals.Create
end;

constructor TRentalStorage.Create(rentals: TRentals);
begin
  FRentals := rentals;
end;

function TRentalStorage.GetNextId() : String;
var
  GUID: TGUID;
begin
  CreateGuid(GUID);
  Result := GUIDToString(GUID);
end;

function TRentalStorage.Register(rental: TRental): TRental;
begin
  FRentals.Add(Rental);
  result := Rental;
end;

function TRentalStorage.Update(rental: TRental): TRental;
var
  AuxRental: TRental;
  RentalIdx : Integer;
begin
  AuxRental := Get(rental.getId());
  RentalIdx := FRentals.IndexOf(AuxRental);
  FRentals[RentalIdx] := rental;

  result := rental;
end;

function TRentalStorage.Get(id: String): TRental;
var
  Rental : TRental;
  CompareResult: Integer;
begin
  for Rental in FRentals do
  begin
    if Rental.getId() = id then
    begin
      result := Rental;
      Exit;
    end;
  end;

  CreateNotFoundRentalException(id);
end;

function TRentalStorage.Delete(id: string) : String;
var
  Rental : TRental;
begin
  Rental := Get(id);
  FRentals.Remove(Rental);
  result := 'The rental has been successfully deleted from the system.';
end;

end.
