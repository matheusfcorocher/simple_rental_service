unit RenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit,
  RenterDTOUnit;

type
  TRenterStorage = class(TInterfacedObject, ITRenterStorage)
  public
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

function TRenterStorage.Register(renter: TRenter): TRenter;
begin
  result := renter;
end;

function TRenterStorage.Update(renter: TRenter): TRenter;
begin
  result := renter;
end;

function TRenterStorage.Get(id: String): TRenter;
begin
  result := TRenter.Create(id, 'test', 'test', '12345678', '123456789');
end;

function TRenterStorage.Delete(id: string) : String;
begin
  result := 'The renter has been successfully deleted from the system.';
end;

end.
