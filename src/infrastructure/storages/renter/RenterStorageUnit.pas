unit RenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  Classes,
  IRenterStorageUnit,
  RenterUnit,
  RenterDTOUnit,
  SystemResponseUnit,
  StandardResponsesUnit;

type
  TRenterStorage = class(TInterfacedObject, ITRenterStorage)
  public
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(renter_id: String): TRenterDTO;
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

function TRenterStorage.Get(renter_id: String): TRenterDTO;
begin
  result := CreateRenterDTO(renter_id, 'Ash', 'address','email','1212312432');
end;

function TRenterStorage.Delete(id: string) : String;
begin
  result := 'The renter has been successfully deleted from the system.';
end;

end.
