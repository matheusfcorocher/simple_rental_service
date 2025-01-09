unit RentalServiceContainerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterControllerUnit, VehicleControllerUnit, RentalControllerUnit;

type
  generic TRentalServiceContainer<T> = class
  private
    FRenterController: specialize TRenterController<T>;
    FVehicleController: specialize TVehicleController<T>;
    FRentalController: specialize TRentalController<T>;

  public
    constructor Create(RenterController: specialize TRenterController<T>;
      VehicleController: specialize TVehicleController<T>;
      RentalController: specialize TRentalController<T>);
    function GetRenterController(): specialize TRenterController<T>;
    function GetVehicleController(): specialize TVehicleController<T>;
    function GetRentalController(): specialize TRentalController<T>;
  end;

implementation

constructor TRentalServiceContainer.Create(RenterController:
  specialize TRenterController<T>; VehicleController: specialize TVehicleController<T>;
  RentalController: specialize TRentalController<T>);
begin
  FRenterController := RenterController;
  FVehicleController := VehicleController;
  FRentalController := RentalController;
end;

function TRentalServiceContainer.GetRenterController(): specialize TRenterController<T>;
begin
  Result := FRenterController;
end;

function TRentalServiceContainer.GetVehicleController(): specialize TVehicleController<T>;
begin
  Result := FVehicleController;
end;

function TRentalServiceContainer.GetRentalController(): specialize TRentalController<T>;
begin
  Result := FRentalController;
end;

end.
