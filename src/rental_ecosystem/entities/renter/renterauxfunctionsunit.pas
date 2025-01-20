unit RenterAuxFunctionsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit;

function RenterEquals(a, b: TRenter): boolean;

implementation

function RenterEquals(a, b: TRenter): boolean;
begin
  Result := (a.getName = b.getName) and (a.getAddress = b.getAddress) and
    (a.getEmail = b.getEmail) and (a.getTelephone = b.getTelephone);
end;

end.

