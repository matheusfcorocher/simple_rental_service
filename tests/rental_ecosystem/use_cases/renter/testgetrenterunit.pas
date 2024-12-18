unit TestGetRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, IRenterStorageUnit,
  RenterUnit, GetRenterUnit, FakeRenterStorageUnit;

type

  TTestGetRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestGetRenter.TestExecute;
var
  RenterStorage: ITRenterStorage;
  GetRenter: TGetRenter;
  Renter: TRenter;
  Expected: TRenter;
begin
  Renter := TRenter.Create('uid', 'test', 'test', '12345678', '123456789');
  Expected := Renter;

  RenterStorage := TFakeRenterStorage.Create;
  GetRenter := TGetRenter.Create(RenterStorage);

  Renter := GetRenter.Execute(Renter.getId);

  AssertTrue(
    'When getting a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
    );
end;

procedure TTestGetRenter.SetUp;
begin

end;

procedure TTestGetRenter.TearDown;
begin

end;

initialization

  RegisterTest(TTestGetRenter);
end.
