unit RegisterRenterFormUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  PopupNotifier, uCEFTextfieldComponent, jsonparser, fpjson,
  GlobalVariablesUnit;

type

  { TRegisterRenterForm }

  TRegisterRenterForm = class(TForm)
    TextMessageError: TLabel;
    RegisterButton: TButton;
    NameTextField: TEdit;
    AddressTextField: TEdit;
    EmailTextField: TEdit;
    TelephoneTextField: TEdit;
    TitleLabel: TLabel;
    NameLabel: TLabel;
    AddressLabel: TLabel;
    EmailLabel: TLabel;
    TelephoneLabel: TLabel;

    procedure Frame1Click(Sender: TObject);
    procedure RegisterButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TitleLabelClick(Sender: TObject);
    procedure NameLabelClick(Sender: TObject);
    procedure EmailLabelClick(Sender: TObject);
  private

  public

  end;

var
  RegisterRenterForm: TRegisterRenterForm;

implementation

uses MainFormUnit;

{$R *.lfm}

procedure TRegisterRenterForm.FormCreate(Sender: TObject);
begin

end;

procedure TRegisterRenterForm.TitleLabelClick(Sender: TObject);
begin

end;

procedure TRegisterRenterForm.NameLabelClick(Sender: TObject);
begin

end;

procedure TRegisterRenterForm.EmailLabelClick(Sender: TObject);
begin

end;

procedure TRegisterRenterForm.RegisterButtonClick(Sender: TObject);
var
  RenterJSON: TJSONObject;
  Response: TJSONObject;
  Data: TJSONObject;
  NewRow : Integer;
begin
    RenterJSON := TJSONObject.Create;
    RenterJSON.Add('name', NameTextField.Text);
    RenterJSON.Add('address', AddressTextField.Text);
    RenterJSON.Add('email', EmailTextField.Text);
    RenterJSON.Add('telephone', TelephoneTextField.Text);

    Response := RentalService.GetRenterController().Register(RenterJSON);

    if Response.Get('success', False) = true then
    begin
      // getting data field
      Data := Response.Objects['data'];

      NewRow := MainForm.StringGrid1.RowCount;
      MainForm.StringGrid1.InsertRowWithValues(NewRow,
       [NewRow.ToString, Data.Get('id', ''), Data.Get('name', ''),
       Data.Get('address', ''), Data.Get('email', ''), Data.Get('telephone', '')]);
    end
    else
    begin
      TextMessageError.Caption := Response.Get('message', '');
      TextMessageError.Visible := True;
    end;
end;

procedure TRegisterRenterForm.Frame1Click(Sender: TObject);
begin

end;

end.
