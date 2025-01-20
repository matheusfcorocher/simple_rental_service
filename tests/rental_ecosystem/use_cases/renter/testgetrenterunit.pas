unit TestGetRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, IRenterStorageUnit,
  RenterUnit, GetRenterUnit, FakeRenterStorageUnit, RegisterRenterUnit,
  RenterBuilderUnit, RenterExceptionsCreatorENUnit, RenterDTOUnit, RenterAuxFunctionsUnit;

type

  TTestGetRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestGetRenter.SetUp;
begin

end;

procedure TTestGetRenter.TearDown;
begin

end;

procedure TTestGetRenter.TestExecute;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  RenterBuilder: TRenterBuilder;
  RenterStorage: ITRenterStorage;
  RegisterRenter: TRegisterRenter;
  GetRenter: TGetRenter;
  RenterInfoDTO: TRenterInfoDTO;
  RenterDTO: TRenterDTO;
  Renter: TRenter;
  Expected: TRenter;
begin
  //prepare test
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);

  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);
  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  GetRenter := TGetRenter.Create(RenterStorage);

  with RenterInfoDTO do
  begin
    Name := 'Los';
    address := 'address';
    email := '12345678';
    telephone := '123456789';
  end;

  Renter := RegisterRenter.Execute(RenterInfoDTO);

  //Execute Test
  Expected := GetRenter.Execute(Renter.getId);

  AssertTrue(
    'When getting a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
    );
end;

initialization

  RegisterTest(TTestGetRenter);
end.
