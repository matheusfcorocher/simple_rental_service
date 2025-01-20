unit TestUpdateRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, UpdateRenterUnit,
  FakeRenterStorageUnit, RenterUnit, IRenterStorageUnit, RegisterRenterUnit,
  RenterDTOUnit, RenterExceptionsCreatorENUnit, RenterBuilderUnit, RenterAuxFunctionsUnit;

type

  TTestUpdateRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation


procedure TTestUpdateRenter.SetUp;
begin

end;

procedure TTestUpdateRenter.TearDown;
begin

end;

procedure TTestUpdateRenter.TestExecute;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  RenterBuilder : TRenterBuilder;
  RenterStorage: ITRenterStorage;

  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;

  RenterInfoDTO: TRenterInfoDTO;
  RenterDTO : TRenterDTO;

  Renter: TRenter;
  Expected: TRenter;
begin
  //prepare test
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);

  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);
  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  UpdateRenter := TUpdateRenter.Create(RenterStorage, RenterBuilder);

  with RenterInfoDTO do
  begin
    Name := 'Los';
    address := 'address';
    email := '12345678';
    telephone := '123456789';
  end;

  Renter := RegisterRenter.Execute(RenterInfoDTO);

  with RenterDTO do
  begin
    id := Renter.getId;
    name := 'Bob';
    address := Renter.getAddress;
    email := Renter.getEmail;
    telephone := Renter.getTelephone;
  end;

  Renter.setName('Bob');

  Expected := TRenter.Create(Renter.getId, Renter.getName, Renter.getAddress, Renter.getEmail, Renter.getTelephone, RenterExceptionsCreator);

  //Execute Test
  Renter := UpdateRenter.Execute(RenterDTO);

  AssertTrue(
    'When updating a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
    );
end;

initialization

  RegisterTest(TTestUpdateRenter);
end.
