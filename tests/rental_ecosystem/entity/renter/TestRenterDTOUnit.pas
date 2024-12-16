unit TestRenterDTOUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, RenterDTOUnit;

type

  TTestCaseRenterDTO = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCreateRenterDTO;
    procedure TestAreRenterDTOsEquals;
  end;

implementation

procedure TTestCaseRenterDTO.TestCreateRenterDTO;
var
  RenterDTO_A: TRenterDTO;
  RenterDTO_B: TRenterDTO;
begin
  RenterDTO_A := CreateRenterDTO('uid', 'Loss', 'address', 'email', '123456789');
  RenterDTO_B.id := 'uid';
  RenterDTO_B.name := 'Loss';
  RenterDTO_B.address := 'address';
  RenterDTO_B.email := 'email';
  RenterDTO_B.telephone := '123456789';

  AssertTrue(
    'When creating a RenterDTO with function, it retuns correct RenterDTO',
    AreRenterDTOsEquals(RenterDTO_A, RenterDTO_B)
    );
end;

procedure TTestCaseRenterDTO.TestAreRenterDTOsEquals;
var
  RenterDTO_A: TRenterDTO;
  RenterDTO_B: TRenterDTO;
begin
  RenterDTO_A := CreateRenterDTO('uid', 'Loss', 'address', 'email', '123456789');
  RenterDTO_B := CreateRenterDTO('uid', 'Loss', 'address', 'email', '123456789');

  AssertTrue(
    'When comparing equal RenterDTOs, it retuns true',
    AreRenterDTOsEquals(RenterDTO_A, RenterDTO_B)
    );
end;

procedure TTestCaseRenterDTO.SetUp;
begin

end;

procedure TTestCaseRenterDTO.TearDown;
begin

end;

initialization

  RegisterTest(TTestCaseRenterDTO);
end.
