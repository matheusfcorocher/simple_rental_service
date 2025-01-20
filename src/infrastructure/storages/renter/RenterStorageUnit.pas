unit RenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit,
  RenterDTOUnit,
  IRenterExceptionsCreatorUnit,
  RentersUnit;

type

  { TRenterStorage }

  TRenterStorage = class(TInterfacedObject, ITRenterStorage)
  private
    _Renters : TRenters;
    _RenterExceptionCreator : ITRenterExceptionsCreator;
  public
    constructor Create(RenterExceptionsCreator: ITRenterExceptionsCreator);
    constructor Create(renters : TRenters; RenterExceptionsCreator: ITRenterExceptionsCreator); overload;
    function GetNextId() : String;
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

constructor TRenterStorage.Create(RenterExceptionsCreator: ITRenterExceptionsCreator);
begin
  _Renters := TRenters.Create;
  _RenterExceptionCreator := RenterExceptionsCreator;
end;

constructor TRenterStorage.Create(renters: TRenters; RenterExceptionsCreator: ITRenterExceptionsCreator);
begin
  _Renters := renters;
  _RenterExceptionCreator := RenterExceptionsCreator;
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
  _Renters.Add(renter);
  result := renter;
end;

function TRenterStorage.Update(renter: TRenter): TRenter;
var
  AuxRenter: TRenter;
  RenterIdx : Integer;
begin
  AuxRenter := Get(renter.getId());
  RenterIdx := _Renters.IndexOf(AuxRenter);
  _Renters.Insert(RenterIdx, renter);

  result := renter;
end;

function TRenterStorage.Get(id: String): TRenter;
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

  _RenterExceptionCreator.CreateNotFoundRenterException(id);
end;

function TRenterStorage.Delete(id: string) : String;
var
  Renter : TRenter;
begin
  Renter := Get(id);
  _Renters.Remove(Renter);
  result := 'The renter has been successfully deleted from the system.';
end;

end.
