unit TestDeleteRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, IRenterStorageUnit,
  DeleteRenterUnit, RenterUnit, FakeRenterStorageUnit, RegisterRenterUnit,
  RenterExceptionsCreatorENUnit, RenterBuilderUnit, RenterDTOUnit;

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
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  RenterBuilder: TRenterBuilder;
  RenterStorage: ITRenterStorage;
  RegisterRenter: TRegisterRenter;
  DeleteRenter: TDeleteRenter;
  RenterInfoDTO: TRenterInfoDTO;
  RenterDTO: TRenterDTO;
  Renter: TRenter;
  Expected: string;
begin
  //prepare test
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);

  RenterStorage := TFakeRenterStorage.Create(RenterExceptionsCreator);
  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  with RenterInfoDTO do
  begin
    Name := 'Los';
    address := 'address';
    email := '12345678';
    telephone := '123456789';
  end;

  Renter := RegisterRenter.Execute(RenterInfoDTO);

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
