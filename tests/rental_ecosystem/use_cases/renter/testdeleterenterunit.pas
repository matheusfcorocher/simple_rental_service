unit TestDeleteRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, IRenterStorageUnit,
  DeleteRenterUnit, RenterUnit, FakeRenterStorageUnit, RegisterRenterUnit;

type

  TTestDeleteRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestDeleteRenter.TestExecute;
var
  RenterStorage: ITRenterStorage;
  RegisterRenter: TRegisterRenter;
  DeleteRenter: TDeleteRenter;
  RenterData: TRenterData;
  Renter: TRenter;
  Expected: string;
begin
  //prepare test
  RenterStorage := TFakeRenterStorage.Create;
  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  with RenterData do
  begin
    name := 'Los';
    address := 'address';
    email :=  '12345678';
    telephone :=  '123456789';
  end;

  Renter := RegisterRenter.Execute(RenterData);

  //Execute Test
  Expected := DeleteRenter.Execute(Renter.getId);

  AssertEquals(
    'When deleting a renter, it retuns right message',
    'The renter has been successfully deleted from the system.',
    Expected
  );
end;

procedure TTestDeleteRenter.SetUp;
begin

end;

procedure TTestDeleteRenter.TearDown;
begin

end;

initialization

  RegisterTest(TTestDeleteRenter);
end.
