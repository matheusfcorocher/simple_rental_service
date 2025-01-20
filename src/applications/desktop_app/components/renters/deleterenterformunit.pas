unit DeleteRenterFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpjson, jsonparser, GlobalVariablesUnit, Grids, StringGridUtilsUnit;

type

  { TDeleteRenterForm }

  TDeleteRenterForm = class(TForm)
    IdTextField: TEdit;
    TitleLabel: TLabel;
    IdLabel: TLabel;
    TextMessageError: TLabel;
    DeleteButton: TButton;
    procedure DeleteButtonClick(Sender: TObject);
    procedure TitleLabelClick(Sender: TObject);
  private

  public

  end;

var
  DeleteRenterForm: TDeleteRenterForm;

implementation

uses MainFormUnit;

{$R *.lfm}

{ TDeleteRenterForm }

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
    RowIndex := FindRowWithValueInStringGrid(MainForm.StringGrid1, RenterJSON.Get('id', ''), 1);
    // Search in column 1

    MainForm.StringGrid1.DeleteRow(RowIndex);
    UpdateRowIDs(MainForm.StringGrid1);
  end
  else
  begin
    TextMessageError.Caption := Response.Get('message', '');
    TextMessageError.Visible := True;
  end;
end;

procedure TDeleteRenterForm.TitleLabelClick(Sender: TObject);
begin

end;

end.
