unit TestRegisterRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, RegisterRenterUnit,
  FakeRenterStorageUnit, RenterUnit, IRenterStorageUnit;

type

  TTestRegisterRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterRenter.TestExecute;
var
  RenterStorage: ITRenterStorage;
  RegisterRenter: TRegisterRenter;
  Renter: TRenter;
  Expected: TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
  Expected := Renter;

  RenterStorage := TFakeRenterStorage.Create;
  RegisterRenter := TRegisterRenter.Create(RenterStorage);

  Renter := RegisterRenter.Execute(Renter);

  AssertTrue(
    'When executing RegisterRenter, it retuns correct renters',
    RenterEquals(Renter,Expected)
  );
end;

procedure TTestRegisterRenter.SetUp;
begin

end;

procedure TTestRegisterRenter.TearDown;
begin

end;

initialization

  RegisterTest(TTestRegisterRenter);
end.
