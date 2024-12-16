unit RenterDTOUnit;

{$mode objfpc}{$H+}

interface

type
  TRenterDTO = record
    id: string;
    name: string;
    address: string;
    email: string;
    telephone: string;

  end;

function CreateRenterDTO(Aid: string; Aname: string; Aaddress: string;
    Aemail: string; Atelephone: string): TRenterDTO;

function AreRenterDTOsEquals(a, b : TRenterDTO): Boolean;

implementation

function CreateRenterDTO(Aid: string; Aname: string; Aaddress: string;
  Aemail: string; Atelephone: string): TRenterDTO;
var
  RenterDTO: TRenterDTO;
begin
  RenterDTO.id := Aid;
  RenterDTO.Name := Aname;
  RenterDTO.address := Aaddress;
  RenterDTO.email := Aemail;
  RenterDTO.telephone := Atelephone;

  Result := RenterDTO;
end;

function AreRenterDTOsEquals(a, b : TRenterDTO): Boolean;
begin
  Result := (a.id = b.id) and
            (a.name = b.name) and
            (a.address = b.address) and
            (a.email = b.email) and
            (a.telephone = b.telephone)
end;

end.
