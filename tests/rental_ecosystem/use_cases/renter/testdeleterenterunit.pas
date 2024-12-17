unit TestDeleteRenterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, IRenterStorageUnit,
  DeleteRenterUnit, RenterUnit, RenterStorageUnit;

type

  TTestDeleteRenter = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecute;
  end;

implementation

procedure TTestDeleteRenter.TestExecute;
var
  RenterStorage: ITRenterStorage;
  DeleteRenter: TDeleteRenter;
  Renter: TRenter;
  Expected: string;
begin
  Renter := TRenter.Create('uid', 'test', 'test', '12345678', '123456789');

  RenterStorage := TRenterStorage.Create;
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  Expected := DeleteRenter.Execute(Renter.getId);

  AssertEquals(
    'When deleting a renter, it retuns right message',
    'The renter has been successfully deleted from the system.',
    Expected
    );
end;

procedure TTestDeleteRenter.SetUp;
begin

end;

procedure TTestDeleteRenter.TearDown;
begin

end;

initialization

  RegisterTest(TTestDeleteRenter);
end.
