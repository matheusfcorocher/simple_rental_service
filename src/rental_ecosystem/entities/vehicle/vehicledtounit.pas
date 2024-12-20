unit VehicleDTOUnit;

{$mode ObjFPC}{$H+}

interface

uses VehicleStatusUnit;

type
  TVehicleDTO = record
    id: string;
    name: string;
    licensePlate: string;
    value: Currency;
    status: TVehicleStatus;
  end;

function CreateVehicleDTO(Aid: string; Aname: string; AlicensePlate: string;
    Avalue: Currency; Astatus: TVehicleStatus): TVehicleDTO;

function AreVehicleDTOsEquals(a, b : TVehicleDTO): Boolean;

implementation

uses VehicleUnit;

function CreateVehicleDTO(Aid: string; Aname: string; AlicensePlate: string;
    Avalue: Currency; Astatus: TVehicleStatus): TVehicleDTO;
var
  VehicleDTO: TVehicleDTO;
begin
  VehicleDTO.id := Aid;
  VehicleDTO.name := Aname;
  VehicleDTO.licensePlate := AlicensePlate;
  VehicleDTO.value := Avalue;
  VehicleDTO.status := Astatus;

  Result := VehicleDTO;
end;

function AreVehicleDTOsEquals(a, b : TVehicleDTO): Boolean;
begin
  Result := (a.id = b.id) and
            (a.name = b.name) and
            (a.licensePlate = b.licensePlate) and
            (a.value = b.value) and
            (a.status = b.status)
end;

end.
