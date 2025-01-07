unit AssembleRentalServiceUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegisterRenterUnit, UpdateRenterUnit, GetRenterUnit,
  DeleteRenterUnit, RenterStorageUnit,
  RenterControllerUnit, IPresenterUnit, ConsolePresenterUnit, RentalServiceContainerUnit;

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;

implementation

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;
var
  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  GetRenter: TGetRenter;
  DeleteRenter: TDeleteRenter;

  RenterStorage: TRenterStorage;
  RenterController: specialize TRenterController<string>;
  Presenter: specialize ITPresenter<string>;
begin
  RenterStorage := TRenterStorage.Create();

  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  Presenter := TConsolePresenter.Create();

  RenterController := specialize TRenterController<string>.Create(
    RegisterRenter, UpdateRenter, GetRenter, DeleteRenter, Presenter);

  Result := specialize TRentalServiceContainer<string>.Create(RenterController);
end;

end.
