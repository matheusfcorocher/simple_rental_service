unit RentalServiceContainerUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterControllerUnit, RegisterRenterUnit;

type
  generic TRentalServiceContainer<T> = class
    private
      FRenterController : specialize TRenterController<T>;

    public
      constructor Create(RenterController : specialize TRenterController<T>);
      function GetRenterController() : specialize TRenterController<T>;
  end;

implementation

constructor TRentalServiceContainer.Create(RenterController : specialize TRenterController<T>);
begin
  FRenterController := RenterController;
end;

function TRentalServiceContainer.GetRenterController() : specialize TRenterController<T>;
begin
  result := FRenterController;
end;

end.

