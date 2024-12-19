unit TestUpdateRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, UpdateRenterUnit,
  FakeRenterStorageUnit, RenterUnit, IRenterStorageUnit;

type

  TTestUpdateRenter= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestUpdateRenter.TestExecute;
var
  RenterStorage: ITRenterStorage;
  UpdateRenter: TUpdateRenter;
  Renter: TRenter;
  Expected: TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
  Expected := Renter;

  RenterStorage := TFakeRenterStorage.Create;
  UpdateRenter := TUpdateRenter.Create(RenterStorage);

  Renter := UpdateRenter.Execute(Renter);

  AssertTrue(
    'When updating a renter, it retuns correct renter',
    RenterEquals(Renter,Expected)
  );
end;

procedure TTestUpdateRenter.SetUp;
begin

end;

procedure TTestUpdateRenter.TearDown;
begin

end;

initialization

  RegisterTest(TTestUpdateRenter);
end.

