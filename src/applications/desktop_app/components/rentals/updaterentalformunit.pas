unit UpdateRentalFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Calendar, fpjson, jsonparser, GlobalVariablesUnit, StringGridUtilsUnit;

type

  { TUpdateRentalForm }

  TUpdateRentalForm = class(TForm)
    UpdateButton: TButton;
    EndDateCalendar: TCalendar;
    EndDateLabel: TLabel;
    RenterIdLabel: TLabel;
    RentalIdLabel: TLabel;
    RenterIdTextField: TEdit;
    RentalIdTextField: TEdit;
    StartDateCalendar: TCalendar;
    StartDateLabel: TLabel;
    TextMessageError: TLabel;
    TitleLabel: TLabel;
    VehicleIdLabel: TLabel;
    VehicleIdTextField: TEdit;
    procedure UpdateButtonClick(Sender: TObject);
  private

  public

  end;

var
  UpdateRentalForm: TUpdateRentalForm;

implementation

{$R *.lfm}

uses MainFormUnit;

{ TUpdateRentalForm }

procedure TUpdateRentalForm.UpdateButtonClick(Sender: TObject);
var
  RentalJSON: TJSONObject;
  Response: TJSONObject;
  Data: TJSONObject;
  Vehicle: TJSONObject;

  NewRow: integer;
  RowIndex: integer;
begin
    RentalJSON := TJSONObject.Create;
    RentalJSON.Add('id', RentalIdTextField.Text);
    RentalJSON.Add('renter_id', RenterIdTextField.Text);
    RentalJSON.Add('vehicle_id', VehicleIdTextField.Text);
    RentalJSON.Add('start_date', StartDateCalendar.Date);
    RentalJSON.Add('end_date', EndDateCalendar.Date);

    Response := RentalService.GetRentalController().Update(RentalJSON);

    if Response.Get('success', False) = true then
    begin
      // getting data field
      TextMessageError.Visible := False;
      Data := Response.Objects['data'];

      Vehicle := Data.Objects['vehicle'];

      // find row in string grid
      RowIndex := FindRowWithValueInStringGrid(MainForm.StringGrid3, Data.Get('id', ''), 1);
      // Search in column 1

      // Delete row
      MainForm.StringGrid3.DeleteRow(RowIndex);

      // Add updated row
      NewRow := MainForm.StringGrid3.RowCount;

      MainForm.StringGrid3.InsertRowWithValues(NewRow,
       [NewRow.ToString, Data.Get('id', ''), Data.Get('renter_id', ''),
       Vehicle.Get('id', ''), Data.Get('start_date', ''), Data.Get('end_date', '')]);
    end
    else
    begin
      TextMessageError.Caption := Response.Get('message', '');
      TextMessageError.Visible := True;
    end;
end;

end.
