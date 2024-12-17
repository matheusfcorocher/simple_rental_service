program RentalServiceTestRunner;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, TestRenterDTOUnit, TestRenterStorageUnit, TestRenterUnit,
  GuiTestRunner, TestStandardResponseUnit, TestSystemResponseUnit,
TestRegisterRenterUnit, TestUpdateRenterUnit, UpdateRenterUnit,
TestGetRenterUnit, GetRenterUnit;

  {$R *.res}

begin
  //TestRenterUnit.RegisterTest;
  //TestRenterStorageUnit.RegisterTest;

  //RunRegisteredTests;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
