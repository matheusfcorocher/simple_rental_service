program RentalServiceConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  MainMenuUnit in 'MainMenuUnit.pas',
  ClientMenuUnit in 'ClientMenuUnit.pas',
  VehiclesMenuUnit in 'VehiclesMenuUnit.pas';

begin
  try
    MainMenuUnit.Menu;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
