unit StandardResponsesUnit;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  Generics.Collections,
  SystemResponseUnit;

function CreateSuccessfulResponse(title: string; message: string;
  Data: Pointer): TSystemResponse;
function CreateInternalErrorResponse(errorMessage: string;
  domain: TErrorDomain): TSystemResponse;
function CreateNotFoundResponse(errorMessage: string;
  domain: TErrorDomain): TSystemResponse;
function CreateBadRequestResponse(errorMessage: string;
  domain: TErrorDomain): TSystemResponse;

implementation

function CreateSuccessfulResponse(title: string; message: string;
  data: Pointer): TSystemResponse;
var
  Response: TSystemResponse;
begin
  Result := CreateSystemResponse(True, 200, title, message, data,
    default(TErrorDetail));
end;

function CreateInternalErrorResponse(errorMessage: string;
  domain: TErrorDomain): TSystemResponse;
var
  Error: TErrorDetail;
begin
  Error := CreateErrorDetail(domain, 500, errorMessage);
  Result := CreateSystemResponse(False, 500, 'Internal Server Error',
    'An unexpected error occurred. Please try again later.', nil, error);
end;

function CreateNotFoundResponse(errorMessage: string;
  domain: TErrorDomain): TSystemResponse;
var
  Error: TErrorDetail;
begin
  Error := CreateErrorDetail(domain, 404, errorMessage);
  Result := CreateSystemResponse(False, 404, 'Not Found Error',
    'The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.',
    nil, error);
end;

function CreateBadRequestResponse(errorMessage: string;
  domain: TErrorDomain): TSystemResponse;
var
  Error: TErrorDetail;
begin
  Error := CreateErrorDetail(domain, 400, errorMessage);
  Result := CreateSystemResponse(False, 400, 'Bad Request',
    'Your request was malformed or contains invalid parameters. Checks URL, parameters and headers.',
    nil, error);
end;

end.
