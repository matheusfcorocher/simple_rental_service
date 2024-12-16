program RentalServiceConsole;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFnDEF FPC}
  System.SysUtils,
{$ELSE}
{$ENDIF}
  MainMenuUnit,
  ClientMenuUnit,
  VehiclesMenuUnit,
  RentalMenuUnit,
  ConsoleUtilsUnit;

begin
    MainMenuUnit.Menu;
end.
