unit RentalMenuUnit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses ConsoleUtilsUnit, fpjson, jsonparser, GlobalVariablesUnit;

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
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Register Rental');

  Writeln;
  Writeln('Digit Renters id: ');
  Readln(UserInput);
  RenterJSON.Add('renter_id', UserInput);

  Writeln;
  Writeln('Digit Vehicles id: ');
  Readln(UserInput);
  RenterJSON.Add('vehicle_id', UserInput);

  Writeln;
  Writeln('Digit start date of rental (example: 01/01/2025): ');
  Readln(UserInput);
  RenterJSON.Add('start_date', UserInput);

  Writeln;
  Writeln('Digit end date of rental (example: 31/01/2025): ');
  Readln(UserInput);
  RenterJSON.Add('end_date', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRentalController().Register(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure EditRental;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Update Rental');

  Writeln;
  Writeln('Digit id: ');
  Readln(UserInput);
  RenterJSON.Add('id', UserInput);

  Writeln;
  Writeln('Digit Renters id: ');
  Readln(UserInput);
  RenterJSON.Add('renter_id', UserInput);

  Writeln;
  Writeln('Digit Vehicles id: ');
  Readln(UserInput);
  RenterJSON.Add('vehicle_id', UserInput);

  Writeln;
  Writeln('Digit start date of rental (example: 01/01/2025): ');
  Readln(UserInput);
  RenterJSON.Add('start_date', UserInput);

  Writeln;
  Writeln('Digit end date of rental (example: 31/01/2025): ');
  Readln(UserInput);
  RenterJSON.Add('end_date', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRentalController().Update(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;
end;


procedure CheckRental;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Check Rental');

  Writeln;
  Writeln('Digit Rental id: ');
  Readln(UserInput);
  RenterJSON.Add('id', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRentalController().Get(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure DeleteRental;
var
 RenterJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  RenterJSON := TJSONObject.Create;
  Writeln('Delete Rental');

  Writeln;
  Writeln('Digit Rental id: ');
  Readln(UserInput);
  RenterJSON.Add('id', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetRentalController().Delete(RenterJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

end.
