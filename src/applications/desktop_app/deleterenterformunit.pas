unit DeleteRenterFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpjson, jsonparser, GlobalVariablesUnit, Grids;

function FindRowWithValue(Grid: TStringGrid; const Value: string;
  Column: integer): integer;

type

  { TDeleteRenterForm }

  TDeleteRenterForm = class(TForm)
    IdTextField: TEdit;
    TitleLabel: TLabel;
    IdLabel: TLabel;
    TextMessageError: TLabel;
    DeleteButton: TButton;
    procedure DeleteButtonClick(Sender: TObject);
  private

  public

  end;

var
  DeleteRenterForm: TDeleteRenterForm;

implementation

uses MainFormUnit;

{$R *.lfm}

{ TDeleteRenterForm }

function FindRowWithValue(Grid: TStringGrid; const Value: string;
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

procedure TDeleteRenterForm.DeleteButtonClick(Sender: TObject);
var
  RenterJSON: TJSONObject;
  Response: TJSONObject;
  Data: TJSONObject;
  RowIndex: integer;
begin
  RenterJSON := TJSONObject.Create;

  RenterJSON.Add('id', IdTextField.Text);

  Response := RentalService.GetRenterController().Delete(RenterJSON);

  if Response.Get('success', False) = True then
  begin

    // find row in string grid
    RowIndex := FindRowWithValue(MainForm.StringGrid1, RenterJSON.Get('id', ''), 1);
    // Search in column 1

    MainForm.StringGrid1.DeleteRow(RowIndex);
  end
  else
  begin
    TextMessageError.Caption := Response.Get('message', '');
    TextMessageError.Visible := True;
  end;
end;

end.
