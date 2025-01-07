unit RenterControllerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRenterUnit, UpdateRenterUnit,
  GetRenterUnit, DeleteRenterUnit, IPresenterUnit,
  RenterUnit, JSONConvertersUnit;

type

  { TRenterController }

  generic TRenterController<T> = class
  private
    FRegisterRenter: TRegisterRenter;
    FUpdateRenter: TUpdateRenter;
    FGetRenter: TGetRenter;
    FDeleteRenter: TDeleteRenter;

    FPresenter: specialize ITPresenter<T>;
  public
    constructor Create(RegisterRenter: TRegisterRenter; UpdateRenter: TUpdateRenter;
      GetRenter: TGetRenter; DeleteRenter: TDeleteRenter;
      Presenter: specialize ITPresenter<T>);
    function Register(JSON: TJSONObject): T;
    function Update(JSON: TJSONObject): T;
    function Get(JSON: TJSONObject): T;
    function Delete(JSON: TJSONObject): T;
  end;

implementation

{ TRenterController }

constructor TRenterController.Create(RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter; GetRenter: TGetRenter; DeleteRenter: TDeleteRenter;
  Presenter: specialize ITPresenter<T>);
begin
  FRegisterRenter := RegisterRenter;
  FUpdateRenter := UpdateRenter;
  FGetRenter := GetRenter;
  FDeleteRenter := DeleteRenter;

  FPresenter := Presenter;
end;

function TRenterController.Register(JSON: TJSONObject): T;
var
  RenterData: TRenterData;
  Renter: TRenter;
begin
  try
    RenterData := JSONToRenterData(JSON);
    Renter := FRegisterRenter.Execute(RenterData);
    Result := FPresenter.Present(Renter);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TRenterController.Update(JSON: TJSONObject): T;
var
  Renter: TRenter;
begin
  try
    Renter := JSONToRenter(JSON);
    Renter := FUpdateRenter.Execute(Renter);
    Result := FPresenter.Present(Renter);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TRenterController.Get(JSON: TJSONObject): T;
var
  Id: String;
  Renter: TRenter;
begin
  try
    Id := JSONToId(JSON);
    Renter := FGetRenter.Execute(Id);
    Result := FPresenter.Present(Renter);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TRenterController.Delete(JSON: TJSONObject): T;
var
  Id: String;
  Message: String;
begin
  try
    Id := JSONToId(JSON);
    Message := FDeleteRenter.Execute(Id);
    Result := FPresenter.Present(Message);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

end.
