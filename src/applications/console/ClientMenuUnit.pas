unit ClientMenuUnit;

interface

uses Winapi.Windows, System.SysUtils;

procedure CleanConsole;

// procedures related to Clients
procedure ClientsMenu;
procedure RegisterClient;
procedure EditClient;
procedure CheckClient;
procedure DeleteClient;

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

procedure ClientsMenu;
 var
  Code: integer;
  Options: string;
begin
  CleanConsole;
  Writeln('Clients Menu');
  Writeln;
  Writeln('Options');
  Writeln;

  Options := '1 - Register Client' + #13#10 +
            '2 - Edit Client' + #13#10 +
            '3 - Check Client' + #13#10 +
            '4 - Delete Client' + #13#10 +
            '5 - Back' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : RegisterClient;
      2 : EditClient;
      3 : CheckClient;
      4 : DeleteClient;
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

procedure RegisterClient;
begin
  CleanConsole;
  Writeln('Register Client');
  Readln;
  Menu;
end;

procedure EditClient;
begin
  CleanConsole;
  Writeln('Edit Client');
  Readln;
  Menu;
end;

procedure CheckClient;
begin
  CleanConsole;
  Writeln('Check Client');
  Readln;
  Menu;
end;

procedure DeleteClient;
begin
  CleanConsole;
  Writeln('Delete Client');
  Readln;
  Menu;
end;

end.
