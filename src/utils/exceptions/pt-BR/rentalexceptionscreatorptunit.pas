unit RentalExceptionsCreatorPTUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IRentalExceptionsCreatorUnit, RentalServiceExceptionsUnit;

type
  TRentalExceptionsCreatorPT = class(TInterfacedObject, ITRentalExceptionsCreator)
    public
      procedure CreateRangeRentalDateException;
      procedure CreateNotFoundRentalException(id: string);
  end;


implementation

procedure TRentalExceptionsCreatorPT.CreateRangeRentalDateException;
begin
  Raise RangeRentalDateException.Create('O intervalo de datas de aluguel é inválido, por favor verifique se a data de início é anterior à data de término.');
end;

procedure TRentalExceptionsCreatorPT.CreateNotFoundRentalException(id: string);
begin
  Raise NotFoundRentalException.Create('O aluguel com id ' + id + ' não foi encontrado.');
end;

end.

