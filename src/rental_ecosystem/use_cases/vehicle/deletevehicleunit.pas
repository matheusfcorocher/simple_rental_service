unit DeleteVehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IVehicleStorageUnit;

type
  TDeleteVehicle = class
  private
    FVehicleStorage: ITVehicleStorage;
  public
    constructor Create(IVehicleStorage: ITVehicleStorage);
    function Execute(id : String): String;
  end;

implementation

constructor TDeleteVehicle.Create(IVehicleStorage: ITVehicleStorage);
begin
  FVehicleStorage := IVehicleStorage;
end;

function TDeleteVehicle.Execute(id : String): String;
begin
  Result := FVehicleStorage.Delete(id);
end;

end.
