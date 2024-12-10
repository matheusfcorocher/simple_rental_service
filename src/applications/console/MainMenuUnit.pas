unit MainMenuUnit;

interface

uses Winapi.Windows, System.SysUtils;

procedure Menu;

procedure CleanConsole;

// procedures related to Rental
procedure RentalMenu;
procedure RegisterRental;
procedure EditRental;
procedure CheckRental;
procedure DeleteRental;

implementation

uses ClientMenuUnit, VehiclesMenuUnit;

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

  Options := '1 - Clients Menu' + #13#10 +
            '2 - Vehicles Menu' + #13#10 +
            '3 - Rental Menu' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : ClientsMenu;
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

procedure CleanConsole;
var
  stdout: THandle;
  csbi: TConsoleScreenBufferInfo;
  ConsoleSize: DWORD;
  NumWritten: DWORD;
  Origin: TCoord;
begin
  // retrieve the handle of console output
  stdout := GetStdHandle(STD_OUTPUT_HANDLE);
  Win32Check(stdout <> INVALID_HANDLE_VALUE);
  // retrieve information about the console buffer
  Win32Check(GetConsoleScreenBufferInfo(stdout, csbi));
  // calculate the number of characters in buffer
  ConsoleSize := csbi.dwSize.X * csbi.dwSize.Y;
  Origin.X := 0;
  Origin.Y := 0;
  //fill the buffer with spaces and the original attributes
  Win32Check(FillConsoleOutputCharacter(stdout, ' ', ConsoleSize, Origin, NumWritten));
  Win32Check(FillConsoleOutputAttribute(stdout, csbi.wAttributes, ConsoleSize, Origin, NumWritten));
  //set cursor in position top-left corner
  Win32Check(SetConsoleCursorPosition(stdout, Origin));
end;

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

