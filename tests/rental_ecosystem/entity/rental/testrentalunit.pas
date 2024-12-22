unit TestRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  TTestRental= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestHookUp;
  end;

implementation

procedure TTestRental.TestHookUp;
begin
  Fail('Write your own test');
end;

procedure TTestRental.SetUp;
begin

end;

procedure TTestRental.TearDown;
begin

end;

initialization

  RegisterTest(TTestRental);
end.

