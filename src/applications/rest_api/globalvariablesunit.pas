unit GlobalVariablesUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, AssembleRentalServiceUnit, RentalServiceContainerUnit;

var
  RentalService : specialize TRentalServiceContainer<TJSONObject>;

implementation

initialization
  RentalService := AssembleRentalServiceOnWebApi();
end.

