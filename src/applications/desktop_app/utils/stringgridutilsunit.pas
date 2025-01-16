unit StringGridUtilsUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Grids;

function FindRowWithValueInStringGrid(Grid: TStringGrid; const Value: string; Column: integer): integer;

implementation

function FindRowWithValueInStringGrid(Grid: TStringGrid; const Value: string;
  Column: integer): integer;
var
  Row: integer;
begin
  Result := -1; // Default value if the value is not found
  for Row := 0 to Grid.RowCount - 1 do
  begin
    if Grid.Cells[Column, Row] = Value then
    begin
      Result := Row;
      Exit; // Exit the loop once the value is found
    end;
  end;
end;

end.

