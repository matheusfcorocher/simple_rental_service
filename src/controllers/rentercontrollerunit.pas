unit RenterControllerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRenterUnit, IPresenterUnit,
  RenterUnit, JSONConvertersUnit;

type

  { TRenterController }

  generic TRenterController<T> = class
  private
    FRegisterRenter: TRegisterRenter;
    FPresenter: specialize ITPresenter<T>;
  public
    constructor Create(RegisterRenter: TRegisterRenter;
      Presenter: specialize ITPresenter<T>);
    function RenterRegister(RenterJSON: TJSONObject): string;
  end;

implementation

{ TRenterController }

constructor TRenterController.Create(RegisterRenter: TRegisterRenter;
  Presenter: specialize ITPresenter<T>);
begin
  FRegisterRenter := RegisterRenter;
  FPresenter := Presenter;
end;

function TRenterController.RenterRegister(RenterJSON: TJSONObject): string;
var
  RenterData: TRenterData;
  Renter: TRenter;
begin
  try
    RenterData := RenterJSONToData(RenterJSON);
    Renter := FRegisterRenter.Execute(RenterData);
    Result := FPresenter.Present(Renter);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

end.
