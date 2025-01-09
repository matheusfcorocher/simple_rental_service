unit RentalControllerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRentalUnit, UpdateRentalUnit,
  GetRentalUnit, DeleteRentalUnit, IPresenterUnit,
  RentalUnit, JSONConvertersUnit, RentalDTOUnit;

type

  { TRentalController }

  generic TRentalController<T> = class
  private
    FRegisterRental: TRegisterRental;
    FUpdateRental: TUpdateRental;
    FGetRental: TGetRental;
    FDeleteRental: TDeleteRental;

    FPresenter: specialize ITPresenter<T>;
  public
    constructor Create(RegisterRental: TRegisterRental; UpdateRental: TUpdateRental;
      GetRental: TGetRental; DeleteRental: TDeleteRental;
      Presenter: specialize ITPresenter<T>);
    function Register(JSON: TJSONObject): T;
    function Update(JSON: TJSONObject): T;
    function Get(JSON: TJSONObject): T;
    function Delete(JSON: TJSONObject): T;
  end;

implementation

{ TRentalController }

constructor TRentalController.Create(RegisterRental: TRegisterRental;
  UpdateRental: TUpdateRental; GetRental: TGetRental; DeleteRental: TDeleteRental;
  Presenter: specialize ITPresenter<T>);
begin
  FRegisterRental := RegisterRental;
  FUpdateRental := UpdateRental;
  FGetRental := GetRental;
  FDeleteRental := DeleteRental;

  FPresenter := Presenter;
end;

function TRentalController.Register(JSON: TJSONObject): T;
var
  RentalInfoDTO: TRentalInfoDTO;
  Rental: TRental;
begin
  try
    RentalInfoDTO := JSONToRentalInfoDTO(JSON);
    Rental := FRegisterRental.Execute(RentalInfoDTO);
    Result := FPresenter.Present(Rental);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TRentalController.Update(JSON: TJSONObject): T;
var
  RentalDTO: TRentalDTO;
  Rental: TRental;
begin
  try
    RentalDTO := JSONToRentalDTO(JSON);
    Rental := FUpdateRental.Execute(RentalDTO);
    Result := FPresenter.Present(Rental);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TRentalController.Get(JSON: TJSONObject): T;
var
  Id: String;
  Rental: TRental;
begin
  try
    Id := JSONToId(JSON);
    Rental := FGetRental.Execute(Id);
    Result := FPresenter.Present(Rental);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TRentalController.Delete(JSON: TJSONObject): T;
var
  Id: String;
  Message: String;
begin
  try
    Id := JSONToId(JSON);
    Message := FDeleteRental.Execute(Id);
    Result := FPresenter.Present(Message);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

end.


