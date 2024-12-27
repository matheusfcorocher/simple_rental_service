unit TestRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Generics.Collections, fpcunit, testutils,
  testregistry, RenterUnit, RenterDTOUnit, RenterExceptionsUnit;

type

  { TTestCaseRenter }

  TTestCaseRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  private
    procedure _CreatingInvalidName;
    procedure _CreatingInvalidAddress;
    procedure _CreatingInvalidEmail;
    procedure _CreatingInvalidTelephone;

    procedure _CreatingInvalidNameDTO;
    procedure _CreatingInvalidAddressDTO;
    procedure _CreatingInvalidEmailDTO;
    procedure _CreatingInvalidTelephoneDTO;

    procedure _UpdatingWithInvalidName;
    procedure _UpdatingWithInvalidAddress;
    procedure _UpdatingWithInvalidEmail;
    procedure _UpdatingWithInvalidTelephone;
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
begin
  AssertException(
   'When is given a renter with invalid name, it retuns exception',
   RenterNameException,
   @_CreatingInvalidName
  );

  AssertException(
   'When is given a renter with invalid address, it retuns exception',
   RenterAddressException,
   @_CreatingInvalidAddress
  );

  AssertException(
   'When is given a renter with invalid email, it retuns exception',
   RenterEmailException,
   @_CreatingInvalidEmail
  );

  AssertException(
   'When is given a renter with invalid telephone, it retuns exception',
   RenterTelephoneException,
   @_CreatingInvalidTelephone
  );
end;

procedure TTestCaseRenter.CreatingRenterWithDTOAndInvalidData;
begin
  AssertException(
   'When is given a RenterDTO with invalid name, it retuns exception',
   RenterNameException,
   @_CreatingInvalidNameDTO
  );

  AssertException(
   'When is given a RenterDTO with invalid address, it retuns exception',
   RenterAddressException,
   @_CreatingInvalidAddressDTO
  );

  AssertException(
   'When is given a RenterDTO with invalid email, it retuns exception',
   RenterEmailException,
   @_CreatingInvalidEmailDTO
  );

  AssertException(
   'When is given a RenterDTO with invalid telephone, it retuns exception',
   RenterTelephoneException,
   @_CreatingInvalidTelephoneDTO
  );
end;

procedure TTestCaseRenter.UpdatingRenterNameWithInvalidData;
begin
  AssertException(
   'When updating name of renter with invalid data, it throws Exception',
   RenterNameException,
   @_UpdatingWithInvalidName
  );
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
begin
  AssertException(
   'When updating address of renter with invalid data, it throws Exception',
   RenterAddressException,
   @_UpdatingWithInvalidAddress
  );
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
begin
  AssertException(
   'When updating email of renter with invalid data, it throws Exception',
   RenterEmailException,
   @_UpdatingWithInvalidEmail
  );
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
begin
  AssertException(
   'When updating telephone of renter with invalid data, it throws Exception',
   RenterTelephoneException,
   @_UpdatingWithInvalidTelephone
  );
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

procedure TTestCaseRenter._CreatingInvalidName;
begin
  TRenter.Create('id', '', 'address', 'email', '123456789');
end;

procedure TTestCaseRenter._CreatingInvalidAddress;
begin
  TRenter.Create('id', 'asda', '', 'email', '123456789');
end;

procedure TTestCaseRenter._CreatingInvalidEmail;
begin
  TRenter.Create('id', 'asda', 'address', '', '123456789');
end;

procedure TTestCaseRenter._CreatingInvalidTelephone;
begin
  TRenter.Create('id', 'asda', 'address', 'email', '123');
end;

procedure TTestCaseRenter._CreatingInvalidNameDTO;
var
  RenterDTO: TRenterDTO;
begin
  RenterDTO := CreateRenterDTO('id', 'a', 'address', 'email', '123456789');
  TRenter.Create(RenterDTO);
end;

procedure TTestCaseRenter._CreatingInvalidAddressDTO;
var
  RenterDTO: TRenterDTO;
begin
  RenterDTO := CreateRenterDTO('id', 'asda', '', 'email', '123456789');
  TRenter.Create(RenterDTO);
end;

procedure TTestCaseRenter._CreatingInvalidEmailDTO;
var
  RenterDTO: TRenterDTO;
begin
  RenterDTO := CreateRenterDTO('id', 'asda', 'address', '', '123456789');
  TRenter.Create(RenterDTO);
end;

procedure TTestCaseRenter._CreatingInvalidTelephoneDTO;
var
  RenterDTO: TRenterDTO;
begin
  RenterDTO := CreateRenterDTO('id', 'asda', 'address', 'email', '123');
  TRenter.Create(RenterDTO);
end;

procedure TTestCaseRenter._UpdatingWithInvalidName;
var
  Renter : TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', 'email', '123456789');
  Renter.setName('a');
end;

procedure TTestCaseRenter._UpdatingWithInvalidAddress;
var
  Renter : TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', 'email', '123456789');
  Renter.setAddress('');
end;

procedure TTestCaseRenter._UpdatingWithInvalidEmail;
var
  Renter : TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'address', 'email', '123456789');
  Renter.setEmail('');
end;

procedure TTestCaseRenter._UpdatingWithInvalidTelephone;
var
  Renter : TRenter;
begin
  Renter := TRenter.Create('uid', 'Los', 'a', 'email', '123456789');
  Renter.setTelephone('');
end;

initialization

  RegisterTest(TTestCaseRenter);
end.
