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
RegisterRenterFormUnit, GlobalVariablesUnit, UpdateRenterFormUnit, 
DeleteRenterFormUnit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRegisterRenterForm, RegisterRenterForm);
  Application.CreateForm(TUpdateRenterForm, UpdateRenterForm);
  Application.CreateForm(TDeleteRenterForm, DeleteRenterForm);
  Application.Run;
end.

