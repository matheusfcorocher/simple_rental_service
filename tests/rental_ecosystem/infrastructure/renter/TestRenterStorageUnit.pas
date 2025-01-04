unit TestRenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  fpcunit,
  testregistry,
  RenterUnit,
  RenterStorageUnit,
  RenterExceptionsUnit;

type

  { TRenterStorageTest }

  TRenterStorageTest = class(TTestCase)
  private
    FRenterStorage: TRenterStorage;

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

procedure TRenterStorageTest._CreatingNotFoundRenterGet;
begin
  FRenterStorage.Get('uid');
end;

procedure TRenterStorageTest._CreatingNotFoundRenterUpdate;
var
  Renter : TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
  FRenterStorage.Update(Renter);
end;

procedure TRenterStorageTest._CreatingNotFoundRenterDelete;
var
  Renter : TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
  FRenterStorage.Delete(Renter.getId);
end;

procedure TRenterStorageTest.SetUp;
begin
  FRenterStorage := TRenterStorage.Create;
end;

procedure TRenterStorageTest.TearDown;
begin
  FRenterStorage.Free;
end;

procedure TRenterStorageTest.TestRegister;
var
  Renter : TRenter;
  Expected: TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
  Expected := FRenterStorage.Register(Renter);

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
  Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
  FRenterStorage.Register(Renter);
  Expected := FRenterStorage.Update(Renter);

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
  Renter := TRenter.Create('uid', 'test', 'test', '12345678', '123456789');
  FRenterStorage.Register(Renter);
  Expected := FRenterStorage.Get(Renter.getId);

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
  Renter := TRenter.Create('uid', 'test', 'test', '12345678', '123456789');
  FRenterStorage.Register(Renter);
  Expected := FRenterStorage.Delete('uid');

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
