unit RenterStorageBuilderUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterExceptionsCreatorUnit, RenterStorageUnit;

type

  { TRenterStorageBuilder }

  TRenterStorageBuilder = class

  private
    _RenterExceptionsCreator : ITRenterExceptionsCreator;

  public
    constructor Create(RenterExceptionsCreator : ITRenterExceptionsCreator);
    function Build() : TRenterStorage;

  end;

implementation

constructor TRenterStorageBuilder.Create(
  RenterExceptionsCreator: ITRenterExceptionsCreator);
begin
  _RenterExceptionsCreator := RenterExceptionsCreator;
end;

function TRenterStorageBuilder.Build() : TRenterStorage;
begin
  result := TRenterStorage.Create(_RenterExceptionsCreator);
end;

end.
