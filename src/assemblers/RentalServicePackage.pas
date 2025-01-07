{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RentalServicePackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  AssembleRentalServiceUnit, RentalServiceContainerUnit, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('RentalServicePackage', @Register);
end.
