unit DeleteRentalFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, fpjson, jsonparser, GlobalVariablesUnit, StringGridUtilsUnit;

type

  { TDeleteRentalForm }

  TDeleteRentalForm = class(TForm)
    DeleteButton: TButton;
    IdLabel: TLabel;
    IdTextField: TEdit;
    TextMessageError: TLabel;
    TitleLabel: TLabel;
    procedure DeleteButtonClick(Sender: TObject);
  private

  public

  end;

var
  DeleteRentalForm: TDeleteRentalForm;

implementation

uses MainFormUnit;

{$R *.lfm}

{ TDeleteRentalForm }

procedure TDeleteRentalForm.DeleteButtonClick(Sender: TObject);
var
  RentalJSON: TJSONObject;
  Response: TJSONObject;

  RowIndex: integer;
begin
    RentalJSON := TJSONObject.Create;
    RentalJSON.Add('id', IdTextField.Text);

    Response := RentalService.GetRentalController().Delete(RentalJSON);

    if Response.Get('success', False) = true then
    begin
      // getting data field
      TextMessageError.Visible := False;

      // find row in string grid
      RowIndex := FindRowWithValueInStringGrid(MainForm.StringGrid3, RentalJSON.Get('id', ''), 1);
      // Search in column 1

      // Delete row
      MainForm.StringGrid3.DeleteRow(RowIndex);
    end
    else
    begin
      TextMessageError.Caption := Response.Get('message', '');
      TextMessageError.Visible := True;
    end;
end;

end.

