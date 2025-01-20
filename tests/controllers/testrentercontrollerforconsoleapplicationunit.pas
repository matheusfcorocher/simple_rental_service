unit TestRenterControllerForConsoleApplicationUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, fpjson,
  jsonparser, RenterControllerUnit,
  RegisterRenterUnit, UpdateRenterUnit, GetRenterUnit, DeleteRenterUnit,
  RenterStorageUnit, ConsolePresenterUnit, RenterBuilderUnit, RenterExceptionsCreatorENUnit;

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
begin
  //Preparing test
  RenterJSON := TJSONObject.Create;

  RenterJSON.Add('name', 'Los');
  RenterJSON.Add('address', 'address');
  RenterJSON.Add('email', '12345678');
  RenterJSON.Add('telephone', '123456789');

  AssertEquals(
    'When calling register use case from controller, it returns right response',
    Length(FRenterController.Register(RenterJSON)),
    110
  );
end;

procedure TTestRenterControllerOnConsoleApplication.SetUp;
var
  RenterExceptionsCreator: TRenterExceptionsCreatorEN;
  RenterBuilder: TRenterBuilder;

  RenterStorage: TRenterStorage;

  RegisterRenter: TRegisterRenter;
  UpdateRenter: TUpdateRenter;
  GetRenter: TGetRenter;
  DeleteRenter: TDeleteRenter;

  ConsolePresenter: TConsolePresenter;
begin
  RenterExceptionsCreator := TRenterExceptionsCreatorEN.Create;
  RenterBuilder := TRenterBuilder.Create(RenterExceptionsCreator);

  RenterStorage := TRenterStorage.Create(RenterExceptionsCreator);

  RegisterRenter := TRegisterRenter.Create(RenterBuilder, RenterStorage);

  UpdateRenter := TUpdateRenter.Create(RenterStorage, RenterBuilder);
  GetRenter := TGetRenter.Create(RenterStorage);
  DeleteRenter := TDeleteRenter.Create(RenterStorage);

  ConsolePresenter := TConsolePresenter.Create();

  FRenterController := specialize TRenterController<string>.Create(
    RegisterRenter, UpdateRenter, GetRenter, DeleteRenter, ConsolePresenter);
end;

procedure TTestRenterControllerOnConsoleApplication.TearDown;
begin
  FRenterController.Free;
end;

initialization
  RegisterTest(TTestRenterControllerOnConsoleApplication);
end.
