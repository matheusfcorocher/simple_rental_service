unit VehiclesMenuUnit;

interface

uses Winapi.Windows, System.SysUtils;

procedure CleanConsole;

// procedures related to Vehicle
procedure VehiclesMenu;
procedure RegisterVehicle;
procedure EditVehicle;
procedure CheckVehicle;
procedure DeleteVehicle;

implementation

uses MainMenuUnit;

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

procedure VehiclesMenu;
var
  Code: integer;
  Options: string;
begin
  CleanConsole;
  Writeln('Vehicles Menu');
  Writeln;
  Writeln('Options');
  Writeln;

  Options := '1 - Register Vehicle' + #13#10 +
            '2 - Edit Vehicle' + #13#10 +
            '3 - Check Vehicle' + #13#10 +
            '4 - Delete Vehicle' + #13#10 +
            '5 - Back' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : RegisterVehicle;
      2 : EditVehicle;
      3 : CheckVehicle;
      4 : DeleteVehicle;
      5 : Menu;
    else
      begin
        Writeln;
        Writeln('Unknowm option. Chooses between 1 and 5.');
      end;
    end;
  until Code in [1..5];
end;

procedure RegisterVehicle;
begin
 CleanConsole;
 Writeln('Register Vehicle');
 Readln;
 Menu;
end;

procedure EditVehicle;
begin
 CleanConsole;
 Writeln('Edit Vehicle');
 Readln;
 Menu;
end;

procedure CheckVehicle;
begin
 CleanConsole;
 Writeln('Check Vehicle');
 Readln;
 Menu;
end;

procedure DeleteVehicle;
begin
 CleanConsole;
 Writeln('Delete Vehicle');
 Readln;
 Menu;
end;

end.
