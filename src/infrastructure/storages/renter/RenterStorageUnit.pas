unit RenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit,
  RenterDTOUnit,
  RenterExceptionsUnit;

type

  { TRenterStorage }

  TRenterStorage = class(TInterfacedObject, ITRenterStorage)
  private
    FRenters : TRenters;
  public
    constructor Create;
    constructor Create(renters : TRenters); overload;
    function GetNextId() : String;
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

constructor TRenterStorage.Create();
begin
  FRenters := TRenters.Create;
end;

constructor TRenterStorage.Create(renters: TRenters);
begin
  FRenters := renters;
end;

function TRenterStorage.GetNextId(): String;
var
  GUID: TGUID;
begin
  CreateGuid(GUID);
  Result := GUIDToString(GUID);
end;

function TRenterStorage.Register(renter: TRenter): TRenter;
begin
  FRenters.Add(renter);
  result := renter;
end;

function TRenterStorage.Update(renter: TRenter): TRenter;
var
  AuxRenter: TRenter;
  RenterIdx : Integer;
begin
  AuxRenter := Get(renter.getId());
  RenterIdx := FRenters.IndexOf(AuxRenter);
  FRenters[RenterIdx] := renter;

  result := renter;
end;

function TRenterStorage.Get(id: String): TRenter;
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

function TRenterStorage.Delete(id: string) : String;
var
  Renter : TRenter;
begin
  Renter := Get(id);
  FRenters.Remove(Renter);
  result := 'The renter has been successfully deleted from the system.';
end;

end.
