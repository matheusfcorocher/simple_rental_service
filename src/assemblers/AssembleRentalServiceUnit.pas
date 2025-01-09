unit AssembleRentalServiceUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegisterRenterUnit, UpdateRenterUnit, GetRenterUnit,
  DeleteRenterUnit, RenterStorageUnit, RegisterVehicleUnit, UpdateVehicleUnit,
  GetVehicleUnit, DeleteVehicleUnit, VehicleStorageUnit,
  RenterControllerUnit, VehicleControllerUnit, RentalControllerUnit,
  ConsolePresenterUnit, RentalServiceContainerUnit, RentalStorageUnit,
  RegisterRentalUnit, UpdateRentalUnit, GetRentalUnit, DeleteRentalUnit, IPresenterUnit;

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;

implementation

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;
var
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
  RenterStorage := TRenterStorage.Create();
  VehicleStorage := TVehicleStorage.Create();
  RentalStorage := TRentalStorage.Create();

  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage);
  GetVehicle := TGetVehicle.Create(VehicleStorage);
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  RegisterRental := TRegisterRental.Create(RentalStorage, VehicleStorage, RenterStorage);
  UpdateRental := TUpdateRental.Create(RentalStorage, VehicleStorage, RenterStorage);
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

end.
