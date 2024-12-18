unit TestRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, fpcunit, testutils,
  testregistry, RenterUnit, RenterDTOUnit;

type

  TTestCaseRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure CreatingRenterWithValidData;
    procedure CreatingRenterWithInvalidData;

    procedure CreatingRenterWithDTOAndValidData;
    procedure CreatingRenterWithDTOAndInvalidData;

    procedure UpdatingRenterNameWithInvalidData;
    procedure UpdatingRenterNameWithValidData;

    procedure UpdatingRenterAddressWithInvalidData;
    procedure UpdatingRenterAddressWithValidData;

    procedure UpdatingRenterEmailWithInvalidData;
    procedure UpdatingRenterEmailWithValidData;

    procedure UpdatingRenterTelephoneWithInvalidData;
    procedure UpdatingRenterTelephoneWithValidData;

    procedure TransformingRentersToObjectList;
    procedure TestRenterEquals;
  end;


implementation

procedure TTestCaseRenter.CreatingRenterWithValidData;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
    Expected := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
    AssertTrue(
      'When is given a renter with valid data, it retuns renter instance',
      RenterEquals(Expected, Renter)
      );
  finally
    Renter.Free;
    Expected.Free;
  end;
end;

procedure TTestCaseRenter.CreatingRenterWithDTOAndValidData;
var
  RenterDTO: TRenterDTO;
  Renter: TRenter;
  Expected: TRenter;
begin
  try
    RenterDTO := CreateRenterDTO('uid', 'Los', 'a', '12345678', '123456789');
    Renter := TRenter.Create(RenterDTO);
    Expected := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');

    AssertTrue(
      'When is given a renter with valid data, it retuns renter instance',
      RenterEquals(Expected, Renter)
      );
  finally
    Renter.Free;
    Expected.Free;
  end;
end;

procedure TTestCaseRenter.CreatingRenterWithInvalidData;
const
  Expected = 'Name isnt valid. Checks if name isnt empty and have digits between 2 and 50.';
var
  Renter: TRenter;
begin
  try
    Renter := TRenter.Create('a', 'a', 'a', 'a', 'a');
  except
    on E: Exception do
      AssertEquals(
        'When is given a renter with invalid data, it retuns renter instance',
        Expected,
        E.Message
        );
  end;
  try
  finally
    Renter.Free;
  end;
end;

procedure TTestCaseRenter.CreatingRenterWithDTOAndInvalidData;
const
  Expected = 'Name isnt valid. Checks if name isnt empty and have digits between 2 and 50.';
var
  RenterDTO: TRenterDTO;
  Renter: TRenter;
begin
  try
    RenterDTO := CreateRenterDTO('a', 'a', 'a', 'a', 'a');
    Renter := TRenter.Create(RenterDTO);
  except
    on E: Exception do
      AssertEquals(
        'When is given a renter with invalid data, it retuns renter instance',
        Expected,
        E.Message
        );
  end;
  try
  finally
    Renter.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterNameWithInvalidData;
const
  Expected = 'Name isnt valid. Checks if name isnt empty and have digits between 2 and 50.';
var
  Renter: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
    Renter.setName('a');
  except
    on E: Exception do
      AssertEquals(
        'When updating name of renter with invalid data, it throws Exception',
        Expected,
        E.Message
        );
  end;
  try
  finally
    Renter.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterNameWithValidData;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Losdd', 'a', '12345678', '123456789');
    Renter.setName('Losa');
    Expected := TRenter.Create('uid', 'Losa', 'a', '12345678', '123456789');

    AssertTrue(
      'When is given a renter with valid data, it retuns renter instance',
      RenterEquals(Expected, Renter)
      );
  finally
    Renter.Free;
    Expected.Free;
  end;
end;


procedure TTestCaseRenter.UpdatingRenterAddressWithInvalidData;
const
  Expected = 'Address isnt valid. Checks if address isnt empty.';
var
  Renter: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
    Renter.setAddress('');
  except
    on E: Exception do
      AssertEquals(
        'When updating address of renter with invalid data, it throws Exception',
        Expected,
        E.Message
        );
  end;
  try
  finally
    Renter.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterAddressWithValidData;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Loss', 'address', '12345678', '123456789');
    Renter.setAddress('address2');
    Expected := TRenter.Create('uid', 'Loss', 'address2', '12345678', '123456789');

    AssertTrue(
      'When updating address of renter with valid data, it retuns renter instance',
      RenterEquals(Expected, Renter)
      );
  finally
    Renter.Free;
    Expected.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterEmailWithInvalidData;
const
  Expected = 'Email isnt valid. Checks if email isnt empty.';
var
  Renter: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Los', 'email', '12345678', '123456789');
    Renter.setEmail('');
  except
    on E: Exception do
      AssertEquals(
        'When updating email of renter with invalid data, it throws Exception',
        Expected,
        E.Message
        );
  end;
  try
  finally
    Renter.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterEmailWithValidData;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Loss', 'address', 'email', '123456789');
    Renter.setEmail('email2');
    Expected := TRenter.Create('uid', 'Loss', 'address', 'email2', '123456789');

    AssertTrue(
      'When updating address of renter with valid data, it retuns renter instance',
      RenterEquals(Expected, Renter)
      );
  finally
    Renter.Free;
    Expected.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterTelephoneWithInvalidData;
const
  Expected =
    'Telephone isnt valid.Checks if telephone isnt empty and have digits between 2 and 50.';
var
  Renter: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Los', 'email', '12345678', '123456789');
    Renter.setTelephone('');
  except
    on E: Exception do
      AssertEquals(
        'When updating telephone of renter with invalid data, it throws Exception',
        Expected,
        E.Message
        );
  end;
  try
  finally
    Renter.Free;
  end;
end;

procedure TTestCaseRenter.UpdatingRenterTelephoneWithValidData;
var
  Renter: TRenter;
  Expected: TRenter;
begin
  try
    Renter := TRenter.Create('uid', 'Loss', 'address', 'email', '123456789');
    Renter.setTelephone('123456779');
    Expected := TRenter.Create('uid', 'Loss', 'address', 'email', '123456779');

    AssertTrue(
      'When updating telephone of renter with valid data, it retuns renter instance',
      RenterEquals(Expected, Renter)
      );
  finally
    Renter.Free;
    Expected.Free;
  end;
end;

procedure TTestCaseRenter.TransformingRentersToObjectList;
var
  Renters: TRenters;
  ObjectList: specialize TObjectList<TObject>;
begin
  Renters := TRenters.Create;
  Renters.Add(TRenter.Create('uuid1', 'John Doe', 'street1',
    'johndoe@gmail.com', '12345677'));
  Renters.Add(TRenter.Create('uuid2', 'Marcus Doe', 'street2',
    'marcusdoe@gmail.com', '12345678'));
  Renters.Add(TRenter.Create('uuid3', 'Matthew Doe', 'street3',
    'matthewdoe@gmail.com', '12345679'));

  ObjectList := Renters.ToObjectList();

  AssertEquals(
    'When is transform renters to object, it retuns right object',
    ObjectList.Count, Renters.Count);
end;

procedure TTestCaseRenter.TestRenterEquals;
var
  Renter_A: TRenter;
  Renter_B: TRenter;
begin
  try
    Renter_A := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');
    Renter_B := TRenter.Create('uid', 'Los', 'a', '12345678', '123456789');

    AssertTrue(
      'When is given two renters with same data, it retuns true',
      RenterEquals(Renter_A, Renter_B)
    );
  finally
    Renter_A.Free;
    Renter_B.Free;
  end;
end;

procedure TTestCaseRenter.SetUp;
begin

end;

procedure TTestCaseRenter.TearDown;
begin

end;

initialization

  RegisterTest(TTestCaseRenter);
end.
