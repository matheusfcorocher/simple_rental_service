unit TestDeleteRentalUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, fpcunit, testregistry, RentalUnit, VehicleUnit, VehicleStatusUnit,
  IRentalStorageUnit, FakeRentalStorageUnit, DeleteRentalUnit;

type

  TTestDeleteRental = class(TTestCase)
  published
    procedure TestExecute;
  end;

implementation

procedure TTestDeleteRental.TestExecute;
var
  RentalStorage: ITRentalStorage;
  DeleteRental: TDeleteRental;
  StartDate, EndDate: TDateTime;
  Vehicle: TVehicle;
  Rental: TRental;
  Expected: String;
begin
  StartDate := EncodeDate(2024, 12, 1);
  EndDate := EncodeDate(2024, 12, 31);
  Vehicle := TVehicle.Create('vehicle_uuid', 'corsa', 'MACLOVIN', 20000, AVAILABLE);

  Rental := TRental.Create('rental_uuid', 'renter_uuid', Vehicle, StartDate, EndDate);

  RentalStorage := TFakeRentalStorage.Create;
  DeleteRental := TDeleteRental.Create(RentalStorage);

  Expected := DeleteRental.Execute(Rental.getId);

  AssertEquals(
    'When deleting a rental, it retuns right message',
    'The rental has been successfully deleted from the system.',
    Expected
    );
end;

initialization
  RegisterTest(TTestDeleteRental);
end.
