unit RenterMenuUnit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses ConsoleUtilsUnit;

// procedures related to Clients
procedure RentersMenu;
procedure RegisterRenter;
procedure UpdateRenter;
procedure CheckRenter;
procedure DeleteRenter;

implementation

uses MainMenuUnit, fpjson, jsonparser, GlobalVariablesUnit;

procedure RentersMenu;
 var
  Code: integer;
  Options: string;
begin
  CleanConsole;
  Writeln('Renters Menu');
  Writeln;
  Writeln('Options');
  Writeln;

  Options := '1 - Register Renter' + #13#10 +
            '2 - Update Renter' + #13#10 +
            '3 - Check Renter' + #13#10 +
            '4 - Delete Renter' + #13#10 +
            '5 - Back' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : RegisterRenter;
      2 : UpdateRenter;
      3 : CheckRenter;
      4 : DeleteRenter;
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

procedure RegisterRenter;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Register Client');

  Writeln;
  Writeln('Digit Renters name: ');
  Readln(UserInput);
  RenterJSON.Add('name', UserInput);

  Writeln;
  Writeln('Digit Renters address: ');
  Readln(UserInput);
  RenterJSON.Add('address', UserInput);

  Writeln;
  Writeln('Digit Renters email: ');
  Readln(UserInput);
  RenterJSON.Add('email', UserInput);

  Writeln;
  Writeln('Digit Renters telephone: ');
  Readln(UserInput);
  RenterJSON.Add('telephone', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRenterController().Register(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure UpdateRenter;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Edit Renter');

  Writeln;
  Writeln('Digit Reters id: ');
  Readln(UserInput);
  RenterJSON.Add('id', UserInput);

  Writeln;
  Writeln('Digit Renters name: ');
  Readln(UserInput);
  RenterJSON.Add('name', UserInput);

  Writeln;
  Writeln('Digit Renters address: ');
  Readln(UserInput);
  RenterJSON.Add('address', UserInput);

  Writeln;
  Writeln('Digit Renters email: ');
  Readln(UserInput);
  RenterJSON.Add('email', UserInput);

  Writeln;
  Writeln('Digit Renters telephone: ');
  Readln(UserInput);
  RenterJSON.Add('telephone', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRenterController().Update(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure CheckRenter;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Check Renter');

  Writeln;
  Writeln('Digit Reters id: ');
  Readln(UserInput);
  RenterJSON.Add('id', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRenterController().Get(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;

end;

procedure DeleteRenter;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Delete Renter');

  Writeln;
  Writeln('Digit Reters id: ');
  Readln(UserInput);
  RenterJSON.Add('id', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRenterController().Delete(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;

end;


end.
