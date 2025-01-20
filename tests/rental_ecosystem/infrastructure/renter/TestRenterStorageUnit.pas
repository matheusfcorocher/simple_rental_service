unit TestRenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  fpcunit,
  testregistry,
  RenterUnit,
  RenterStorageUnit,
  RenterExceptionsCreatorENUnit,
  RenterBuilderUnit,
  RenterAuxFunctionsUnit,
  RentalServiceExceptionsUnit;

type

  { TRenterStorageTest }

  TRenterStorageTest = class(TTestCase)
  private
    _RenterStorage : TRenterStorage;
    _RenterBuilder : TRenterBuilder;

    procedure _CreatingNotFoundRenterGet;
    procedure _CreatingNotFoundRenterUpdate;
    procedure _CreatingNotFoundRenterDelete;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegister;

    procedure TestUpdate;
    procedure TestInvalidUpdate;

    procedure TestGet;
    procedure TestInvalidGet;

    procedure TestDelete;
    procedure TestInvalidDelete;
  end;

implementation

procedure TRenterStorageTest.SetUp;
var
  RenterExceptionsCreator : TRenterExceptionsCreatorEN;
begin
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;

  _RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);
  _RenterStorage := TRenterStorage.Create(RenterExceptionsCreator);
end;

procedure TRenterStorageTest.TearDown;
begin

end;

procedure TRenterStorageTest._CreatingNotFoundRenterGet;
begin
  _RenterStorage.Get('uid');
end;

procedure TRenterStorageTest._CreatingNotFoundRenterUpdate;
var
  Renter : TRenter;
begin
  Renter := _RenterBuilder.Build('uid', 'Los', 'a', '12345678', '123456789');
  _RenterStorage.Update(Renter);
end;

procedure TRenterStorageTest._CreatingNotFoundRenterDelete;
var
  Renter : TRenter;
begin
  Renter := _RenterBuilder.Build('uid', 'Los', 'a', '12345678', '123456789');
  _RenterStorage.Delete(Renter.getId);
end;

procedure TRenterStorageTest.TestRegister;
var
  Renter : TRenter;
  Expected: TRenter;
begin
  Renter := _RenterBuilder.Build('uid', 'Los', 'a', '12345678', '123456789');
  Expected := _RenterStorage.Register(Renter);

  AssertTrue(
    'When testing Register of StorageTest, it retuns correct renter',
    RenterEquals(Renter, Expected)
  );
end;

procedure TRenterStorageTest.TestUpdate;
var
  Renter : TRenter;
  Expected : TRenter;
begin
  Renter := _RenterBuilder.Build('uid', 'Los', 'a', '12345678', '123456789');
  _RenterStorage.Register(Renter);
  Expected := _RenterStorage.Update(Renter);

  AssertTrue(
    'When updating a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
  );
end;

procedure TRenterStorageTest.TestInvalidUpdate;
begin
  AssertException(
   'When trying to update the id of renter that doesnt exist, return exception',
   NotFoundRenterException,
   @_CreatingNotFoundRenterUpdate
  );
end;

procedure TRenterStorageTest.TestGet;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  Renter := _RenterBuilder.Build('uid', 'test', 'test', '12345678', '123456789');
  _RenterStorage.Register(Renter);
  Expected := _RenterStorage.Get(Renter.getId);

  AssertTrue(
    'When getting a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
  );
end;

procedure TRenterStorageTest.TestInvalidGet;
begin
  AssertException(
   'When trying to get the id of renter that doesnt exist, return exception',
   NotFoundRenterException,
   @_CreatingNotFoundRenterGet
  );
end;

procedure TRenterStorageTest.TestDelete;
var
  Renter: TRenter;
  Expected: String;
begin
  Renter := _RenterBuilder.Build('uid', 'test', 'test', '12345678', '123456789');
  _RenterStorage.Register(Renter);
  Expected := _RenterStorage.Delete('uid');

  AssertEquals(
    'When deleting a renter, it retuns right message',
    'The renter has been successfully deleted from the system.',
    Expected
  );
end;

procedure TRenterStorageTest.TestInvalidDelete;
begin
  AssertException(
   'When trying to delete renter that doesnt exist, return exception',
   NotFoundRenterException,
   @_CreatingNotFoundRenterDelete
  );
end;

initialization
  RegisterTest(TRenterStorageTest);
end.
