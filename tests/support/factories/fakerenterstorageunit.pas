unit FakeRenterStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit;

type
  TFakeRenterStorage = class(TInterfacedObject, ITRenterStorage)
  private
    Renters: TRenters;
  public
    constructor Create();
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

constructor TFakeRenterStorage.Create();
begin
  Renters := TRenters.Create
end;

function TFakeRenterStorage.Register(renter: TRenter): TRenter;
begin
  Renters.Add(renter);
  result := renter;
end;

function TFakeRenterStorage.Update(renter: TRenter): TRenter;
begin
  result := renter;
end;

function TFakeRenterStorage.Get(id: String): TRenter;
begin
  result := TRenter.Create(id, 'test', 'test', '12345678', '123456789');
end;

function TFakeRenterStorage.Delete(id: string) : String;
begin
  result := 'The renter has been successfully deleted from the system.';
end;

end.

