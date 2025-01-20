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
  RentalsUnit,
  IRentalExceptionsCreatorUnit;

type

  { TRentalStorage }

  TRentalStorage = class(TInterfacedObject, ITRentalStorage)
  private
    _Rentals: TRentals;
    _RentalExceptionsCreator : ITRentalExceptionsCreator;
  public
    constructor Create(RentalExceptionsCreator : ITRentalExceptionsCreator);
    constructor Create(rentals : TRentals ; RentalExceptionsCreator : ITRentalExceptionsCreator); overload;
    function GetNextId() : String;
    function Register(rental: TRental): TRental;
    function Update(rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;

  end;

implementation

constructor TRentalStorage.Create(RentalExceptionsCreator : ITRentalExceptionsCreator);
begin
  _Rentals := TRentals.Create;
  _RentalExceptionsCreator := RentalExceptionsCreator;
end;

constructor TRentalStorage.Create(rentals: TRentals; RentalExceptionsCreator : ITRentalExceptionsCreator);
begin
  _Rentals := rentals;
  _RentalExceptionsCreator := RentalExceptionsCreator;
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
  _Rentals.Add(Rental);
  result := Rental;
end;

function TRentalStorage.Update(rental: TRental): TRental;
var
  AuxRental: TRental;
  RentalIdx : Integer;
begin
  AuxRental := Get(rental.getId());
  RentalIdx := _Rentals.IndexOf(AuxRental);
  _Rentals.Insert(RentalIdx, rental);

  result := rental;
end;

function TRentalStorage.Get(id: String): TRental;
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

function TRentalStorage.Delete(id: string) : String;
var
  Rental : TRental;
begin
  Rental := Get(id);
  _Rentals.Remove(Rental);
  result := 'The rental has been successfully deleted from the system.';
end;

end.
