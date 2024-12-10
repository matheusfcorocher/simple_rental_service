unit MainMenuUnit;

interface

uses Winapi.Windows, System.SysUtils;

procedure Menu;

procedure CleanConsole;

implementation

uses ClientMenuUnit, VehiclesMenuUnit, RentalMenuUnit;

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

end.

