unit TestRenterControllerForConsoleApplicationUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, fpjson,
  jsonparser, RenterControllerUnit,
  RegisterRenterUnit, RenterStorageUnit, ConsolePresenterUnit;

type

  TTestRenterControllerOnConsoleApplication = class(TTestCase)
  private
    FRenterController: specialize TRenterController<string>;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegister;
  end;

implementation

procedure TTestRenterControllerOnConsoleApplication.TestRegister;
var
  RenterJSON: TJSONObject;
  ExpectedMessageLength: integer;
begin
  //Preparing test
  RenterJSON := TJSONObject.Create;

  RenterJSON.Add('name', 'Los');
  RenterJSON.Add('address', 'address');
  RenterJSON.Add('email', '12345678');
  RenterJSON.Add('telephone', '123456789');

  AssertEquals(
    'When calling register use case from controller, it returns right response',
    Length(FRenterController.RenterRegister(RenterJSON)),
    110
    );
end;

procedure TTestRenterControllerOnConsoleApplication.SetUp;
var
  RenterStorage: TRenterStorage;
  RegisterRenter: TRegisterRenter;
  ConsolePresenter: TConsolePresenter;
begin
  RenterStorage := TRenterStorage.Create();
  RegisterRenter := TRegisterRenter.Create(RenterStorage);
  ConsolePresenter := TConsolePresenter.Create();

  FRenterController := specialize TRenterController<string>.Create(
    RegisterRenter, ConsolePresenter);
end;

procedure TTestRenterControllerOnConsoleApplication.TearDown;
begin
  FRenterController.Free;
end;

initialization
  RegisterTest(TTestRenterControllerOnConsoleApplication);
end.
