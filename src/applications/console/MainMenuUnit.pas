unit MainMenuUnit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses ConsoleUtilsUnit;

procedure Menu;

implementation

uses RenterMenuUnit, VehiclesMenuUnit, RentalMenuUnit;

procedure Menu;
var
  Code: integer;
  Options: string;
begin
  CleanConsole;
  Writeln('Main Menu');
  Writeln;
  Writeln('Options');
  Writeln;

  Options := '1 - Renters Menu' + #13#10 +
            '2 - Vehicles Menu' + #13#10 +
            '3 - Rental Menu' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : RentersMenu;
      2 : VehiclesMenu;
      3 : RentalMenu;
    else
      begin
        Writeln;
        Writeln('Unknowm option. Chooses between 1 and 3.');
        Writeln;
      end;
    end;
  until Code in [1..3];

end;

end.

