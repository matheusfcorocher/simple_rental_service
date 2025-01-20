unit TestRegisterRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, RegisterRenterUnit,
  FakeRenterStorageUnit, RenterUnit, IRenterStorageUnit, RenterDTOUnit,
  RenterExceptionsCreatorENUnit, RenterBuilderUnit, RenterAuxFunctionsUnit;

type

  TTestRegisterRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestRegisterRenter.SetUp;
begin

end;

procedure TTestRegisterRenter.TearDown;
begin

end;

procedure TTestRegisterRenter.TestExecute;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  RenterBuilder: TRenterBuilder;
  RenterStorage: ITRenterStorage;
  RegisterRenter: TRegisterRenter;
  Renter: TRenter;
  RenterInfoDTO: TRenterInfoDTO;
  Expected: TRenter;
begin
  //Preparing test
  with RenterInfoDTO do
  begin
    Name := 'Los';
    address := 'address';
    email := '12345678';
    telephone := '123456789';
  end;

  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);

  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);
  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);

  //Execute Test
  Renter := RegisterRenter.Execute(RenterInfoDTO);
  Expected := TRenter.Create(Renter.getId, 'Los', 'address', '12345678',
    '123456789', RenterExceptionsCreator);

  AssertTrue(
    'When executing RegisterRenter, it retuns correct renters',
    RenterEquals(Renter, Expected)
    );
end;

initialization

  RegisterTest(TTestRegisterRenter);
end.
