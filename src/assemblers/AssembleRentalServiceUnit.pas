unit AssembleRentalServiceUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegisterRenterUnit, RenterStorageUnit,
  RenterControllerUnit, IPresenterUnit, ConsolePresenterUnit, RentalServiceContainerUnit;

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;

implementation

function AssembleRentalServiceOnConsole(): specialize TRentalServiceContainer<string>;
var
  RegisterRenter: TRegisterRenter;
  RenterStorage: TRenterStorage;
  RenterController: specialize TRenterController<string>;
  Presenter: specialize ITPresenter<string>;
begin
  RenterStorage := TRenterStorage.Create();
  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  Presenter := TConsolePresenter.Create();

  RenterController := specialize TRenterController<string>.Create(
    RegisterRenter, Presenter);

  Result := specialize TRentalServiceContainer<string>.Create(RenterController);
end;

end.
