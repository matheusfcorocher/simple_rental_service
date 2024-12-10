unit RentalMenuUnit;

interface

uses ConsoleUtilsUnit;

// procedures related to Rental
procedure RentalMenu;
procedure RegisterRental;
procedure EditRental;
procedure CheckRental;
procedure DeleteRental;

implementation

uses MainMenuUnit;

procedure RentalMenu;
var
  Code: integer;
  Options: string;
begin
  CleanConsole;
  Writeln('Rentals Menu');
  Writeln;
  Writeln('Options');
  Writeln;

  Options := '1 - Register Rental' + #13#10 +
            '2 - Edit Rental' + #13#10 +
            '3 - Check Rental' + #13#10 +
            '4 - Delete Rental' + #13#10 +
            '5 - Back' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : RegisterRental;
      2 : EditRental;
      3 : CheckRental;
      4 : DeleteRental;
      5 : Menu;
    else
      begin
        Writeln;
        Writeln('Unknowm option. Chooses between 1 and 5.');
        Writeln;
      end;
    end;
  until Code in [1..5];
end;

procedure RegisterRental;
begin
  CleanConsole;
  Writeln('Clean Rental');
  Readln;
  Menu;
end;

procedure EditRental;
begin
  CleanConsole;
  Writeln('Edit Rental');
  Readln;
  Menu;
end;
procedure CheckRental;
begin
  CleanConsole;
  Writeln('Check Rental');
  Readln;
  Menu;
end;

procedure DeleteRental;
begin
  CleanConsole;
  Writeln('Delete Rental');
  Readln;
  Menu;
end;

end.
