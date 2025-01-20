unit VehicleUnit;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, VehicleDTOUnit, VehicleStatusUnit,
  IVehicleExceptionsCreatorUnit;

type
  { TVehicle }

  TVehicle = class
  private
    _id: string;
    _name: string;
    _licensePlate: string;
    _value: currency;
    _status: TVehicleStatus;

    _ExceptionsCreator: ITVehicleExceptionsCreator;

    function _IsNameValid(): boolean;
    function _IsLicensePlateValid(): boolean;
    function _IsValueValid(): boolean;

    function _HasNameValidDigits(): boolean;
    function _HasLicensePlateValidDigits(): boolean;
    function _IsValueNotNegative(): boolean;
  public
    constructor Create(id: string; Name: string; licensePlate: string;
      Value: currency; status: TVehicleStatus;
      VehicleExceptionsCreator: ITVehicleExceptionsCreator);

    constructor Create(VehicleDTO: TVehicleDTO;
      VehicleExceptionsCreator: ITVehicleExceptionsCreator); overload;

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

    function IsVehicleAvailable(): Boolean;
    function IsVehicleValid() : Boolean;

  end;

implementation

// private methods

function TVehicle._IsNameValid(): boolean;
var
  IsValid: boolean;
begin
  IsValid := _HasNameValidDigits();

  if not IsValid then
  begin
    _ExceptionsCreator.CreateVehicleNameError;
  end;

  Result := IsValid;
end;

function TVehicle._IsLicensePlateValid(): boolean;
var
  IsValid: boolean;
begin
  IsValid := _HasLicensePlateValidDigits();

  if not IsValid then
  begin
    _ExceptionsCreator.CreateVehicleLicensePlateError;
  end;

  Result := IsValid;
end;

function TVehicle._IsValueValid(): boolean;
var
  IsValid: boolean;
begin
  IsValid := _IsValueNotNegative();

  if not IsValid then
  begin
    _ExceptionsCreator.CreateVehicleValueError;
  end;

  Result := IsValid;
end;

function TVehicle._HasNameValidDigits(): boolean;
const
  minimumDigits = 3;
begin
  Result := (Length(_name) >= minimumDigits);
end;

function TVehicle._HasLicensePlateValidDigits(): boolean;
const
  minimumDigits = 6;
begin
  Result := (Length(_licensePlate) >= minimumDigits);
end;

function TVehicle._IsValueNotNegative(): boolean;
begin
  Result := _value >= 0;
end;

// public methods

constructor TVehicle.Create(id: string; Name: string; licensePlate: string;
  Value: currency; status: TVehicleStatus;
      VehicleExceptionsCreator: ITVehicleExceptionsCreator);
begin
  _id := id;
  _name := Name;
  _licensePlate := licensePlate;
  _value := Value;
  _status := status;

  _ExceptionsCreator := VehicleExceptionsCreator;
end;

constructor TVehicle.Create(VehicleDTO: TVehicleDTO;
      VehicleExceptionsCreator: ITVehicleExceptionsCreator);
begin
  _id := VehicleDTO.id;
  _name := VehicleDTO.Name;
  _licensePlate := VehicleDTO.licensePlate;
  _value := VehicleDTO.Value;
  _status := VehicleDTO.status;

  _ExceptionsCreator := VehicleExceptionsCreator;
end;

function TVehicle.IsVehicleAvailable(): Boolean;
begin
  if not IsVehicleStatusEqual(_status, TVehicleStatus.AVAILABLE) then
  begin
    _ExceptionsCreator.CreateVehicleNotAvailableError;
  end;

  Result := True;
end;

function TVehicle.IsVehicleValid(): Boolean;
begin
  Result := _IsNameValid() and _IsLicensePlateValid() and _IsValueValid();
end;

// getter and setter methods
function TVehicle.getId(): string;
begin
  Result := _id;
end;

function TVehicle.getName(): string;
begin
  Result := _name;
end;

procedure TVehicle.setName(name: string);
begin
  _name := name;
end;

function TVehicle.getLicensePlate(): string;
begin
  result := _licensePlate;
end;

procedure TVehicle.setLicensePlate(licensePlate: string);
begin
  _licensePlate := licensePlate;
end;

function TVehicle.getValue(): currency;
begin
  Result := _value;
end;

procedure TVehicle.setValue(value: currency);
begin
  _value := value;
end;

function TVehicle.getStatus(): TVehicleStatus;
begin
  Result := _status;
end;

procedure TVehicle.setStatus(status: TVehicleStatus);
begin
  _status := status;
end;

end.
