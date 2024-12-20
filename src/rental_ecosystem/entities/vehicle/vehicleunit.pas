unit VehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
    SysUtils, Generics.Collections, SystemResponseUnit, VehicleDTOUnit, VehicleStatusUnit;

type
  TVehicle = class
    private
      Fid: string;
      Fname: string;
      FlicensePlate: string;
      Fvalue: Currency;
      Fstatus: TVehicleStatus;

    public
     constructor Create(id: string; name: string; licensePlate: string;
      value: Currency; status: TVehicleStatus);

     constructor Create(VehicleDTO: TVehicleDTO); overload;

     //getter and setter methods
     function getId: string;

     function getName: string;
     procedure setName(name: string);

     function getLicensePlate: string;
     procedure setLicensePlate(licensePlate: string);

     function getValue: Currency;
     procedure setValue(value: Currency);

     function getStatus: TVehicleStatus;
     procedure setStatus(status: TVehicleStatus);
  end;

  TVehicles = specialize TObjectList<TVehicle>;

  TVehiclesHelper = class helper for TVehicles
    function ToObjectList(): specialize TObjectList<TObject>;
  end;

  function VehicleEquals(a, b : TVehicle): boolean;

implementation

constructor TVehicle.Create(id: string; name: string; licensePlate: string;
      value: Currency; status: TVehicleStatus);
begin
    Fid := id;
    Fname := name;
    FlicensePlate := licensePlate;
    Fvalue := value;
    Fstatus := status;
end;

constructor TVehicle.Create(VehicleDTO: TVehicleDTO);
begin
    Fid := VehicleDTO.id;
    Fname := VehicleDTO.name;
    FlicensePlate := VehicleDTO.licensePlate;
    Fvalue := VehicleDTO.value;
    Fstatus := VehicleDTO.status;
end;


// getter and setter methods
function TVehicle.getId(): string;
begin
  Result := Fid;
end;

function TVehicle.getName(): string;
begin
  Result := Fname;
end;

procedure TVehicle.setName(name: string);
begin
    Fname := Name;
end;

function TVehicle.getLicensePlate(): string;
begin
  Result := FlicensePlate;
end;

procedure TVehicle.setLicensePlate(licensePlate: string);
begin
    FlicensePlate := licensePlate;
end;

function TVehicle.getValue(): Currency;
begin
  Result := Fvalue;
end;

procedure TVehicle.setValue(value: Currency);
begin
  Fvalue := value;
end;

function TVehicle.getStatus() : TVehicleStatus;
begin
  Result := Fstatus;
end;

procedure TVehicle.setStatus(status: TVehicleStatus);
begin
  Fstatus := status;
end;

function TVehiclesHelper.ToObjectList(): specialize TObjectList<TObject>;
var
  Vehicle: TVehicle;
  ObjectList: specialize TObjectList<TObject>;
begin
  ObjectList := specialize TObjectList<TObject>.Create();
  for Vehicle in Self do
    ObjectList.Add(Vehicle);

  Result := ObjectList;
end;

function VehicleEquals(a, b : TVehicle): boolean;
  begin
       Result := (a.getName = b.getName) and
       (a.getLicensePlate = b.getLicensePlate) and
       (a.getValue = b.getValue) and (a.getStatus =
       b.getStatus);
end;

end.
