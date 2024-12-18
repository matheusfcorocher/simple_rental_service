{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RentalEcosystemPackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  RenterDTOUnit, RenterUnit, IRenterStorageUnit, RegisterRenterUnit, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('RentalEcosystemPackage', @Register);
end.
