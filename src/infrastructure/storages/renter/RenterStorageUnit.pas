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
    function Edit(renter: TRenter): TSystemResponse;
    function Check(renterDTO: TRenterDTO): TSystemResponse;
    function Delete(id: string): TSystemResponse;
  end;

implementation

function TRenterStorage.Register(renter: TRenter): TRenter;
begin
  result := renter;
end;

function TRenterStorage.Edit(renter: TRenter): TSystemResponse;
begin

end;

function TRenterStorage.Check(renterDTO: TRenterDTO): TSystemResponse;
begin

end;

function TRenterStorage.Delete(id: string): TSystemResponse;
begin

end;

end.
