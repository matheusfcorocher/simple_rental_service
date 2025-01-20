unit VehicleControllerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterVehicleUnit, UpdateVehicleUnit,
  GetVehicleUnit, DeleteVehicleUnit, IPresenterUnit,
  VehicleUnit, JSONConvertersUnit, VehicleDTOUnit;

type

  { TVehicleController }

  generic TVehicleController<T> = class
  private
    FRegisterVehicle: TRegisterVehicle;
    FUpdateVehicle: TUpdateVehicle;
    FGetVehicle: TGetVehicle;
    FDeleteVehicle: TDeleteVehicle;

    FPresenter: specialize ITPresenter<T>;
  public
    constructor Create(RegisterVehicle: TRegisterVehicle; UpdateVehicle: TUpdateVehicle;
      GetVehicle: TGetVehicle; DeleteVehicle: TDeleteVehicle;
      Presenter: specialize ITPresenter<T>);
    function Register(JSON: TJSONObject): T;
    function Update(JSON: TJSONObject): T;
    function Get(JSON: TJSONObject): T;
    function Delete(JSON: TJSONObject): T;
  end;

implementation

{ TVehicleController }

constructor TVehicleController.Create(RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle; GetVehicle: TGetVehicle; DeleteVehicle: TDeleteVehicle;
  Presenter: specialize ITPresenter<T>);
begin
  FRegisterVehicle := RegisterVehicle;
  FUpdateVehicle := UpdateVehicle;
  FGetVehicle := GetVehicle;
  FDeleteVehicle := DeleteVehicle;

  FPresenter := Presenter;
end;

function TVehicleController.Register(JSON: TJSONObject): T;
var
  VehicleDetailsDTO: TVehicleDetailsDTO;
  Vehicle: TVehicle;
begin
  try
    VehicleDetailsDTO := JSONToVehicleDetailsDTO(JSON);
    Vehicle := FRegisterVehicle.Execute(VehicleDetailsDTO);
    Result := FPresenter.Present(Vehicle);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TVehicleController.Update(JSON: TJSONObject): T;
var
  VehicleDTO : TVehicleDTO;
  Vehicle: TVehicle;
begin
  try
    VehicleDTO := JSONToVehicleDTO(JSON);
    Vehicle := FUpdateVehicle.Execute(VehicleDTO);
    Result := FPresenter.Present(Vehicle);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TVehicleController.Get(JSON: TJSONObject): T;
var
  Id: String;
  Vehicle: TVehicle;
begin
  try
    Id := JSONToId(JSON);
    Vehicle := FGetVehicle.Execute(Id);
    Result := FPresenter.Present(Vehicle);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

function TVehicleController.Delete(JSON: TJSONObject): T;
var
  Id: String;
  Message: String;
begin
  try
    Id := JSONToId(JSON);
    Message := FDeleteVehicle.Execute(Id);
    Result := FPresenter.Present(Message);
  except
    on E: Exception do
      Result := FPresenter.Present(E);
  end;
end;

end.

