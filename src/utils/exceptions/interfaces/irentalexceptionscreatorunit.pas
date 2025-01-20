unit IRentalExceptionsCreatorUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  ITRentalExceptionsCreator = interface
    procedure CreateRangeRentalDateException;
    procedure CreateNotFoundRentalException(id: string);
  end;

implementation

end.

