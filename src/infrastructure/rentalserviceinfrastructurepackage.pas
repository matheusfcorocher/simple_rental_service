{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RentalServiceInfrastructurePackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  RenterStorageUnit, RentalStorageUnit, VehicleStorageUnit, 
  RenterStorageBuilderUnit, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('RentalServiceInfrastructurePackage', @Register);
end.
