unit TestGetRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, IRenterStorageUnit,
  RenterUnit, GetRenterUnit, FakeRenterStorageUnit, RegisterRenterUnit;

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
  RegisterRenter: TRegisterRenter;
  GetRenter: TGetRenter;
  RenterData: TRenterData;
  Renter: TRenter;
  Expected: TRenter;
begin
  //prepare test
  RenterStorage := TFakeRenterStorage.Create;
  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  GetRenter := TGetRenter.Create(RenterStorage);

  with RenterData do
  begin
    name := 'Los';
    address := 'address';
    email :=  '12345678';
    telephone :=  '123456789';
  end;

  Renter := RegisterRenter.Execute(RenterData);

  //Execute Test
  Expected := GetRenter.Execute(Renter.getId);

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
