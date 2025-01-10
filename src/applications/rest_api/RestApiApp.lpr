program RestApiApp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}cthreads, cmem,{$ENDIF}
  SysUtils,
  fphttpapp,
  httpdefs,
  httproute,
  fpjson,
  jsonparser;

  procedure rentersEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    // Request
    JSONData: TJSONData;
    JSONObject: TJSONObject;

    //Request Content
    Id: string;
    Name: string;
    Address: string;
    Email: string;
    Telephone: string;

    //Response
    ResponseJSONObject: TJSONObject;

  begin
    ResponseJSONObject := TJSONObject.Create;
    try
      case aRequest.Method of
        'GET':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'POST':
        begin;
          JSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(JSONData);

          Name := JSONObject.Get('name', '');

          Address := JSONObject.Get('address', '');
          Email := JSONObject.Get('email', '');
          Telephone := JSONObject.Get('telephone', '');

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation ' + Name + Address + Email + Telephone;
        end;
        'PUT':
        begin;
          JSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(JSONData);

          Id := JSONObject.Get('id', '');
          Name := JSONObject.Get('name', '');
          Address := JSONObject.Get('address', '');
          Email := JSONObject.Get('email', '');
          Telephone := JSONObject.Get('telephone', '');

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'DELETE':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
      end;

      aResponse.Content := ResponseJSONObject.AsJSON;
      aResponse.ContentType := 'application/json';
      aResponse.SendContent;
    finally
      ResponseJSONObject.Free;
    end;
  end;

  procedure vehiclesEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    // Request
    JSONData: TJSONData;
    JSONObject: TJSONObject;

    //JSON Content
    Id: string;
    Name: string;
    LicensePlate: string;
    Value: integer;
    Status: string;

    //Response
    ResponseJSONObject: TJSONObject;

  begin
    ResponseJSONObject := TJSONObject.Create;
    try
      case aRequest.Method of
        'GET':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation ' + Id + '.';
        end;
        'POST':
        begin;
          JSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(JSONData);

          Name := JSONObject.Get('name', '');
          LicensePlate := JSONObject.Get('licensePlate', '');
          Value := JSONObject.Get('value', 0);
          Status := JSONObject.Get('status', '');

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'PUT':
        begin;
          JSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(JSONData);

          Id := JSONObject.Get('id', '');
          Name := JSONObject.Get('name', '');
          LicensePlate := JSONObject.Get('licensePlate', '');
          Value := JSONObject.Get('value', 0);
          Status := JSONObject.Get('status', '');

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'DELETE':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation ' + Id + '.';
        end;
      end;

      aResponse.Content := ResponseJSONObject.AsJSON;
      aResponse.ContentType := 'application/json';
      aResponse.SendContent;
    finally
      ResponseJSONObject.Free;
    end;
  end;

  procedure rentalsEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    // Request
    JSONData: TJSONData;
    JSONObject: TJSONObject;

    //Request Content
    Id: string;
    RenterId: string;
    VehicleId: string;
    StartDate: string;
    EndDate: string;

    //Response
    ResponseJSONObject: TJSONObject;
  begin
    ResponseJSONObject := TJSONObject.Create;
    try
      case aRequest.Method of
        'GET':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'POST':
        begin;
          JSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(JSONData);

          RenterId := JSONObject.Get('renter_id', '');
          VehicleId := JSONObject.Get('vehicle_id', '');
          StartDate := JSONObject.Get('start_date', '');
          EndDate := JSONObject.Get('end_date', '');

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'PUT':
        begin;
          JSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(JSONData);

          Id := JSONObject.Get('id', '');
          RenterId := JSONObject.Get('renter_id', '');
          VehicleId := JSONObject.Get('vehicle_id', '');
          StartDate := JSONObject.Get('start_date', '');
          EndDate := JSONObject.Get('end_date', '');

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
        'DELETE':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          ResponseJSONObject.Booleans['success'] := True;
          ResponseJSONObject.Strings['message'] := 'This need implementation';
        end;
      end;

      aResponse.Content := ResponseJSONObject.AsJSON;
      aResponse.ContentType := 'application/json';
      aResponse.SendContent;
    finally
      ResponseJSONObject.Free;
    end;
  end;

  procedure homeRoute(aRequest: TRequest; aResponse: TResponse);
  begin
    aResponse.Content := 'This is Simple Service API home.';
    aResponse.ContentType := 'text/plain';
    aResponse.SendContent;
  end;

begin
  HTTPRouter.RegisterRoute('/renters', @rentersEndpoint);
  HTTPRouter.RegisterRoute('/vehicles', @vehiclesEndpoint);
  HTTPRouter.RegisterRoute('/rentals', @rentalsEndpoint);
  HTTPRouter.RegisterRoute('/', @homeRoute, True);

  Application.Port := 8080;
  Application.Threaded := True;
  Application.Initialize;
  WriteLn('Server is ready at http://localhost:' + IntToStr(Application.Port));
  Application.Run;
end.
