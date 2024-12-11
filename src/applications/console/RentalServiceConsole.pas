program RentalServiceConsole;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFnDEF FPC}
  System.SysUtils,
{$ELSE}
{$ENDIF}
  MainMenuUnit in 'MainMenuUnit.pas',
  ClientMenuUnit in 'ClientMenuUnit.pas',
  VehiclesMenuUnit in 'VehiclesMenuUnit.pas',
  RentalMenuUnit in 'RentalMenuUnit.pas',
  ConsoleUtilsUnit in 'ConsoleUtilsUnit.pas';

begin
    MainMenuUnit.Menu;
end.
