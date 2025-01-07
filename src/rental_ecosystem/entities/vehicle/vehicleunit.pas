unit VehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, Generics.Collections, VehicleDTOUnit, VehicleStatusUnit,
  VehicleExceptionsUnit;

type

  TVehicleData = record
    name: string;
    licensePlate: string;
    value: currency;
    status: TVehicleStatus;
  end;

  { TVehicle }

  TVehicle = class
  private
    Fid: string;
    Fname: string;
    FlicensePlate: string;
    Fvalue: currency;
    Fstatus: TVehicleStatus;

    function IsNameValid(Name: string): boolean;
    function IsLicensePlateValid(licensePlate: string): boolean;
    function IsValueValid(Value: currency): boolean;

    function HasNameValidDigits(Name: string): boolean;
    function HasLicensePlateValidDigits(licensePlate: string): boolean;
    function IsValueNotNegative(Value: currency): boolean;
  public
    constructor Create(id: string; Name: string; licensePlate: string;
      Value: currency; status: TVehicleStatus);

    constructor Create(VehicleDTO: TVehicleDTO); overload;

    //getter and setter methods
    function getId: string;

    function getName: string;
    procedure setName(Name: string);

    function getLicensePlate: string;
    procedure setLicensePlate(licensePlate: string);

    function getValue: currency;
    procedure setValue(Value: currency);

    function getStatus: TVehicleStatus;
    procedure setStatus(status: TVehicleStatus);

    function IsVehicleAvailable() : Boolean;
  end;

  TVehicles = specialize TObjectList<TVehicle>;

  TVehiclesHelper = class helper for TVehicles
    function ToObjectList(): specialize TObjectList<TObject>;
  end;

function VehicleEquals(a, b: TVehicle): boolean;

implementation

constructor TVehicle.Create(id: string; Name: string; licensePlate: string;
  Value: currency; status: TVehicleStatus);
begin

  IsNameValid(Name);
  IsLicensePlateValid(licensePlate);
  IsValueValid(Value);

  Fid := id;
  Fname := Name;
  FlicensePlate := licensePlate;
  Fvalue := Value;
  Fstatus := status;
end;

constructor TVehicle.Create(VehicleDTO: TVehicleDTO);
begin

  IsNameValid(VehicleDTO.Name);
  IsLicensePlateValid(VehicleDTO.licensePlate);
  IsValueValid(VehicleDTO.Value);

  Fid := VehicleDTO.id;
  Fname := VehicleDTO.Name;
  FlicensePlate := VehicleDTO.licensePlate;
  Fvalue := VehicleDTO.Value;
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

procedure TVehicle.setName(Name: string);
begin
  IsNameValid(Name);

  Fname := Name;
end;

function TVehicle.getLicensePlate(): string;
begin
  Result := FlicensePlate;
end;

procedure TVehicle.setLicensePlate(licensePlate: string);
begin
  IsLicensePlateValid(licensePlate);

  FlicensePlate := licensePlate;
end;

function TVehicle.getValue(): currency;
begin
  Result := Fvalue;
end;

procedure TVehicle.setValue(Value: currency);
begin
  IsValueValid(Value);

  Fvalue := Value;
end;

function TVehicle.getStatus(): TVehicleStatus;
begin
  Result := Fstatus;
end;

procedure TVehicle.setStatus(status: TVehicleStatus);
begin
  Fstatus := status;
end;

function TVehicle.IsVehicleAvailable(): Boolean;
begin
  if not IsVehicleStatusEqual(Fstatus, TVehicleStatus.AVAILABLE) then
  begin
    CreateVehicleNotAvailableError;
  end;

  Result := True;
end;

function TVehicle.IsNameValid(Name: string): boolean;
var
  IsValid: boolean;
begin
  IsValid := HasNameValidDigits(Name);

  if not IsValid then
  begin
    CreateVehicleNameError;
  end;

  Result := IsValid;
end;

function TVehicle.IsLicensePlateValid(licensePlate: string): boolean;
var
  IsValid: boolean;
begin
  IsValid := HasLicensePlateValidDigits(licensePlate);

  if not IsValid then
  begin
    CreateVehicleLicensePlateError;
  end;

  Result := IsValid;
end;

function TVehicle.IsValueValid(Value: currency): boolean;
var
  IsValid: boolean;
begin
  IsValid := IsValueNotNegative(Value);

  if not IsValid then
  begin
    CreateVehicleValueError;
  end;

  Result := IsValid;
end;

function TVehicle.HasNameValidDigits(Name: string): boolean;
const
  minimumDigits = 3;
begin
  Result := (Length(Name) >= minimumDigits);
end;

function TVehicle.HasLicensePlateValidDigits(licensePlate: string): boolean;
const
  minimumDigits = 6;
begin
  Result := (Length(licensePlate) >= minimumDigits);
end;

function TVehicle.IsValueNotNegative(Value: currency): boolean;
begin
  Result := Value >= 0;
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

function VehicleEquals(a, b: TVehicle): boolean;
begin
  Result := (a.getName = b.getName) and (a.getLicensePlate =
    b.getLicensePlate) and (a.getValue = b.getValue) and
    (a.getStatus = b.getStatus);
end;

end.
