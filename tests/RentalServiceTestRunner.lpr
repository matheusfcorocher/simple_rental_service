program RentalServiceTestRunner;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, TestRenterStorageUnit, TestRenterDTOUnit, TestRenterUnit,
  GuiTestRunner, TestStandardResponseUnit, TestSystemResponseUnit,
TestRegisterRenterUnit, TestUpdateRenterUnit, UpdateRenterUnit,
TestGetRenterUnit, GetRenterUnit, TestDeleteRenterUnit, DeleteRenterUnit,
FakeRenterStorageUnit, TestVehicleUnit, VehicleUnit, VehicleDTOUnit,
VehicleStatusUnit, TestVehicleDTOUnit, VehicleExceptionsUnit;

  {$R *.res}

begin
  //TestRenterUnit.RegisterTest;
  //TestRenterStorageUnit.RegisterTest;

  //RunRegisteredTests;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
