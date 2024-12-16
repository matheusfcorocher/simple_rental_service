unit ConsoleUtilsUnit;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF FPC} 
  crt, 
  {$ENDIF} 
  {$IFDEF MSWINDOWS} 
  SysUtils,
  {$ENDIF} 
  Classes;


procedure CleanConsole;

implementation

procedure CleanConsole;
begin
  //uses clrscr of Unix-base systems
  {$IFDEF FPC} 
  clrscr; 
  {$ELSE}
  // uses System.SysUtils.ExecuteProcess to clean screen in Windows OS
  {$IFDEF MSWINDOWS} 
  System.SysUtils.ExecuteProcess('cmd.exe', '/C cls', []); 
  {$ENDIF} {$ENDIF}
end;

end.
