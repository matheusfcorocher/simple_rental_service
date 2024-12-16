program RentalServiceTestRunner;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, TestRenterStorageUnit, TestRenterUnit,
  TestStandardResponseUnit, TestSystemResponseUnit, TestRenterDTOUnit;

  {$R *.res}

begin
  //TestRenterUnit.RegisterTest;
  //TestRenterStorageUnit.RegisterTest;

  //RunRegisteredTests;
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.
