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
    function Edit(renter: TRenter): TSystemResponse;
    function Check(renterDTO: TRenterDTO): TSystemResponse;
    function Delete(id: string): TSystemResponse;
  end;

implementation

end.
