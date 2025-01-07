unit AssembleRentalServiceUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegisterRenterUnit, UpdateRenterUnit, GetRenterUnit,
  DeleteRenterUnit, RenterStorageUnit, RegisterVehicleUnit, UpdateVehicleUnit,
  GetVehicleUnit, DeleteVehicleUnit, VehicleStorageUnit,
  RenterControllerUnit, VehicleControllerUnit, IPresenterUnit,
  ConsolePresenterUnit, RentalServiceContainerUnit;

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;

implementation

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;
var
  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  GetRenter: TGetRenter;
  DeleteRenter: TDeleteRenter;

  RegisterVehicle: TRegisterVehicle;
  UpdateVehicle: TUpdateVehicle;
  GetVehicle: TGetVehicle;
  DeleteVehicle: TDeleteVehicle;

  RenterStorage: TRenterStorage;
  VehicleStorage: TVehicleStorage;

  RenterController: specialize TRenterController<string>;
  VehicleController: specialize TVehicleController<string>;

  Presenter: specialize ITPresenter<string>;
begin
  RenterStorage := TRenterStorage.Create();
  VehicleStorage := TVehicleStorage.Create();

  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  RegisterVehicle := TRegisterVehicle.Create(VehicleStorage);
  UpdateVehicle := TUpdateVehicle.Create(VehicleStorage);
  GetVehicle := TGetVehicle.Create(VehicleStorage);
  DeleteVehicle := TDeleteVehicle.Create(VehicleStorage);

  Presenter := TConsolePresenter.Create();

  RenterController := specialize TRenterController<string>.Create(
    RegisterRenter, UpdateRenter, GetRenter, DeleteRenter, Presenter);
  VehicleController := specialize TVehicleController<string>.Create(
    RegisterVehicle, UpdateVehicle, GetVehicle, DeleteVehicle, Presenter);

  Result := specialize TRentalServiceContainer<string>.Create(RenterController,
    VehicleController);
end;

end.
