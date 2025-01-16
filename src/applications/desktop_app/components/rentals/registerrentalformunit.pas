unit RegisterRentalFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  Calendar, fpjson, jsonparser, GlobalVariablesUnit;

type

  { TRegisterRentalForm }

  TRegisterRentalForm = class(TForm)
    AddButton: TButton;
    StartDateCalendar: TCalendar;
    EndDateCalendar: TCalendar;
    RenterIdLabel: TLabel;
    RenterIdTextField: TEdit;
    StartDateLabel: TLabel;
    EndDateLabel: TLabel;
    TextMessageError: TLabel;
    TitleLabel: TLabel;
    VehicleIdLabel: TLabel;
    VehicleIdTextField: TEdit;
    procedure AddButtonClick(Sender: TObject);
  private

  public

  end;

var
  RegisterRentalForm: TRegisterRentalForm;

implementation

uses MainFormUnit;

{$R *.lfm}

{ TRegisterRentalForm }

procedure TRegisterRentalForm.AddButtonClick(Sender: TObject);
var
  RentalJSON: TJSONObject;
  Response: TJSONObject;
  Data: TJSONObject;
  Vehicle: TJSONObject;
  NewRow : Integer;
begin
    RentalJSON := TJSONObject.Create;
    RentalJSON.Add('renter_id', RenterIdTextField.Text);
    RentalJSON.Add('vehicle_id', VehicleIdTextField.Text);
    RentalJSON.Add('start_date', StartDateCalendar.Date);
    RentalJSON.Add('end_date', EndDateCalendar.Date);

    Response := RentalService.GetRentalController().Register(RentalJSON);

    if Response.Get('success', False) = true then
    begin
      // getting data field
      TextMessageError.Visible := False;
      Data := Response.Objects['data'];

      Vehicle := Data.Objects['vehicle'];

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

