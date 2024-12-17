unit IRenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  RenterUnit,
  SystemResponseUnit,
  RenterDTOUnit;

type
  ITRenterStorage = interface
    function Register(renter: TRenter): TRenter;
    function Update(renter: TRenter): TRenter;
    function Get(id: String): TRenter;
    function Delete(id: string): String;
  end;

implementation

end.
