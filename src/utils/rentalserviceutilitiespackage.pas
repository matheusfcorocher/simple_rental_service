{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RentalServiceUtilitiesPackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  SystemResponseUnit, StandardResponsesUnit, ExceptionsErrorCodeUnit, 
  IExceptionsCreatorUnit, IRentalExceptionsCreatorUnit, 
  IRenterExceptionsCreatorUnit, IVehicleExceptionsCreatorUnit, 
  ExceptionCreatorUnit, RentalExceptionsCreatorENUnit, 
  RenterExceptionsCreatorENUnit, VehicleExceptionsCreatorENUnit, 
  RentalServiceExceptionsUnit, RentalExceptionsCreatorPTUnit, 
  RenterExceptionsCreatorPTUnit, VehicleExceptionsCreatorPTUnit, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('RentalServiceUtilitiesPackage', @Register);
end.
