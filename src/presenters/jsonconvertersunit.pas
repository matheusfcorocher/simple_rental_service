unit JSONConvertersUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, RegisterRenterUnit;

function RenterJSONToData(RenterJSON : TJSONObject) : TRenterData;

implementation

function RenterJSONToData(RenterJSON : TJSONObject) : TRenterData;
var
  RenterData : TRenterData;
begin
  with RenterData do
  begin
    name := RenterJSON.Strings['name'];
    address := RenterJSON.Strings['address'];
    email :=  RenterJSON.Strings['email'];
    telephone :=  RenterJSON.Strings['telephone'];
  end;

  result := RenterData;
end;

end.

