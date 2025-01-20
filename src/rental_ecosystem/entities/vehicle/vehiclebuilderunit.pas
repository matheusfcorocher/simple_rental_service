unit VehicleBuilderUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, VehicleUnit, IVehicleExceptionsCreatorUnit, VehicleStatusUnit;

type
  TVehicleBuilder = class

  private
    _VehicleExceptionsCreator : ITVehicleExceptionsCreator;

  public
    constructor Create(VehicleExceptionsCreator : ITVehicleExceptionsCreator);
    function Build(id: string; name: string; licensePlate: string;
      value: currency; status: TVehicleStatus) : TVehicle;

  end;
implementation

constructor TVehicleBuilder.Create(
  VehicleExceptionsCreator: ITVehicleExceptionsCreator);
begin
  _VehicleExceptionsCreator := VehicleExceptionsCreator;
end;

function TVehicleBuilder.Build(id: string; name: string; licensePlate: string;
      value: currency; status: TVehicleStatus) : TVehicle;
begin
  result := TVehicle.Create(id, name, licensePlate, value, status, _VehicleExceptionsCreator);
end;

end.

