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
    function Register(renter: TRenter): TSystemResponse;
    function edit(renter: TRenter): TSystemResponse;
    function check(renterDTO: TRenterDTO): TSystemResponse;
    function Delete(id: string): TSystemResponse;
  end;

implementation

end.
