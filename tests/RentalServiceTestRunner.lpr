program RentalServiceTestRunner;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, FakeRenterStorageUnit, TestStandardResponseUnit,
  TestSystemResponseUnit, TestDeleteRenterUnit, TestGetRenterUnit,
  TestRegisterRenterUnit, TestUpdateRenterUnit, TestRenterStorageUnit,
  TestRenterDTOUnit, TestRenterUnit, GuiTestRunner;

  {$R *.res}

begin
  //TestRenterUnit.RegisterTest;
  //TestRenterStorageUnit.RegisterTest;

  //RunRegisteredTests;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
