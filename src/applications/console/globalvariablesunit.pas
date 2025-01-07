unit GlobalVariablesUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, AssembleRentalServiceUnit, RentalServiceContainerUnit;

var
  RentalService : specialize TRentalServiceContainer<String>;

implementation

initialization
  RentalService := AssembleRentalServiceOnConsole();
end.

