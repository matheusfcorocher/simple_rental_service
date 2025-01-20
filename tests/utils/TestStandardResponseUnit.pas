unit TestStandardResponseUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Generics.Collections,
  fpcunit,
  testutils,
  testregistry,
  StandardResponsesUnit,
  SystemResponseUnit,
  RenterUnit,
  RentersUnit,
  RenterExceptionsCreatorENUnit,
  RentalServiceExceptionsUnit;

type

  TTestStandardResponseUnit = class(TTestCase)
  private
    _RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCreatingSuccessfulResponse;
    procedure TestCreatingInternalErrorResponse;
    procedure TestCreatingNotFoundResponse;
    procedure TestCreatingBadRequestResponse;
  end;

implementation

procedure TTestStandardResponseUnit.SetUp;
begin
 _RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
end;

procedure TTestStandardResponseUnit.TearDown;
begin

end;

//tests

procedure TTestStandardResponseUnit.TestCreatingSuccessfulResponse;
var
  Response: TSystemResponse;
  Expected: TSystemResponse;
  Renters: TRenters;
  ObjectList: specialize TObjectList<TObject>;
begin
  Renters := TRenters.Create;
  Renters.Add(TRenter.Create('uuid1', 'John Doe', 'street1',
    'johndoe@gmail.com', '12345677', _RenterExceptionsCreator));
  Renters.Add(TRenter.Create('uuid2', 'Marcus Doe', 'street2',
    'marcusdoe@gmail.com', '12345678', _RenterExceptionsCreator));
  Renters.Add(TRenter.Create('uuid3', 'Matthew Doe', 'street3',
    'matthewdoe@gmail.com', '12345679', _RenterExceptionsCreator));

  ObjectList := Renters.ToObjectList();

  Response := CreateSuccessfulResponse('', '', ObjectList);

  Expected := CreateSystemResponse(True, 200, '', '', ObjectList,
    default(TErrorDetail));

  AssertTrue(
    'When is created sucessful response, it retuns right response',
    AreSystemResponsesEquals(Expected, Response)
    );
end;

procedure TTestStandardResponseUnit.TestCreatingInternalErrorResponse;
var
  Response: TSystemResponse;
  Expected: TSystemResponse;
  Error: TErrorDetail;
begin
  Response := CreateInternalErrorResponse('', RentalEcosystem);

  Error := CreateErrorDetail(RentalEcosystem, 500, '');
  Expected := CreateSystemResponse(False, 500, 'Internal Server Error',
    'An unexpected error occurred. Please try again later.', nil, Error);

  AssertTrue(
    'When is created internal error response, it retuns right response',
    AreSystemResponsesEquals(Expected, Response)
    );
end;

procedure TTestStandardResponseUnit.TestCreatingNotFoundResponse;
var
  Response: TSystemResponse;
  Expected: TSystemResponse;
  Error: TErrorDetail;
begin
  Response := CreateNotFoundResponse('', RentalEcosystem);

  Error := CreateErrorDetail(RentalEcosystem, 404, '');
  Expected := CreateSystemResponse(False, 404, 'Not Found Error',
    'The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.',
    nil, Error);

  AssertTrue(
    'When is created not found error response, it retuns right response',
    AreSystemResponsesEquals(Expected, Response)
  );
end;

procedure TTestStandardResponseUnit.TestCreatingBadRequestResponse;
var
  Response: TSystemResponse;
  Expected: TSystemResponse;
  Error: TErrorDetail;
begin
  Response := CreateBadRequestResponse('', RentalEcosystem);

  Error := CreateErrorDetail(RentalEcosystem, 400, '');
  Expected := CreateSystemResponse(False, 400, 'Bad Request',
    'Your request was malformed or contains invalid parameters. Checks URL, parameters and headers.',
    nil, Error);

  AssertTrue(
    'When is created bad request response, it retuns right response',
    AreSystemResponsesEquals(Expected, Response)
    );
end;

initialization

  RegisterTest(TTestStandardResponseUnit);
end.
