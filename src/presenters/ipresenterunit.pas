unit IPresenterUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RenterUnit, VehicleUnit, RentalUnit;

type
  generic ITPresenter<T> = interface
    function Present(Renter : TRenter) : T;
    function Present(Vehicle : TVehicle) : T; overload;
    function Present(Rental : TRental) : T; overload;
    function Present(message : String) : T; overload;
    function Present(error : Exception) : T; overload;
  end;

implementation

end.

