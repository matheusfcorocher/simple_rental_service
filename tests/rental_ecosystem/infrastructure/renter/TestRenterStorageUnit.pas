unit TestRenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  fpcunit,
  testregistry,
  RenterUnit,
  RenterStorageUnit;

type
  TRenterStorageTest = class(TTestCase)
  private
    FRenterStorage: TRenterStorage;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegister;
    procedure TestUpdate;
    procedure TestGet;
    procedure TestDelete;
  end;

implementation

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
  Expected := FRenterStorage.Update(Renter);

  AssertTrue(
    'When updating a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
  );
end;

procedure TRenterStorageTest.TestGet;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  Renter := TRenter.Create('uid', 'test', 'test', '12345678', '123456789');
  Expected := FRenterStorage.Get(Renter.getId);

  AssertTrue(
    'When getting a renter, it retuns correct renter',
    RenterEquals(Renter, Expected)
  );
end;

procedure TRenterStorageTest.TestDelete;
var
  Expected: String;
begin
  Expected := FRenterStorage.Delete('uid');

  AssertEquals(
    'When deleting a renter, it retuns right message',
    'The renter has been successfully deleted from the system.',
    Expected
  );
end;

initialization
  RegisterTest(TRenterStorageTest);
end.
