unit FakeRenterStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit,
  RenterExceptionsUnit;

type

  { TFakeRenterStorage }

  TFakeRenterStorage = class(TInterfacedObject, ITRenterStorage)
  private
    FRenters: TRenters;
  public
    constructor Create();
    function GetNextId() : String;
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeRenterStorage.Create();
begin
  FRenters := TRenters.Create
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
  FRenters.Add(renter);
  result := renter;
end;

function TFakeRenterStorage.Update(renter: TRenter): TRenter;
var
  AuxRenter: TRenter;
  RenterIdx : Integer;
begin
  AuxRenter := Get(renter.getId());
  RenterIdx := FRenters.IndexOf(AuxRenter);
  FRenters[RenterIdx] := renter;

  result := renter;
end;

function TFakeRenterStorage.Get(id: String): TRenter;
var
  Renter : TRenter;
begin
  for Renter in FRenters do
  begin
    if Renter.getId() = id then
    begin
      result := Renter;
      Exit;
    end;
  end;

  CreateNotFoundRenterException(id);
end;

function TFakeRenterStorage.Delete(id: string) : String;
var
  Renter : TRenter;
begin
  Renter := Get(id);
  FRenters.Remove(Renter);
  result := 'The renter has been successfully deleted from the system.';
end;

end.

