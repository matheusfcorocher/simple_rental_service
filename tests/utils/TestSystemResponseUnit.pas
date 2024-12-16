unit TestSystemResponseUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, SystemResponseUnit;

type

  TTestSystemResponse = class(TTestCase)
  published
    procedure TestCreateSystemResponse;
    procedure TestCreateErrorDetail;
    procedure TestAreSystemResponsesEquals;
    procedure TestAreErrorDetailsEquals;
  end;

implementation

procedure TTestSystemResponse.TestCreateSystemResponse;
var
  Expected: TSystemResponse;
  Response: TSystemResponse;
begin
     Expected.success := True;
     Expected.code := 200;
     Expected.title := '';
     Expected.message := '';
     Expected.data := nil;
     Expected.error := default(TErrorDetail);

     Response := CreateSystemResponse(True, 200, '', '', nil, default(TErrorDetail));

     AssertTrue(
      'When is created system response, it retuns right response',
      AreSystemResponsesEquals(Expected, Response)
    );
end;

procedure TTestSystemResponse.TestCreateErrorDetail;
var
  Expected: TErrorDetail;
  Error: TErrorDetail;
begin
  Expected.code := 200;
  Expected.domain := Infrastructure;
  Expected.message := '';

  Error := CreateErrorDetail(Infrastructure, 200, '');

  AssertTrue(
     'When is created error detail, it retuns right error',
     AreErrorDetailsEquals(Expected, Error)
  );
end;

procedure TTestSystemResponse.TestAreSystemResponsesEquals;
var
  ResponseA: TSystemResponse;
  ErrorA: TErrorDetail;
  ResponseB: TSystemResponse;
  ErrorB: TErrorDetail;
begin
  ErrorA := CreateErrorDetail(Infrastructure, 200, '');
  ErrorB := CreateErrorDetail(Infrastructure, 200, '');

  ResponseA := CreateSystemResponse(True, 200, '', '', nil, ErrorA);
  ResponseB := CreateSystemResponse(True, 200, '', '', nil, ErrorB);

  AssertTrue(
     'When compares if two system responses are equal, it retuns true',
     AreSystemResponsesEquals(ResponseA, ResponseB)
  );
end;

procedure TTestSystemResponse.TestAreErrorDetailsEquals;
var
  ErrorA: TErrorDetail;
  ErrorB: TErrorDetail;
begin
  ErrorA := CreateErrorDetail(Infrastructure, 200, '');
  ErrorB := CreateErrorDetail(Infrastructure, 200, '');

  AssertTrue(
     'When compares if two error details are equal, it retuns true',
     AreErrorDetailsEquals(ErrorA, ErrorB)
  );
end;

initialization

  RegisterTest(TTestSystemResponse);
end.

