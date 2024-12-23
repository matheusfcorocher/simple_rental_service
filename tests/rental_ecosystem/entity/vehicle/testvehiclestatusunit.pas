unit TestVehicleStatusUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, VehicleStatusUnit;

type

  TTestVehicleStatus= class(TTestCase)
  published
    procedure TestIsVehicleStatusEqual;
  end;

implementation

procedure TTestVehicleStatus.TestIsVehicleStatusEqual;
var
  Expected : TVehicleStatus;
  Status: TVehicleStatus;
begin
  Expected := AVAILABLE;
  Status := AVAILABLE;
  AssertTrue(
      'When comparing two equal vehicle status, it retuns true',
      IsVehicleStatusEqual(Expected, Status)
  );
end;

initialization

  RegisterTest(TTestVehicleStatus);
end.

