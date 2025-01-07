unit JSONConvertersUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRenterUnit, RenterUnit;

function JSONToRenter(JSON : TJSONObject) : TRenter;
function JSONToRenterData(JSON : TJSONObject) : TRenterData;
function JSONToRenterId(JSON : TJSONObject) : String;

implementation

function JSONToRenter(JSON: TJSONObject): TRenter;
var
  Renter : TRenter;
begin
  result := TRenter.Create(
    JSON.Strings['id'],
    JSON.Strings['name'],
    JSON.Strings['address'],
    JSON.Strings['email'],
    JSON.Strings['telephone']
  );
end;

function JSONToRenterData(JSON : TJSONObject) : TRenterData;
var
  RenterData : TRenterData;
begin
  with RenterData do
  begin
    name := JSON.Strings['name'];
    address := JSON.Strings['address'];
    email :=  JSON.Strings['email'];
    telephone :=  JSON.Strings['telephone'];
  end;

  result := RenterData;
end;

function JSONToRenterId(JSON : TJSONObject) : String;
begin
  result := JSON.Strings['id']
end;

end.

