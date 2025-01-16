unit MainFormUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  StdCtrls, ExtCtrls, ComCtrls, ValEdit, ColorBox, LazHelpHTML, Buttons,
  HtmlView, AnchorDockPanel, RTTIGrids, Types, RegisterRenterFormUnit,
  UpdateRenterFormUnit, DeleteRenterFormUnit, GlobalVariablesUnit;

type

  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PageControl1: TPageControl;
    Panel1: TPanel;
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
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

end.
