unit RenterBuilderUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, IRenterExceptionsCreatorUnit;

type

  { TRenterBuilder }

  TRenterBuilder = class

  private
    _RenterExceptionsCreator : ITRenterExceptionsCreator;

  public
    constructor Create(RenterExceptionsCreator : ITRenterExceptionsCreator);
    function Build(id: string; Name: string; address: string;
  email: string; telephone: string) : TRenter;

  end;
implementation

constructor TRenterBuilder.Create(
  RenterExceptionsCreator: ITRenterExceptionsCreator);
begin
  _RenterExceptionsCreator := RenterExceptionsCreator;
end;

function TRenterBuilder.Build(id: string; Name: string; address: string;
  email: string; telephone: string) : TRenter;
begin
  result := TRenter.Create(id, name, address, email, telephone, _RenterExceptionsCreator);
end;

end.


