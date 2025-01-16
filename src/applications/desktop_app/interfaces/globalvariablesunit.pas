unit GlobalVariablesUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, jsonparser, fpjson, AssembleRentalServiceUnit, RentalServiceContainerUnit;

var
  RentalService : specialize TRentalServiceContainer<TJSONObject>;

implementation

initialization
  RentalService := AssembleRentalServiceOnWebApi();
end.
