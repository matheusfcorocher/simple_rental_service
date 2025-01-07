unit RentalServiceContainerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterControllerUnit, VehicleControllerUnit;

type
  generic TRentalServiceContainer<T> = class
  private
    FRenterController: specialize TRenterController<T>;
    FVehicleController: specialize TVehicleController<T>;

  public
    constructor Create(RenterController:
      specialize TRenterController<T>; VehicleController: specialize TVehicleController<T>);
    function GetRenterController(): specialize TRenterController<T>;
    function GetVehicleController(): specialize TVehicleController<T>;
  end;

implementation

constructor TRentalServiceContainer.Create(RenterController:
  specialize TRenterController<T>; VehicleController: specialize TVehicleController<T>);
begin
  FRenterController := RenterController;
  FVehicleController := VehicleController;
end;

function TRentalServiceContainer.GetRenterController(): specialize TRenterController<T>;
begin
  Result := FRenterController;
end;

function TRentalServiceContainer.GetVehicleController()
: specialize TVehicleController<T>;
begin
  Result := FVehicleController;
end;

end.
