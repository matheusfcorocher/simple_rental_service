unit FakeRentalStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  DateUtils,
  uuid,
  IRentalStorageUnit,
  RentalUnit,
  VehicleUnit,
  VehicleStatusUnit,
  RentalExceptionsUnit;

type

  { TFakeRentalStorage }

  TFakeRentalStorage = class(TInterfacedObject, ITRentalStorage)
  private
    FRentals: TRentals;
  public
    constructor Create();
    constructor Create(rentals : TRentals); overload;
    function GetNextId() : String;
    function Register(Rental: TRental): TRental;
    function Update(Rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeRentalStorage.Create();
begin
  FRentals := TRentals.Create
end;

constructor TFakeRentalStorage.Create(rentals : TRentals);
begin
  FRentals := rentals;
end;

function TFakeRentalStorage.GetNextId(): String;
var
  GUID: TGUID;
begin
  CreateGuid(GUID);
  Result := GUIDToString(GUID);
end;

function TFakeRentalStorage.Register(Rental: TRental): TRental;
begin
  FRentals.Add(Rental);
  result := Rental;
end;

function TFakeRentalStorage.Update(Rental: TRental): TRental;
var
  AuxRental: TRental;
  RentalIdx : Integer;
begin
  AuxRental := Get(rental.getId());
  RentalIdx := FRentals.IndexOf(AuxRental);
  FRentals.Insert(RentalIdx, rental);

  result := rental;
end;

function TFakeRentalStorage.Get(id: String): TRental;
var
  Rental : TRental;
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

function TFakeRentalStorage.Delete(id: string) : String;
var
  Rental : TRental;
begin
  Rental := Get(id);
  FRentals.Remove(Rental);
  result := 'The rental has been successfully deleted from the system.';
end;

end.


