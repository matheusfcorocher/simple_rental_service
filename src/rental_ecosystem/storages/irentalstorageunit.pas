unit IRentalStorageUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,
  RentalUnit;

type
  ITRentalStorage = interface
    function Register(Rental: TRental): TRental;
    function Update(Rental: TRental): TRental;
    function Get(id: String): TRental;
    function Delete(id: string): String;
  end;

implementation

end.

