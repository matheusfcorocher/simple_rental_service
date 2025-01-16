program RentalServiceDesktopApp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, FrameViewer09, anchordockpkg, runtimetypeinfocontrols, MainFormUnit,
  GlobalVariablesUnit, AddVehicleFormUnit, DeleteRenterFormUnit,
  RegisterRenterFormUnit, UpdateRenterFormUnit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddVehicleForm, AddVehicleForm);
  Application.CreateForm(TDeleteRenterForm, DeleteRenterForm);
  Application.CreateForm(TRegisterRenterForm, RegisterRenterForm);
  Application.CreateForm(TUpdateRenterForm, UpdateRenterForm);
  Application.Run;
end.

