unit VehiclesMenuUnit;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses ConsoleUtilsUnit, fpjson, jsonparser, GlobalVariablesUnit;

// procedures related to Vehicle
procedure VehiclesMenu;
procedure RegisterVehicle;
procedure UpdateVehicle;
procedure CheckVehicle;
procedure DeleteVehicle;

implementation

uses MainMenuUnit;

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
            '2 - Update Vehicle' + #13#10 +
            '3 - Check Vehicle' + #13#10 +
            '4 - Delete Vehicle' + #13#10 +
            '5 - Back' + #13#10;

  Writeln(Options);

  repeat
    Write(Output, 'Choose your option: ');
    Readln(Input, Code);

    case Code of
      1 : RegisterVehicle;
      2 : UpdateVehicle;
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
var
 VehicleJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  VehicleJSON := TJSONObject.Create;
  Writeln('Register Vehicle');

  Writeln;
  Writeln('Digit Vehicles name: ');
  Readln(UserInput);
  VehicleJSON.Add('name', UserInput);

  Writeln;
  Writeln('Digit Vehicles License Plate: ');
  Readln(UserInput);
  VehicleJSON.Add('licensePlate', UserInput);

  Writeln;
  Writeln('Digit Vehicles value: ');
  Readln(UserInput);
  VehicleJSON.Add('value', UserInput);

  Writeln;
  Writeln('Digit Vehicles status: ');
  Readln(UserInput);
  VehicleJSON.Add('status', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetVehicleController().Register(VehicleJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure UpdateVehicle;
var
 VehicleJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  VehicleJSON := TJSONObject.Create;
  Writeln('Update Vehicle');

  Writeln;
  Writeln('Digit Vehicles id: ');
  Readln(UserInput);
  VehicleJSON.Add('id', UserInput);

  Writeln;
  Writeln('Digit Vehicles name: ');
  Readln(UserInput);
  VehicleJSON.Add('name', UserInput);

  Writeln;
  Writeln('Digit Vehicles License Plate: ');
  Readln(UserInput);
  VehicleJSON.Add('licensePlate', UserInput);

  Writeln;
  Writeln('Digit Vehicles value: ');
  Readln(UserInput);
  VehicleJSON.Add('value', UserInput);

  Writeln;
  Writeln('Digit Vehicles status: ');
  Readln(UserInput);
  VehicleJSON.Add('status', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetVehicleController().Update(VehicleJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure CheckVehicle;
var
 VehicleJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  VehicleJSON := TJSONObject.Create;
  Writeln('Check Vehicle');

  Writeln;
  Writeln('Digit Vehicles id: ');
  Readln(UserInput);
  VehicleJSON.Add('id', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetVehicleController().Get(VehicleJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

procedure DeleteVehicle;
var
 VehicleJSON: TJSONObject;
 UserInput : String;
 Result : String;
begin
  CleanConsole;
  VehicleJSON := TJSONObject.Create;
  Writeln('Delete Vehicle');

  Writeln;
  Writeln('Digit Vehicles id: ');
  Readln(UserInput);
  VehicleJSON.Add('id', UserInput);

  Writeln;
  Writeln('------------------------------');
  Writeln;

  Result := RentalService.GetVehicleController().Delete(VehicleJSON);
  Writeln(Result);
  Readln;

  Menu;
end;

end.
