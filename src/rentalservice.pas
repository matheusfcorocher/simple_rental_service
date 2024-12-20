{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RentalService;

{$warn 5023 off : no warning about unused units}
interface

uses
  RenterStorageUnit, RenterDTOUnit, RenterUnit, IRenterStorageUnit, 
  StandardResponsesUnit, SystemResponseUnit, DeleteRenterUnit, GetRenterUnit, 
  RegisterRenterUnit, UpdateRenterUnit, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('RentalService', @Register);
end.
