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
  IRentalExceptionsCreatorUnit,
  RentalsUnit;

type

  { TFakeRentalStorage }

  TFakeRentalStorage = class(TInterfacedObject, ITRentalStorage)
  private
    _Rentals: TRentals;
    _RentalExceptionsCreator : ITRentalExceptionsCreator;
  public
    constructor Create(RentalExceptionsCreator : ITRentalExceptionsCreator);
    constructor Create(rentals : TRentals); overload;
    function GetNextId() : String;
    function Register(Rental: TRental): TRental;
    function Update(Rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeRentalStorage.Create(RentalExceptionsCreator : ITRentalExceptionsCreator);
begin
  _Rentals := TRentals.Create;
  _RentalExceptionsCreator := RentalExceptionsCreator;
end;

constructor TFakeRentalStorage.Create(rentals : TRentals);
begin
  _Rentals := rentals;
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
  _Rentals.Add(Rental);
  result := Rental;
end;

function TFakeRentalStorage.Update(Rental: TRental): TRental;
var
  AuxRental: TRental;
  RentalIdx : Integer;
begin
  AuxRental := Get(rental.getId());
  RentalIdx := _Rentals.IndexOf(AuxRental);
  _Rentals.Insert(RentalIdx, rental);

  result := rental;
end;

function TFakeRentalStorage.Get(id: String): TRental;
var
  Rental : TRental;
begin
  for Rental in _Rentals do
  begin
    if Rental.getId() = id then
    begin
      result := Rental;
      Exit;
    end;
  end;

  _RentalExceptionsCreator.CreateNotFoundRentalException(id);
end;

function TFakeRentalStorage.Delete(id: string) : String;
var
  Rental : TRental;
begin
  Rental := Get(id);
  _Rentals.Remove(Rental);
  result := 'The rental has been successfully deleted from the system.';
end;

end.


