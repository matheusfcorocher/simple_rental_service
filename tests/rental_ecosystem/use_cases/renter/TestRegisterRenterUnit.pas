unit TestRegisterRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, RegisterRenterUnit,
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
  Renter : TRenter;
  RenterData: TRenterData;
  Expected: TRenter;
begin
  //Preparing test
  with RenterData do
  begin
    name := 'Los';
    address := 'address';
    email :=  '12345678';
    telephone :=  '123456789';
  end;

  RenterStorage := TFakeRenterStorage.Create;
  RegisterRenter := TRegisterRenter.Create(RenterStorage);

  //Execute Test
  Renter := RegisterRenter.Execute(RenterData);
  Expected := TRenter.Create(Renter.getId, 'Los', 'address', '12345678', '123456789');

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
