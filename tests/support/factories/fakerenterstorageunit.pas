unit FakeRenterStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit,
  IRenterExceptionsCreatorUnit,
  RentersUnit;

type

  { TFakeRenterStorage }

  TFakeRenterStorage = class(TInterfacedObject, ITRenterStorage)
  private
    _Renters: TRenters;
    _RenterExceptionsCreator : ITRenterExceptionsCreator;
  public
    constructor Create(RenterExceptionsCreator : ITRenterExceptionsCreator);
    function GetNextId() : String;
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeRenterStorage.Create(RenterExceptionsCreator : ITRenterExceptionsCreator);
begin
  _Renters := TRenters.Create;
  _RenterExceptionsCreator := RenterExceptionsCreator;
end;

function TFakeRenterStorage.GetNextId(): String;
var
  GUID: TGUID;
begin
  CreateGuid(GUID);
  Result := GUIDToString(GUID);
end;

function TFakeRenterStorage.Register(renter: TRenter): TRenter;
begin
  _Renters.Add(renter);
  result := renter;
end;

function TFakeRenterStorage.Update(renter: TRenter): TRenter;
var
  AuxRenter: TRenter;
  RenterIdx : Integer;
begin
  AuxRenter := Get(renter.getId());
  RenterIdx := _Renters.IndexOf(AuxRenter);
  _Renters[RenterIdx] := renter;

  result := renter;
end;

function TFakeRenterStorage.Get(id: String): TRenter;
var
  Renter : TRenter;
begin
  for Renter in _Renters do
  begin
    if Renter.getId() = id then
    begin
      result := Renter;
      Exit;
    end;
  end;

  _RenterExceptionsCreator.CreateNotFoundRenterException(id);
end;

function TFakeRenterStorage.Delete(id: string) : String;
var
  Renter : TRenter;
begin
  Renter := Get(id);
  _Renters.Remove(Renter);
  result := 'The renter has been successfully deleted from the system.';
end;

end.

