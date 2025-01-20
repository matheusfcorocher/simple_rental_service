unit DeleteVehicleFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpjson, jsonparser, GlobalVariablesUnit, StringGridUtilsUnit;

type

  { TDeleteVehicleForm }

  TDeleteVehicleForm = class(TForm)
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
  DeleteVehicleForm: TDeleteVehicleForm;

implementation

uses MainFormUnit;

{$R *.lfm}

{ TDeleteVehicleForm }

procedure TDeleteVehicleForm.DeleteButtonClick(Sender: TObject);
var
  VehicleJSON: TJSONObject;
  SelectedIndex: integer;
  Response: TJSONObject;
  Data: TJSONObject;
  RowIndex: integer;
begin
  VehicleJSON := TJSONObject.Create;
  VehicleJSON.Add('id', IdTextField.Text);

  Response := RentalService.GetVehicleController().Delete(VehicleJSON);

  if Response.Get('success', False) = True then
  begin
    TextMessageError.Visible := False;

    // find row in string grid
    RowIndex := FindRowWithValueInStringGrid(MainForm.StringGrid2,
      VehicleJSON.Get('id', ''), 1);
    // Search in column 1

    // Delete row
    MainForm.StringGrid2.DeleteRow(RowIndex);

    UpdateRowIDs(MainForm.StringGrid2);
  end
  else
  begin
    TextMessageError.Caption := Response.Get('message', '');
    TextMessageError.Visible := True;
  end;
end;

end.
