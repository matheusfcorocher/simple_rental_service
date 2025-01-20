unit AssembleRentalServiceUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, RegisterRenterUnit, UpdateRenterUnit, GetRenterUnit,
  DeleteRenterUnit, RenterStorageUnit, RegisterVehicleUnit, UpdateVehicleUnit,
  GetVehicleUnit, DeleteVehicleUnit, VehicleStorageUnit,
  RenterControllerUnit, VehicleControllerUnit, RentalControllerUnit,
  ConsolePresenterUnit, RentalServiceContainerUnit, RentalStorageUnit,
  RegisterRentalUnit, UpdateRentalUnit, GetRentalUnit, DeleteRentalUnit,
  IPresenterUnit, WebAPIPresenterUnit, RenterBuilderUnit, VehicleBuilderUnit,
  RentalBuilderUnit, VehicleExceptionsCreatorENUnit, RentalExceptionsCreatorENUnit,
  RenterExceptionsCreatorENUnit, RenterExceptionsCreatorPTUnit, VehicleExceptionsCreatorPTUnit,
  RentalExceptionsCreatorPTUnit;

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;
function AssembleRentalServiceOnWebApi(): specialize TRentalServiceContainer<
  TJSONObject>;
function AssembleRentalServiceOnPTDesktopApp(): specialize TRentalServiceContainer<
  TJSONObject>;

implementation

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;

  RenterBuilder: TRenterBuilder;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  RenterStorage: TRenterStorage;
  VehicleStorage: TVehicleStorage;
  RentalStorage: TRentalStorage;

  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  GetRenter: TGetRenter;
  DeleteRenter: TDeleteRenter;

  RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle;
  GetVehicle: TGetVehicle;
  DeleteVehicle: TDeleteVehicle;

  RegisterRental: TRegisterRental;
  UpdateRental: TUpdateRental;
  GetRental: TGetRental;
  DeleteRental: TDeleteRental;

  RenterController: specialize TRenterController<string>;
  VehicleController: specialize TVehicleController<string>;
  RentalController: specialize TRentalController<string>;

  Presenter: specialize ITPresenter<string>;
begin

  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  RenterStorage := TRenterStorage.Create(RenterExceptionsCreator);
  VehicleStorage := TVehicleStorage.Create(VehicleExceptionsCreator);
  RentalStorage := TRentalStorage.Create(RentalExceptionsCreator);

  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage, RenterBuilder);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage, VehicleBuilder);
  GetVehicle := TGetVehicle.Create(VehicleStorage);
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  UpdateRental := TUpdateRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  GetRental := TGetRental.Create(RentalStorage);
  DeleteRental := TDeleteRental.Create(RentalStorage);

  Presenter := TConsolePresenter.Create();

  RenterController := specialize TRenterController<string>.Create(
    RegisterRenter, UpdateRenter, GetRenter, DeleteRenter, Presenter);
  VehicleController := specialize TVehicleController<string>.Create(
    RegisterVehicle, UpdateVehicle, GetVehicle, DeleteVehicle, Presenter);
  RentalController := specialize TRentalController<string>.Create(
    RegisterRental, UpdateRental, GetRental, DeleteRental, Presenter);

  Result := specialize TRentalServiceContainer<string>.Create(RenterController,
    VehicleController, RentalController);
end;

function AssembleRentalServiceOnWebApi(): specialize TRentalServiceContainer<
TJSONObject>;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  VehicleExceptionsCreator: TVehicleExceptionsCreatorEN;
  RentalExceptionsCreator: TRentalExceptionsCreatorEN;

  RenterBuilder: TRenterBuilder;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  RenterStorage: TRenterStorage;
  VehicleStorage: TVehicleStorage;
  RentalStorage: TRentalStorage;

  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  GetRenter: TGetRenter;
  DeleteRenter: TDeleteRenter;

  RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle;
  GetVehicle: TGetVehicle;
  DeleteVehicle: TDeleteVehicle;

  RegisterRental: TRegisterRental;
  UpdateRental: TUpdateRental;
  GetRental: TGetRental;
  DeleteRental: TDeleteRental;

  RenterController: specialize TRenterController<TJSONObject>;
  VehicleController: specialize TVehicleController<TJSONObject>;
  RentalController: specialize TRentalController<TJSONObject>;

  Presenter: specialize ITPresenter<TJSONObject>;
begin
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  VehicleExceptionsCreator := TVehicleExceptionsCreatorEN.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorEN.Create;

  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  RenterStorage := TRenterStorage.Create(RenterExceptionsCreator);
  VehicleStorage := TVehicleStorage.Create(VehicleExceptionsCreator);
  RentalStorage := TRentalStorage.Create(RentalExceptionsCreator);

  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage, RenterBuilder);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage, VehicleBuilder);
  GetVehicle := TGetVehicle.Create(VehicleStorage);
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  UpdateRental := TUpdateRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  GetRental := TGetRental.Create(RentalStorage);
  DeleteRental := TDeleteRental.Create(RentalStorage);

  Presenter := TWebAPIPresenter.Create();

  RenterController := specialize TRenterController<TJSONObject>.Create(
    RegisterRenter, UpdateRenter, GetRenter, DeleteRenter, Presenter);
  VehicleController := specialize TVehicleController<TJSONObject>.Create(
    RegisterVehicle, UpdateVehicle, GetVehicle, DeleteVehicle, Presenter);
  RentalController := specialize TRentalController<TJSONObject>.Create(
    RegisterRental, UpdateRental, GetRental, DeleteRental, Presenter);

  Result := specialize TRentalServiceContainer<TJSONObject>.Create(
    RenterController, VehicleController, RentalController);

end;

function AssembleRentalServiceOnPTDesktopApp():
specialize TRentalServiceContainer<TJSONObject>;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorPT;
  VehicleExceptionsCreator: TVehicleExceptionsCreatorPT;
  RentalExceptionsCreator: TRentalExceptionsCreatorPT;

  RenterBuilder: TRenterBuilder;
  VehicleBuilder: TVehicleBuilder;
  RentalBuilder: TRentalBuilder;

  RenterStorage: TRenterStorage;
  VehicleStorage: TVehicleStorage;
  RentalStorage: TRentalStorage;

  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  GetRenter: TGetRenter;
  DeleteRenter: TDeleteRenter;

  RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle;
  GetVehicle: TGetVehicle;
  DeleteVehicle: TDeleteVehicle;

  RegisterRental: TRegisterRental;
  UpdateRental: TUpdateRental;
  GetRental: TGetRental;
  DeleteRental: TDeleteRental;

  RenterController: specialize TRenterController<TJSONObject>;
  VehicleController: specialize TVehicleController<TJSONObject>;
  RentalController: specialize TRentalController<TJSONObject>;

  Presenter: specialize ITPresenter<TJSONObject>;
begin
  RenterExceptionsCreator := TRenterExceptionsCreatorPT.Create;
  VehicleExceptionsCreator := TVehicleExceptionsCreatorPT.Create;
  RentalExceptionsCreator := TRentalExceptionsCreatorPT.Create;

  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);
  VehicleBuilder := TVehicleBuilder.Create(VehicleExceptionsCreator);
  RentalBuilder := TRentalBuilder.Create(RentalExceptionsCreator);

  RenterStorage := TRenterStorage.Create(RenterExceptionsCreator);
  VehicleStorage := TVehicleStorage.Create(VehicleExceptionsCreator);
  RentalStorage := TRentalStorage.Create(RentalExceptionsCreator);

  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage, RenterBuilder);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage, VehicleBuilder);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage, VehicleBuilder);
  GetVehicle := TGetVehicle.Create(VehicleStorage);
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  UpdateRental := TUpdateRental.Create(RentalStorage, VehicleStorage,
    RenterStorage, RentalBuilder);
  GetRental := TGetRental.Create(RentalStorage);
  DeleteRental := TDeleteRental.Create(RentalStorage);

  Presenter := TWebAPIPresenter.Create();

  RenterController := specialize TRenterController<TJSONObject>.Create(
    RegisterRenter, UpdateRenter, GetRenter, DeleteRenter, Presenter);
  VehicleController := specialize TVehicleController<TJSONObject>.Create(
    RegisterVehicle, UpdateVehicle, GetVehicle, DeleteVehicle, Presenter);
  RentalController := specialize TRentalController<TJSONObject>.Create(
    RegisterRental, UpdateRental, GetRental, DeleteRental, Presenter);

  Result := specialize TRentalServiceContainer<TJSONObject>.Create(
    RenterController, VehicleController, RentalController);

end;

end.
