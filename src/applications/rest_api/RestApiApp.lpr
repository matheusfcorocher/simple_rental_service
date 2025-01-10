program RestApiApp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}cthreads, cmem,{$ENDIF}
  SysUtils,
  fphttpapp,
  httpdefs,
  httproute,
  fpjson,
  jsonparser, GlobalVariablesUnit;

  procedure rentersEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    // Request
    RequestJSONData: TJSONData;
    JSONObject: TJSONObject;
    Id: String;

    //Response
    Response: TJSONObject;

  begin
    Response := TJSONObject.Create;
    try
      case aRequest.Method of
        'GET':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          //creating request data
          JSONObject := TJSONObject.Create;
          JSONObject.Add('id', Id);

          Response := RentalService.GetRenterController().Get(JSONObject);
        end;
        'POST':
        begin;
          // getting data from request body
          RequestJSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(RequestJSONData);

          Response := RentalService.GetRenterController().Register(JSONObject);
        end;
        'PUT':
        begin;
          // getting data from request body
          RequestJSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(RequestJSONData);

          Response := RentalService.GetRenterController().Update(JSONObject);
        end;
        'DELETE':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          //creating request data
          JSONObject := TJSONObject.Create;
          JSONObject.Add('id', Id);

          Response := RentalService.GetRenterController().Delete(JSONObject);
        end;
      end;

      aResponse.Content := Response.AsJSON;
      aResponse.ContentType := 'application/json';
      aResponse.SendContent;
    finally
      Response.Free;
    end;
  end;

  procedure vehiclesEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    // Request
    RequestJSONData: TJSONData;
    JSONObject: TJSONObject;
    Id: String;

    //Response
    Response: TJSONObject;

  begin
    Response := TJSONObject.Create;
    try
      case aRequest.Method of
        'GET':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          //creating request data
          JSONObject := TJSONObject.Create;
          JSONObject.Add('id', Id);

          Response := RentalService.GetVehicleController().Get(JSONObject);
        end;
        'POST':
        begin;
          // getting data from request body
          RequestJSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(RequestJSONData);

          Response := RentalService.GetVehicleController().Register(JSONObject);
        end;
        'PUT':
        begin;
          // getting data from request body
          RequestJSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(RequestJSONData);

          Response := RentalService.GetVehicleController().Update(JSONObject);
        end;
        'DELETE':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          //creating request data
          JSONObject := TJSONObject.Create;
          JSONObject.Add('id', Id);

          Response := RentalService.GetVehicleController().Delete(JSONObject);
        end;
      end;

      aResponse.Content := Response.AsJSON;
      aResponse.ContentType := 'application/json';
      aResponse.SendContent;
    finally
      Response.Free;
    end;
  end;

  procedure rentalsEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    // Request
    RequestJSONData: TJSONData;
    JSONObject: TJSONObject;
    Id: String;

    //Response
    Response: TJSONObject;
  begin
    Response := TJSONObject.Create;
    try
      case aRequest.Method of
        'GET':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          //creating request data
          JSONObject := TJSONObject.Create;
          JSONObject.Add('id', Id);

          Response := RentalService.GetRentalController().Get(JSONObject);
        end;
        'POST':
        begin;
          // getting data from request body
          RequestJSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(RequestJSONData);

          Response := RentalService.GetRentalController().Register(JSONObject);
        end;
        'PUT':
        begin;
          // getting data from request body
          RequestJSONData := GetJSON(ARequest.Content);

          JSONObject := TJSONObject(RequestJSONData);

          Response := RentalService.GetRentalController().Update(JSONObject);
        end;
        'DELETE':
        begin;
          // get from query params
          Id := ARequest.QueryFields.Values['id'];

          //creating request data
          JSONObject := TJSONObject.Create;
          JSONObject.Add('id', Id);

          Response := RentalService.GetRentalController().Delete(JSONObject);
        end;
      end;

      aResponse.Content := Response.AsJSON;
      aResponse.ContentType := 'application/json';
      aResponse.SendContent;
    finally
      Response.Free;
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
