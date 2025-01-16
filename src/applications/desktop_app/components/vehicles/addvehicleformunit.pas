unit AddVehicleFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, fpjson, jsonparser, GlobalVariablesUnit;

type

  { TAddVehicleForm }

  TAddVehicleForm = class(TForm)
    LicensePlateLabel: TLabel;
    LicensePlateTextField: TEdit;
    TextMessageError: TLabel;
    ValueLabel: TLabel;
    ValueTextField: TEdit;
    NameLabel: TLabel;
    NameTextField: TEdit;
    AddButton: TButton;
    TitleLabel: TLabel;
    procedure LicensePlateLabelClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure StatusLabelClick(Sender: TObject);
    procedure TitleLabelClick(Sender: TObject);
  private

  public

  end;

var
  AddVehicleForm: TAddVehicleForm;

implementation

{$R *.lfm}

uses MainFormUnit;

{ TAddVehicleForm }

procedure TAddVehicleForm.TitleLabelClick(Sender: TObject);
begin

end;

procedure TAddVehicleForm.LicensePlateLabelClick(Sender: TObject);
begin

end;

procedure TAddVehicleForm.AddButtonClick(Sender: TObject);
var
  VehicleJSON: TJSONObject;
  Response: TJSONObject;
  Data: TJSONObject;
  NewRow : Integer;
begin
    VehicleJSON := TJSONObject.Create;
    VehicleJSON.Add('name', NameTextField.Text);
    VehicleJSON.Add('licensePlate', LicensePlateTextField.Text);
    VehicleJSON.Add('value', StrToInt(ValueTextField.Text));
    VehicleJSON.Add('status', 'AVAILABLE');

    Response := RentalService.GetVehicleController().Register(VehicleJSON);

    if Response.Get('success', False) = true then
    begin
      // getting data field
      TextMessageError.Visible := False;
      Data := Response.Objects['data'];

      NewRow := MainForm.StringGrid2.RowCount;
      MainForm.StringGrid2.InsertRowWithValues(NewRow,
       [NewRow.ToString, Data.Get('id', ''), Data.Get('name', ''),
       Data.Get('licensePlate', ''), IntToStr(Data.Get('value', 0)), Data.Get('status', '')]);
    end
    else
    begin
      TextMessageError.Caption := Response.Get('message', '');
      TextMessageError.Visible := True;
    end;
end;

procedure TAddVehicleForm.StatusLabelClick(Sender: TObject);
begin

end;

end.

