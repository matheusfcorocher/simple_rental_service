program RentalServiceTestRunner;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, TestRenterStorageUnit, TestRenterDTOUnit, TestRenterUnit,
  GuiTestRunner, TestStandardResponseUnit, TestSystemResponseUnit,
  TestRegisterRenterUnit, TestUpdateRenterUnit, UpdateRenterUnit,
  TestGetRenterUnit, GetRenterUnit, TestDeleteRenterUnit, DeleteRenterUnit,
  FakeRenterStorageUnit, TestVehicleUnit, VehicleUnit, VehicleDTOUnit,
  VehicleStatusUnit, TestVehicleDTOUnit, VehicleExceptionsUnit,
  TestRegisterVehicleUnit, RegisterVehicleUnit, IVehicleStorageUnit,
  FakeVehicleStorageUnit, TestUpdateVehicleUnit, UpdateVehicleUnit,
  TestGetVehicleUnit, GetVehicleUnit, TestDeleteVehicleUnit, DeleteVehicleUnit,
  TestVehicleStorageUnit, VehicleStorageUnit, TestRentalUnit, RentalUnit, 
RentalExceptionsUnit, TestVehicleStatusUnit, IRentalStorageUnit, 
TestRegisterRentalUnit, TestUpdateRentalUnit, TestGetRentalUnit, 
TestDeleteRentalUnit, FakeRentalStorageUnit, RegisterRentalUnit, 
UpdateRentalUnit, GetRentalUnit, DeleteRentalUnit, TestRentalStorageUnit, 
RentalStorageUnit;

  {$R *.res}

begin
  //TestRenterUnit.RegisterTest;
  //TestRenterStorageUnit.RegisterTest;

  //RunRegisteredTests;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
