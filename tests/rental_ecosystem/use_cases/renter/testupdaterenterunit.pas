unit TestUpdateRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, UpdateRenterUnit,
  FakeRenterStorageUnit, RenterUnit, IRenterStorageUnit, RegisterRenterUnit;

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
  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  RenterData: TRenterData;
  Renter: TRenter;
  Expected: TRenter;
begin
  //prepare test
  RenterStorage := TFakeRenterStorage.Create;
  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage);

  with RenterData do
  begin
    name := 'Los';
    address := 'address';
    email :=  '12345678';
    telephone :=  '123456789';
  end;

  Renter := RegisterRenter.Execute(RenterData);
  Renter.setName('Bob');
  Expected := Renter;

  //Execute Test
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

