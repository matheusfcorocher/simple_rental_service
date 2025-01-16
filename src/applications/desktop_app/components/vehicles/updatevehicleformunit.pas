unit UpdateVehicleFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, fpjson, jsonparser, GlobalVariablesUnit, StringGridUtilsUnit;

type

  { TUpdateVehicleForm }

  TUpdateVehicleForm = class(TForm)
    UpdateButton: TButton;
    LicensePlateLabel: TLabel;
    LicensePlateTextField: TEdit;
    NameLabel: TLabel;
    IdLabel: TLabel;
    NameTextField: TEdit;
    IdTextField: TEdit;
    StatusGroup: TRadioGroup;
    TextMessageError: TLabel;
    TitleLabel: TLabel;
    ValueLabel: TLabel;
    ValueTextField: TEdit;
    procedure UpdateButtonClick(Sender: TObject);
  private

  public

  end;

var
  UpdateVehicleForm: TUpdateVehicleForm;

implementation

{$R *.lfm}

uses MainFormUnit;

  { TUpdateVehicleForm }

procedure TUpdateVehicleForm.UpdateButtonClick(Sender: TObject);
var
  VehicleJSON: TJSONObject;
  SelectedIndex: integer;
  Response: TJSONObject;
  Data: TJSONObject;

  NewRow: integer;
  RowIndex: integer;
begin
  try
    VehicleJSON := TJSONObject.Create;
    VehicleJSON.Add('id', IdTextField.Text);
    VehicleJSON.Add('name', NameTextField.Text);
    VehicleJSON.Add('licensePlate', LicensePlateTextField.Text);
    VehicleJSON.Add('value', StrToInt(ValueTextField.Text));

    SelectedIndex := StatusGroup.ItemIndex;
    if SelectedIndex = -1 then
    begin
      TextMessageError.Caption := 'O status do veículo não foi selecionado.';
      TextMessageError.Visible := True;
      Exit;
    end
    else if SelectedIndex = 0 then
    begin
      VehicleJSON.Add('status', 'AVAILABLE');
    end
    else
    begin
      VehicleJSON.Add('status', 'RENTED');
    end;

    Response := RentalService.GetVehicleController().Update(VehicleJSON);

    if Response.Get('success', False) = True then
    begin
      // getting data field
      TextMessageError.Visible := False;
      Data := Response.Objects['data'];

      // find row in string grid
      RowIndex := FindRowWithValueInStringGrid(MainForm.StringGrid2, Data.Get('id', ''), 1);
      // Search in column 1

      // Delete row
      MainForm.StringGrid2.DeleteRow(RowIndex);

      // Add updated row
      NewRow := MainForm.StringGrid2.RowCount;

      MainForm.StringGrid2.InsertRowWithValues(NewRow,
        [NewRow.ToString, Data.Get('id', ''), Data.Get('name', ''),
        Data.Get('licensePlate', ''), IntToStr(Data.Get('value', 0)),
        Data.Get('status', '')]);
    end
    else
    begin
      TextMessageError.Caption := Response.Get('message', '');
      TextMessageError.Visible := True;
    end;
  except
    on E: Exception do
    begin
      TextMessageError.Caption := E.Message;
      TextMessageError.Visible := True;
    end;
  end;
end;

end.
