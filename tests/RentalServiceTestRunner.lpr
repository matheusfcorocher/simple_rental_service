program RentalServiceTestRunner;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, TestRenterStorageUnit, TestRenterDTOUnit, TestRenterUnit,
  GuiTestRunner, TestStandardResponseUnit, TestSystemResponseUnit,
  TestRegisterRenterUnit, TestUpdateRenterUnit,
  TestGetRenterUnit, TestDeleteRenterUnit,
  FakeRenterStorageUnit, TestVehicleUnit,
  TestVehicleDTOUnit,
  TestRegisterVehicleUnit,
  FakeVehicleStorageUnit, TestUpdateVehicleUnit,
  TestGetVehicleUnit, TestDeleteVehicleUnit,
  TestVehicleStorageUnit, TestRentalUnit, 
TestVehicleStatusUnit, 
TestRegisterRentalUnit, TestUpdateRentalUnit, TestGetRentalUnit, 
TestDeleteRentalUnit, FakeRentalStorageUnit, 
TestRentalStorageUnit;

  {$R *.res}

begin
  //TestRenterUnit.RegisterTest;
  //TestRenterStorageUnit.RegisterTest;

  //RunRegisteredTests;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
