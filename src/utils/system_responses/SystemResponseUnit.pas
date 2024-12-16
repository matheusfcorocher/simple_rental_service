unit SystemResponseUnit;

{$mode objfpc}{$H+}

interface

uses Generics.Collections, SysUtils; 

type
  TErrorDomain = (RentalEcosystem, Application, Infrastructure);

  TErrorDetail = record 
    domain: TErrorDomain;
    code: Integer;
    message: String;
  end;

  TSystemResponse = record
    success: boolean;
    code: integer;
    title: string;
    message: string;
    data: specialize TObjectList<TObject>;
    error: TErrorDetail;  
  end;

function CreateSystemResponse(
         success: boolean;
         code: integer;
         title: string;
         message: string;
         data: specialize TObjectList<TObject>;
         error: TErrorDetail
): TSystemResponse;
function CreateErrorDetail(
         domain: TErrorDomain;
         code: Integer;
         message: String
         ) : TErrorDetail;
function AreSystemResponsesEquals(a, b: TSystemResponse): Boolean;
function AreErrorDetailsEquals(a, b: TErrorDetail): Boolean;

implementation

function CreateSystemResponse(
         success: boolean;
         code: integer;
         title: string;
         message: string;
         data: specialize TObjectList<TObject>;
         error: TErrorDetail
): TSystemResponse;
var
  SystemResponse : TSystemResponse;
begin
    SystemResponse.success := success;
    SystemResponse.code := code;
    SystemResponse.title := title;
    SystemResponse.message := message;
    SystemResponse.data := data;
    SystemResponse.error := error;

    Result := SystemResponse;
end;

function CreateErrorDetail(
         domain: TErrorDomain;
         code: Integer;
         message: String
         ) : TErrorDetail;
var
  ErrorDetail : TErrorDetail;
begin
    ErrorDetail.domain := domain;
    ErrorDetail.code := code;
    ErrorDetail.message := message;

    Result := ErrorDetail;
end;

function AreSystemResponsesEquals(a, b: TSystemResponse): boolean;
begin
  Result := (a.success = b.success) and
            (a.code = b.code) and
            (a.title = b.title) and
            (a.message = b.message) and
            (a.data = b.data) and
            (AreErrorDetailsEquals(a.error, b.error));
end;

function AreErrorDetailsEquals(a, b: TErrorDetail): Boolean;
 begin
   Result := (a.domain = b.domain) and
             (a.code = b.code) and
             (a.message = b.message);
end;

end.  
