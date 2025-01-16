unit MainFormUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  StdCtrls, ExtCtrls, ComCtrls, ValEdit, ColorBox, LazHelpHTML, Buttons,
  HtmlView, AnchorDockPanel, RTTIGrids, Types, RegisterRenterFormUnit,
  UpdateRenterFormUnit, DeleteRenterFormUnit, GlobalVariablesUnit,
  AddVehicleFormUnit, UpdateVehicleFormUnit, DeleteVehicleFormUnit,
  RegisterRentalFormUnit, UpdateRentalFormUnit, DeleteRentalFormUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure AdicionarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin

end;

procedure TMainForm.Panel3Click(Sender: TObject);
begin

end;

procedure TMainForm.PageControl1Change(Sender: TObject);
begin

end;

procedure TMainForm.AdicionarClick(Sender: TObject);
begin

end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  RegisterRenterForm.Show;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  UpdateRenterForm.Show;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  DeleteRenterForm.Show;
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  AddVehicleForm.Show;
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
  UpdateVehicleForm.Show;
end;

procedure TMainForm.Button6Click(Sender: TObject);
begin
  DeleteVehicleForm.Show;
end;

procedure TMainForm.Button7Click(Sender: TObject);
begin
  RegisterRentalForm.Show;
end;

procedure TMainForm.Button8Click(Sender: TObject);
begin
  UpdateRentalForm.Show;
end;

procedure TMainForm.Button9Click(Sender: TObject);
begin
  DeleteRentalForm.Show;
end;

end.
