unit TestRenterStorageUnit;

{$mode objfpc}{$H+}

interface

uses
  fpcunit,
  testregistry,
  RenterUnit,
  RenterDTOUnit,
  SystemResponseUnit,
  RenterStorageUnit;

type
  TRenterStorageTest = class(TTestCase)
  private
    FRenterStorage: TRenterStorage;
    FRenter: TRenter;
    FRenterDTO: TRenterDTO;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegister;
    procedure TestEdit;
    procedure TestCheck;
    procedure TestDelete;
  end;

implementation

procedure TRenterStorageTest.SetUp;
begin
  FRenterStorage := TRenterStorage.Create;
  FRenter := TRenter.Create('a', 'a', 'a', 'a', 'a');
  FRenterDTO := CreateRenterDTO('a', 'a', 'a', 'a', 'a');
  // Set up initial conditions for testing
end;

procedure TRenterStorageTest.TearDown;
begin
  FRenterStorage.Free;
  FRenter.Free;
  // Clean up after tests
end;

procedure TRenterStorageTest.TestRegister;
var
  Response: TSystemResponse;
begin
  Response := FRenterStorage.Register(FRenter);
  AssertEquals('Registration should succeed', True, Response.success);
end;

procedure TRenterStorageTest.TestEdit;
var
  Response: TSystemResponse;
begin
  Response := FRenterStorage.edit(FRenter);
  AssertEquals('Editing should succeed', True, Response.success);
end;

procedure TRenterStorageTest.TestCheck;
var
  Response: TSystemResponse;
begin
  Response := FRenterStorage.check(FRenterDTO);
  AssertEquals('Check should succeed', True, Response.success);
end;

procedure TRenterStorageTest.TestDelete;
var
  Response: TSystemResponse;
begin
  Response := FRenterStorage.Delete('some-id');
  AssertEquals('Deletion should succeed', True, Response.success);
end;

initialization
  RegisterTest(TRenterStorageTest);
end.
