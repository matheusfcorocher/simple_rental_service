unit UpdateRenterFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, fpjson, jsonparser, GlobalVariablesUnit, StringGridUtilsUnit;

type

  { TUpdateRenterForm }

  TUpdateRenterForm = class(TForm)
    AddressLabel: TLabel;
    AddressTextField: TEdit;
    EmailLabel: TLabel;
    EmailTextField: TEdit;
    NameLabel: TLabel;
    Idabel: TLabel;
    NameTextField: TEdit;
    IdTextField: TEdit;
    TextMessageError: TLabel;
    UpdateButton: TButton;
    TelephoneLabel: TLabel;
    TelephoneTextField: TEdit;
    TitleLabel: TLabel;
    procedure IdabelClick(Sender: TObject);
    procedure TitleLabelClick(Sender: TObject);
    procedure UpdateButtonClick(Sender: TObject);
  private

  public

  end;

var
  UpdateRenterForm: TUpdateRenterForm;

implementation

uses MainFormUnit;

{$R *.lfm}

{ TUpdateRenterForm }

procedure TUpdateRenterForm.TitleLabelClick(Sender: TObject);
begin

end;

procedure TUpdateRenterForm.UpdateButtonClick(Sender: TObject);
var
  RenterJSON: TJSONObject;
  Response: TJSONObject;
  Data: TJSONObject;
  NewRow: integer;
  RowIndex: integer;
begin
  RenterJSON := TJSONObject.Create;

  RenterJSON.Add('id', IdTextField.Text);
  RenterJSON.Add('name', NameTextField.Text);
  RenterJSON.Add('address', AddressTextField.Text);
  RenterJSON.Add('email', EmailTextField.Text);
  RenterJSON.Add('telephone', TelephoneTextField.Text);

  Response := RentalService.GetRenterController().Update(RenterJSON);

  if Response.Get('success', False) = True then
  begin
    // getting data field
    Data := Response.Objects['data'];

    // find row in string grid
    RowIndex := FindRowWithValueInStringGrid(MainForm.StringGrid1, Data.Get('id', ''), 1);
    // Search in column 1

    MainForm.StringGrid1.DeleteRow(RowIndex);
    MainForm.StringGrid1.InsertRowWithValues(RowIndex,
      [RowIndex.ToString, Data.Get('id', ''), Data.Get('name', ''),
      Data.Get('address', ''), Data.Get('email', ''), Data.Get('telephone', '')]);
  end
  else
  begin
    TextMessageError.Caption := Response.Get('message', '');
    TextMessageError.Visible := True;
  end;
end;

procedure TUpdateRenterForm.IdabelClick(Sender: TObject);
begin

end;

end.
